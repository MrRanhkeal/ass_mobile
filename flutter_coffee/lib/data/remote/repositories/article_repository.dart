import 'package:flutter_coffee/data/remote/models/request/Post_base_request.dart';
import 'package:flutter_coffee/data/remote/models/response/Base_body_response.dart';

abstract class ArticleRepository {
  Future<BaseBodyResponse> getAllCategories(PostBaseRequest req);
}