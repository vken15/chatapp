
import 'package:chatapp/src/presentations/auth/bindings/auth_bindings.dart';
import 'package:chatapp/src/presentations/auth/login_screen.dart';
import 'package:chatapp/src/presentations/chatbox/bindings/chatbox_binding.dart';
import 'package:chatapp/src/presentations/chatbox/chatbox_screen.dart';
import 'package:chatapp/src/presentations/phonebook/bindings/friend_request_binding.dart';
import 'package:chatapp/src/presentations/phonebook/bindings/phonebook_binding.dart';
import 'package:chatapp/src/presentations/phonebook/friend_request_screen.dart';
import 'package:chatapp/src/presentations/profile/bindings/change_photo_bindings.dart';
import 'package:chatapp/src/presentations/profile/bindings/other_profile_binding.dart';
import 'package:chatapp/src/presentations/profile/change_photo_screen.dart';
import 'package:chatapp/src/presentations/profile/other_profile_screen.dart';
import 'package:chatapp/src/presentations/register/bindings/register_bindings.dart';
import 'package:chatapp/src/presentations/register/register_screen.dart';
import 'package:chatapp/src/presentations/search/bindings/search_bindings.dart';
import 'package:chatapp/src/presentations/search/search_screen.dart';
import 'package:chatapp/src/presentations/setting/bindings/setting_bindings.dart';
import 'package:chatapp/src/presentations/setting/darkmode_screen.dart';
import 'package:chatapp/src/presentations/setting/setting_screen.dart';
import 'package:chatapp/src/presentations/splash/bindings/splash_bindings.dart';
import 'package:chatapp/src/presentations/splash/splash_screen.dart';
import 'package:chatapp/src/presentations/home/bindings/home_bindings.dart';
import 'package:chatapp/src/presentations/home/home_screen.dart';
import 'package:get/get.dart';

class AppRouter {
  static const splashScreen = "/splash";
  static const loginScreen = "/login";
  static const registerScreen = "/register";
  static const homeScreen = "/home";
  static const searchScreen = "/search";
  //static const chatScreen = "/chat";
  static const friendRequestScreen = "/friend-request";
  //static const profileScreen = "/profile";
  static const otherProfileScreen = "/other-profile";
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
    GetPage(name: homeScreen, page: () => const AppTabBar(), bindings: [
      HomeBindings(),
      PhoneBookBindings(),
    ]),
    GetPage(name: friendRequestScreen, page: () => const FriendRequestScreen(), bindings: [
      FriendRequestBindings()
    ]),
    GetPage(name: searchScreen, page: () => const SearchScreen(), bindings: [
      SearchBindings(),
    ], transition: Transition.noTransition),
    GetPage(name: otherProfileScreen, page: () => const OtherProfileScreen(), bindings: [
      OtherProfileBindings(),
    ]),
    GetPage(name: changePhotoScreen, page: () => const ChangePhotoScreen(), bindings: [
      ChangePhotoBindings(),
    ]),
    GetPage(name: chatboxScreen, page: () => const ChatBoxScreen(), bindings: [
      ChatBoxBindings(),
    ]),
    GetPage(name: settingScreen, page: () => const SettingScreen(), bindings: [
      SettingBindings(),
    ]),
    GetPage(name: darkmodeScreen, page: () => const DarkModeSettingScreen()),
  ];
}