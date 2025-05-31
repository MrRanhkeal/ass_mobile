import 'package:flutter_coffee/data/remote/models/request/Post_base_request.dart';
import 'package:flutter_coffee/data/remote/models/response/base_body_response.dart';

abstract class ArticleRepository {
  Future<BaseBodyResponse> getAllCategories(PostBaseRequest req);
  Future<BaseBodyResponse> getAllProducts(PostBaseRequest req);
  Future<BaseBodyResponse> getAllSuppliers(PostBaseRequest req);
  Future<BaseBodyResponse> createSupplier(PostBaseRequest req);
  Future<BaseBodyResponse> updateSupplier(PostBaseRequest req);
  Future<BaseBodyResponse> deleteSupplier(PostBaseRequest req);
}