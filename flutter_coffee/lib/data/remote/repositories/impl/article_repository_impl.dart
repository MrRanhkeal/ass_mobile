import 'package:flutter_coffee/data/remote/api/api.dart';
import 'package:flutter_coffee/data/remote/models/request/Post_base_request.dart';
import 'package:flutter_coffee/data/remote/models/response/base_body_response.dart';
import 'package:flutter_coffee/data/remote/repositories/article_repository.dart';
import 'package:flutter_coffee/data/remote/services/base_api_service_impl.dart';

class ArticleRepositoryImpl extends ArticleRepository {
  var service = BaseApiServiceImpl();

  @override
  Future<BaseBodyResponse> getAllCategories(PostBaseRequest req) async {
    var response = await service.apiPostWithToken(Api.getAllCategoriesPath, req: req.toJson());
    return BaseBodyResponse.fromJson(response);
  }

  @override
  Future<BaseBodyResponse> getAllProducts(PostBaseRequest req) async {
    var response = await service.apiPostWithToken(Api.getAllProductsPath, req: req.toJson());
    return BaseBodyResponse.fromJson(response);
  }

  @override
  Future<BaseBodyResponse> getAllSuppliers(PostBaseRequest req) async {
    var response = await service.apiPostWithToken(Api.getAllSuppliersPath, req: req.toJson());
    return BaseBodyResponse.fromJson(response);
  }

  @override
  Future<BaseBodyResponse> createSupplier(PostBaseRequest req) async {
    var response = await service.apiPostWithToken(Api.createSupplierPath, req: req.toJson());
    return BaseBodyResponse.fromJson(response);
  }

  @override
  Future<BaseBodyResponse> updateSupplier(PostBaseRequest req) async {
    var response = await service.apiPostWithToken(Api.updateSupplierPath, req: req.toJson());
    return BaseBodyResponse.fromJson(response);
  }

  @override
  Future<BaseBodyResponse> deleteSupplier(PostBaseRequest req) async {
    var response = await service.apiPostWithToken(Api.deleteSupplierPath, req: req.toJson());
    return BaseBodyResponse.fromJson(response);
  }
}