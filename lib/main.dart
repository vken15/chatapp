import 'package:chatapp/src/core/utils/init_bindings.dart';
import 'package:chatapp/src/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      initialBinding:  InitialBindings(),
      initialRoute: AppRouter.tabScreen,
      getPages: AppRouter.pages,
    );
  }
}
