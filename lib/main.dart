import 'package:chatapp/src/core/utils/init_bindings.dart';
import 'package:chatapp/src/data/apiClient/firebase/firebase_api.dart';
import 'package:chatapp/src/router/app_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FireBaseApi().initNotifications();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      //navigatorKey: Get.nestedKey(1),
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
      unknownRoute: AppRouter.pages[0],
    );
  }
}
