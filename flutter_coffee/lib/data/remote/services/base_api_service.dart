abstract class BaseApiService {
  Future<dynamic> apiPost(String url, {dynamic requestBody});
  Future<dynamic> apiPostWithToken(String url, {dynamic req});
}