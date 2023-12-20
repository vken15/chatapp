
import 'package:chatapp/src/presentations/auth/bindings/auth_bindings.dart';
import 'package:chatapp/src/presentations/auth/login_screen.dart';
import 'package:chatapp/src/presentations/chatbox/bindings/chatbox_binding.dart';
import 'package:chatapp/src/presentations/chatbox/chatbox_screen.dart';
import 'package:chatapp/src/presentations/profile/bindings/change_photo_bindings.dart';
import 'package:chatapp/src/presentations/profile/change_photo_screen.dart';
import 'package:chatapp/src/presentations/register/bindings/register_bindings.dart';
import 'package:chatapp/src/presentations/register/register_screen.dart';
import 'package:chatapp/src/presentations/setting/bindings/darkmode_bindings.dart';
import 'package:chatapp/src/presentations/setting/bindings/setting_bindings.dart';
import 'package:chatapp/src/presentations/setting/darkmode_screen.dart';
import 'package:chatapp/src/presentations/setting/setting_screen.dart';
import 'package:chatapp/src/presentations/splash/bindings/splash_bindings.dart';
import 'package:chatapp/src/presentations/splash/splash_screen.dart';
import 'package:chatapp/src/presentations/tab/bindings/tabbar_bindings.dart';
import 'package:chatapp/src/presentations/tab/tabbar.dart';
import 'package:get/get.dart';

class AppRouter {
  static const splashScreen = "/splash";
  static const loginScreen = "/login";
  static const registerScreen = "/register";
  static const tabScreen = "/tab";
  //static const homeScreen = "/home";
  //static const profileScreen = "/profile";
  //static const imagePickerScreen = "/image";
  static const changePhotoScreen = "/profile-photo";
  static const chatboxScreen = "/chatbox";
  static const settingScreen = "/setting";
  static const darkmodeScreen = "/darkmode";
  static List<GetPage> pages = [
    GetPage(name: splashScreen, page: () => const SplashScreen(), bindings: [
      SplashBindings(),
    ]),
    GetPage(name: loginScreen, page: () => const LoginScreen(), bindings: [
      AuthBindings(),
    ]),
    GetPage(name: registerScreen, page: () => const RegisterScreen(), bindings: [
      RegisterBindings(),
    ]),
    GetPage(name: tabScreen, page: () => const AppTabBar(), bindings: [
      TabBarBindings(),
    ]),
    //GetPage(name: homeScreen, page: () => const HomeScreen()),
    //GetPage(name: imagePickerScreen, page: () => const ImagePickerScreen()),
    GetPage(name: changePhotoScreen, page: () => const ChangePhotoScreen(), bindings: [
      ChangePhotoBindings(),
    ]),
    GetPage(name: chatboxScreen, page: () => const ChatBoxScreen(), bindings: [
      ChatBoxBindings(),
    ]),
    GetPage(name: settingScreen, page: () => const SettingScreen(), bindings: [
      SettingBindings(),
    ]),
    GetPage(name: darkmodeScreen, page: () => const DarkModeSettingScreen(), bindings: [
      DarkModeSettingBindings(),
    ]),
  ];
}