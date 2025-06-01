import 'package:flutter_coffee/app/routes.dart';
import 'package:flutter_coffee/data/remote/models/request/Post_base_request.dart';
import 'package:flutter_coffee/data/remote/models/response/Category_response.dart';
import 'package:flutter_coffee/data/remote/models/response/Product_response.dart';
import 'package:flutter_coffee/data/remote/repositories/impl/article_repository_impl.dart';
import 'package:flutter_coffee/enum/status.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomeViewModel extends GetxController {
  var articleRepo = ArticleRepositoryImpl();
  var loadingCategoryStatus = Status.loading.obs;
  var loadingProductStatus = Status.loading.obs;
  var categoriesList = <CategoryResponse>[].obs;
  var productsList = <ProductResponse>[].obs;
  var cartItemCount = 0.obs;

  setLoadingCategory(Status value)=> loadingCategoryStatus = value.obs;
  setLoadingProduct(Status value) => loadingProductStatus = value.obs;

  @override
  void onInit() {
    getAllCategories();
    getAllProducts();
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
      if (response.isSuccess && response.body != null) {
        categoriesList.clear();
        (response.body as List).forEach((data) {
          categoriesList.add(CategoryResponse.fromJson(data));
        });
        setLoadingCategory(Status.success);
      } else {
        setLoadingCategory(Status.error);
      }
    }catch(e){
      setLoadingCategory(Status.error);
    }
  }

  getAllProducts() async {
    try {
      setLoadingProduct(Status.loading);
      var req = PostBaseRequest();
      var response = await articleRepo.getAllProducts(req);
      if (response.isSuccess && response.body != null) {
        productsList.clear();
        (response.body as List).forEach((data) {
          productsList.add(ProductResponse.fromJson(data));
        });
        setLoadingProduct(Status.success);
      } else {
        setLoadingProduct(Status.error);
      }
    } catch(e) {
      setLoadingProduct(Status.error);
    }
  }
}