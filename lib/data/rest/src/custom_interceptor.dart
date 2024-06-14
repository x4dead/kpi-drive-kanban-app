import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:kpi_drive_kanban_app/data/rest/src/url_constants.dart';
import 'package:kpi_drive_kanban_app/models/models.dart';

class CustomInterceptor extends Interceptor {
  const CustomInterceptor();

  static const appJson = 'application/json';
  static const multipart = 'multipart/form-data';
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.statusCode! ~/ 100 == 2) {
      return handler.next(response);
    } else {
      return handler.reject(DioException(
          requestOptions: RequestOptions(),
          response: response,
          error: 'Произошла ошибка при выполнении запроса',
          type: DioExceptionType.badResponse));
    }
  }

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final headersToken = {"Authorization": "Bearer $token"};

    options.headers = headersToken;
    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final error = handleError('Произошла ошибка при выполнении запроса', err);
    final dioError =
        DioException(requestOptions: err.requestOptions, message: error);
    return handler.reject(dioError);
  }

  String handleError(String message, dynamic error) {
    log("REST ERROR: $error");
    if (error is DioException) {
      String errorMessage = message;
      if (error.response != null) {
        final statusCode = error.response!.statusCode;
        final code = 'Код $statusCode:';
        final data = error.response?.data;
        final String? mes = data == null || !(data as String).contains('{')
            ? null
            : MoIndicators.fromJson(data).messages?.error?.first;
        errorMessage = switch (statusCode) {
          400 => mes ?? '$code Некорректный запрос',
          401 => mes ??
              '$code Неавторизованный доступ. Пожалуйста, введите правильные данные',
          403 => mes ?? '$code Доступ запрещен',
          404 => mes ?? '$code Запрашиваемый ресурс не найден',
          500 => mes ?? '$code Внутренняя ошибка сервера',
          _ => '$code Произошла ошибка при выполнении запроса'
        };
      } else if (error.type == DioExceptionType.connectionTimeout ||
          error.type == DioExceptionType.receiveTimeout) {
        errorMessage = 'Превышено время ожидания';
      } else if (error.type == DioExceptionType.cancel) {
        errorMessage = 'Запрос был отменен';
      } else if (error.type == DioExceptionType.connectionError) {
        errorMessage = 'Ошибка подключения к сети';
      }
      return errorMessage;
    }
    return message;
  }
}
