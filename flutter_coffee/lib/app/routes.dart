import 'package:flutter_coffee/screens/auth/login/view/login_view.dart';
import 'package:flutter_coffee/screens/auth/register/view/register_view.dart';
import 'package:flutter_coffee/screens/home/view/home_view.dart';
import 'package:flutter_coffee/screens/splash/view/splash_view.dart';
import 'package:flutter_coffee/screens/customer/view/customer_view.dart';
import 'package:flutter_coffee/screens/category/view/category_view.dart';
import 'package:flutter_coffee/screens/product/view/product_view.dart';
import 'package:flutter_coffee/screens/supplier/view/supplier_view.dart';
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
    GetPage(
      name: RouteName.customerView,
      page: () => CustomerView(),
      transition: Transition.cupertinoDialog,
    ),
    GetPage(
      name: RouteName.categoryView,
      page: () => CategoryView(),
      transition: Transition.cupertinoDialog,
    ),
    GetPage(
      name: RouteName.productView,
      page: () => ProductView(),
      transition: Transition.cupertinoDialog,
    ),
    GetPage(
      name: RouteName.supplierView,
      page: () => SupplierView(),
      transition: Transition.cupertinoDialog,
    )
  ];
}

class RouteName {
  static String splashView = "/splash";
  static String registerView = "/register";
  static String loginView = "/login";
  static String homeView = "/home";
  static String customerView = "/customer";
  static String categoryView = "/category";
  static String productView = "/product";
  static String supplierView = "/supplier";
}
