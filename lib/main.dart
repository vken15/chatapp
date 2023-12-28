import 'package:chatapp/src/core/utils/init_bindings.dart';
import 'package:chatapp/src/router/app_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseMessaging.instance.requestPermission(provisional: true);

  FirebaseMessaging.instance.getToken().then((value) {
    print("token: $value");
  });
  FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) {
    print("token $fcmToken");
  });

  //If app is in background
  FirebaseMessaging.onMessageOpenedApp.listen(
    (RemoteMessage message) async {
      print("onMessageOpenedApp $message");
      Get.toNamed(AppRouter.homeScreen);
    },
  );

  //If app is closed or terminiated
  FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
    if (message != null) {
      Get.toNamed(AppRouter.homeScreen);
    }
  });

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(const MainApp());
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("_firebaseMessagingBackgroundHandler: $message");
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          foregroundColor: Colors.white,
          titleTextStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500
          ),
          titleSpacing: 0,
        )
      ),
      darkTheme: ThemeData.dark(),
      initialBinding: InitialBindings(),
      initialRoute: AppRouter.splashScreen,
      getPages: AppRouter.pages,
    );
  }
}
