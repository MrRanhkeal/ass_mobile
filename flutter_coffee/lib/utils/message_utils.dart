import 'package:get/get.dart';

class MessageUtils {

  static onMessageError(message) {
    Get.snackbar("Error", message);
  }

  static onMessageSuccess(message) {
    Get.snackbar("Succes", message);
  }

}