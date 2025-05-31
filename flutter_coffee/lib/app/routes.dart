import 'package:flutter_coffee/screens/auth/login/view/login_view.dart';
import 'package:flutter_coffee/screens/auth/register/view/register_view.dart';
import 'package:flutter_coffee/screens/home/view/home_view.dart';
import 'package:flutter_coffee/screens/splash/view/splash_view.dart';
import 'package:get/get.dart';

class Routes {
  final routes = [
    GetPage(
        name: RouteName.splashView,
        page: () => SplashView(),
        transition: Transition.leftToRightWithFade),
    GetPage(
      name: RouteName.registerView,
      page: () => RegisterView(),
      transition: Transition.leftToRightWithFade,
    ),
    GetPage(
        name: RouteName.loginView,
        page: () => LoginView(),
        transition: Transition.leftToRightWithFade),
    GetPage(
        name: RouteName.homeView,
        page: () => HomeView(),
        transition: Transition.cupertinoDialog),
  ];
}

class RouteName {
  static String splashView = "/splash";
  static String registerView = "/register";
  static String loginView = "/login";
  static String homeView = "/home";
}
