import 'package:flutter_coffee/app/routes.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SplashViewModel extends GetxController{
  var loadingScreen = false.obs;
  @override
  void onInit() {
    getAccessToken();
    super.onInit();
  }

  getAccessToken() async {
    loadingScreen(true);
    Future.delayed(const Duration(seconds: 3));
    var storage = GetStorage();
    var accessToken = await storage.read("ACCESS_TOKEN");
    if(accessToken != null){
      Get.offAndToNamed(RouteName.homeView);
    }
    loadingScreen(false);

  }
}