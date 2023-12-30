import 'dart:convert';

import 'package:chatapp/src/data/apiClient/user/user_client.dart';
import 'package:chatapp/src/data/models/user/user_info.dart';
import 'package:chatapp/src/router/app_router.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print('Title: ${message.notification?.title}');
  print('Body: ${message.notification?.body}');
  print('Payload: ${message.data}');
}

class FireBaseApi extends GetxService {
  final _firebaseMessaging = FirebaseMessaging.instance;

  final _androidChannel = const AndroidNotificationChannel(
    'high_importance_channel',
    'High_Importance_Notifications',
    description: 'This channel is used for important notifications',
    importance: Importance.defaultImportance,
  );
  final _localNotifications = FlutterLocalNotificationsPlugin();

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;
    var chatId = int.parse(message.data["chatId"]);
    print(chatId);
    UserInfo receiver = UserInfo(
        id: int.parse(message.data["receiverId"]),
        fullName: message.data["fullName"],
        photo: message.data["photo"],
        lastOnline: message.data["lastOnline"]);
    print('${receiver.id} ${receiver.fullName} ${receiver.photo} ${receiver.lastOnline}');
    Get.toNamed(
      AppRouter.chatboxScreen,
      arguments: {
        'title': message.notification!.title,
        'id': chatId,
        'photo': "",
        'receiver': receiver,
      },
    );
    //Get.toNamed(AppRouter.settingScreen);
  }

  Future initLocalNotifications() async {
    const android = AndroidInitializationSettings('@drawable/chat_icon');
    const settings = InitializationSettings(android: android);

    await _localNotifications.initialize(settings,
        onSelectNotification: (payload) {
      final message = RemoteMessage.fromMap(jsonDecode(payload!));
      handleMessage(message);
    });

    final platform = _localNotifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await platform?.createNotificationChannel(_androidChannel);
  }

  Future initPushNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      print('TERMINATED');
    });
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      if (notification == null) return;
      _localNotifications.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            _androidChannel.id,
            _androidChannel.name,
            channelDescription: _androidChannel.description,
            icon: '@drawable/chat_icon',
          ),
        ),
        payload: jsonEncode(message.toMap()),
      );
    });
  }

  Future<void> saveTokenToDatabase(String token) async {
    try {
      var client = UserClient();
      await client.storeToken(fCMToken: token);
    } catch (e) {
      print(e);
    }
  }

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    await saveTokenToDatabase(fCMToken!);
    _firebaseMessaging.onTokenRefresh.listen(saveTokenToDatabase);
    print('Token: $fCMToken');
    initPushNotifications();
    initLocalNotifications();
  }
}
