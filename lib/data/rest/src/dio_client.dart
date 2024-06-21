import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:kpi_drive_kanban_app/data/rest/src/url_constants.dart';
import 'custom_compute.dart';
import 'custom_interceptor.dart';

class RequestParams {
  final String url;
  final Map<String, dynamic>? queryParameters;
  final RootIsolateToken? token;
  final Object? data;
  final Options? options;

  RequestParams(
      {this.token,
      this.data,
      this.options,
      required this.url,
      required this.queryParameters});
}

class DioClient<T extends Object, K> {
  late Dio _dio;
  DioClient() {
    const timer = Duration(seconds: 20);
    _dio = Dio()
      ..options.baseUrl = restUrl
      ..options.connectTimeout = timer
      ..interceptors.add(const CustomInterceptor());
  }
  Future<Response<String>> _sendRequest(
    RequestParams params,
  ) async {
    BackgroundIsolateBinaryMessenger.ensureInitialized(params.token!);

    return await _dio.post<String>(params.url,
        data: params.data,
        queryParameters: params.queryParameters,
        options: params.options);
  }

  Dio get dio => _dio;

  Future<T> post<T>(String path,
      {Object? data,
      Map<String, dynamic>? queryParameters,
      Options? options}) async {
    final token = RootIsolateToken.instance;
    final params = RequestParams(
      token: token,
      url: path,
      queryParameters: queryParameters,
      data: data,
      options: options,
    );

    final response = await compute(_sendRequest, params);
    if (T == String) {
      return response.data! as T;
    } else {
      return await CustomCompute<T>().getCompute(response);
    }
  }
}
