import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:kpi_drive_kanban_app/models/models.dart';

class CustomCompute<T> {
  FutureOr<T> getCompute(Response<String> resp) async =>
      await compute(_parse, resp);

  T _parse(Response<String> resp) {
    final jsonData = jsonDecode(resp.data!);
    return _parseItem(jsonData);
  }

  T _parseItem(Map<String, dynamic> jsonData) {
    if (T == MoIndicators) {
      return MoIndicators.fromMap(jsonData) as T;
    } else {
      throw 'Error Parsing';
    }
  }
}
