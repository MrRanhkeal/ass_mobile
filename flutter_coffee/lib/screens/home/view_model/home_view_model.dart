import 'package:flutter_coffee/app/routes.dart';
import 'package:flutter_coffee/data/remote/models/request/Post_base_request.dart';
import 'package:flutter_coffee/data/remote/models/response/Category_response.dart';
import 'package:flutter_coffee/data/remote/repositories/impl/article_repository_impl.dart';
import 'package:flutter_coffee/enum/status.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomeViewModel extends GetxController{
  var articleRepo = ArticleRepositoryImpl();
  var loadingCategoryStatus = Status.loading.obs;
  var categoriesList = <CategoryResponse>[].obs;

  setLoadingCategory(Status value)=> loadingCategoryStatus = value.obs;

  @override
  void onInit() {
    getAllCategories();
    super.onInit();
  }

  logout() async {
    var storage = GetStorage();
    await storage.remove("ACCESS_TOKEN");
    await  storage.remove("REFRESH_TOKEN");
    Get.offAndToNamed(RouteName.splashView);
  }

  getAllCategories() async {
    try {
      setLoadingCategory(Status.loading);
      var req = PostBaseRequest();
      var response = await articleRepo.getAllCategories(req);
      if (response.data != null) {
        response.data.forEach((data) {
          categoriesList.add(CategoryResponse.fromJson(data));
        });
        setLoadingCategory(Status.success);
      }
    }catch(e){
      setLoadingCategory(Status.error);
    }
  }
}