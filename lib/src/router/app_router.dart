
import 'package:chatapp/src/presentations/auth/bindings/auth_bindings.dart';
import 'package:chatapp/src/presentations/auth/login_screen.dart';
import 'package:chatapp/src/presentations/auth/register_screen.dart';
import 'package:chatapp/src/presentations/chatbox/bindings/chatbox_binding.dart';
import 'package:chatapp/src/presentations/chatbox/chatbox_screen.dart';
import 'package:chatapp/src/presentations/home/bindings/home_bindings.dart';
import 'package:chatapp/src/presentations/home/home_screen.dart';
import 'package:chatapp/src/presentations/setting/setting_screen.dart';
import 'package:chatapp/src/presentations/tabs/bindings/tabbar_bindings.dart';
import 'package:chatapp/src/presentations/tabs/tabbar.dart';
import 'package:get/get.dart';

class AppRouter {
  static const loginScreen = "/login";
  static const registerScreen = "/register";
  static const homeScreen = "/home";
  static const settingScreen = "/setting";
  static const tabScreen = "/tab";
  static const chatboxScreen = "/chatbox";
  static List<GetPage> pages = [
    GetPage(name: loginScreen, page: () => const LoginScreen(), bindings: [
      AuthBindings(),
    ]),
    GetPage(name: registerScreen, page: () => const RegisterScreen(), bindings: [
      AuthBindings(),
    ]),
    GetPage(name: homeScreen, page: () => const HomeScreen(), bindings: [
      HomeBindings(),
    ]),
    GetPage(name: settingScreen, page: () => const SettingScreen(), bindings: [

    ]),
    GetPage(name: tabScreen, page: () => const AppTabBar(), bindings: [
      TabBarBindings(),
    ]),
    GetPage(name: chatboxScreen, page: () => const ChatBoxScreen(), bindings: [
      ChatBoxBindings(),
    ]),
  ];
}