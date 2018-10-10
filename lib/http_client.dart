import 'package:dio/dio.dart';
import 'package:wxm/env_config.dart';
import 'package:wxm/vm/main/common_model.dart';

//网络请求管理
class WxmHttpClient {
  static WxmHttpClient httpClient;
  Dio dio;

  WxmHttpClient._internal() {
    Options options = new Options(
        baseUrl: BuildConfig(environment).baseUrl,
        connectTimeout: 5000,
        receiveTimeout: 5000);
    dio = new Dio(options);
  }

  factory WxmHttpClient() {
    if (httpClient == null) {
      httpClient = new WxmHttpClient._internal();
    }
    return httpClient;
  }
}

bool isSuccessResponse(Response response) =>
    response.statusCode == 200 &&
    HttpResult.fromJson(response.data).httpSuccess;
