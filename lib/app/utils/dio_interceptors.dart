import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:scrum_app/app/utils/keys.dart';

class DioInterceptors extends InterceptorsWrapper {
  final Dio _dio;
  final _store = GetStorage();

  //final AuthController _authController = AuthController.to;

  DioInterceptors(this._dio);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    String accessToken = _store.read(AppStorageKey.ACCESS_TOKEN);

    options.headers.addAll({HttpHeaders.authorizationHeader: accessToken});
    return super.onRequest(options, handler);
  }

  @override
  Future onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    return super.onResponse(response, handler);
  }

  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    return super.onError(err, handler);
  }
}
