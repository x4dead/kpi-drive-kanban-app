import 'dart:convert';

import 'package:dio/dio.dart';

class RequestBody {
  final DateTime? periodStart;
  final DateTime? periodEnd;
  final String? periodKey;
  final int? requestedMoId;
  final String? behaviourKey;
  final bool? withResult;
  final String? responseFields;
  final int? authUserId;
  final int? indicatorToMoId;
  final String? fieldName1;
  final int? fieldValue1;
  final String? fieldName2;
  final int? fieldValue2;

  RequestBody({
    this.periodStart,
    this.periodEnd,
    this.periodKey,
    this.requestedMoId,
    this.behaviourKey,
    this.withResult,
    this.responseFields,
    this.authUserId,
    this.indicatorToMoId,
    this.fieldName1,
    this.fieldValue1,
    this.fieldName2,
    this.fieldValue2,
  });

  RequestBody copyWith({
    DateTime? periodStart,
    DateTime? periodEnd,
    String? periodKey,
    int? requestedMoId,
    String? behaviourKey,
    bool? withResult,
    String? responseFields,
    int? authUserId,
    int? indicatorToMoId,
    String? fieldName1,
    int? fieldValue1,
    String? fieldName2,
    int? fieldValue2,
  }) =>
      RequestBody(
        periodStart: periodStart ?? this.periodStart,
        periodEnd: periodEnd ?? this.periodEnd,
        periodKey: periodKey ?? this.periodKey,
        requestedMoId: requestedMoId ?? this.requestedMoId,
        behaviourKey: behaviourKey ?? this.behaviourKey,
        withResult: withResult ?? this.withResult,
        responseFields: responseFields ?? this.responseFields,
        authUserId: authUserId ?? this.authUserId,
        indicatorToMoId: indicatorToMoId ?? this.indicatorToMoId,
        fieldName1: fieldName1 ?? this.fieldName1,
        fieldValue1: fieldValue1 ?? this.fieldValue1,
        fieldName2: fieldName2 ?? this.fieldName2,
        fieldValue2: fieldValue2 ?? this.fieldValue2,
      );

  String toJson() => json.encode(toMap());

  FormData toMapGetIndicators() => FormData.fromMap({
        "period_start":
            "${periodStart!.year.toString().padLeft(4, '0')}-${periodStart!.month.toString().padLeft(2, '0')}-${periodStart!.day.toString().padLeft(2, '0')}",
        "period_end":
            "${periodEnd!.year.toString().padLeft(4, '0')}-${periodEnd!.month.toString().padLeft(2, '0')}-${periodEnd!.day.toString().padLeft(2, '0')}",
        "period_key": periodKey,
        "requested_mo_id": requestedMoId,
        "behaviour_key": behaviourKey,
        "with_result": withResult,
        "response_fields": responseFields,
        "auth_user_id": authUserId,
      });
  FormData toMapSaveIndicator() => FormData.fromMap(
        {
          "period_start":
              "${periodStart!.year.toString().padLeft(4, '0')}-${periodStart!.month.toString().padLeft(2, '0')}-${periodStart!.day.toString().padLeft(2, '0')}",
          "period_end":
              "${periodEnd!.year.toString().padLeft(4, '0')}-${periodEnd!.month.toString().padLeft(2, '0')}-${periodEnd!.day.toString().padLeft(2, '0')}",
          "period_key": periodKey,
          "indicator_to_mo_id": indicatorToMoId,
          "field_name": fieldName1,
          "field_value": fieldValue1,
          // "field_name": fieldName2,
          // "field_value": fieldValue2,
          "auth_user_id": authUserId,
        },
      );

  Map<String, dynamic> toMap() => {
        "period_start":
            "${periodStart!.year.toString().padLeft(4, '0')}-${periodStart!.month.toString().padLeft(2, '0')}-${periodStart!.day.toString().padLeft(2, '0')}",
        "period_end":
            "${periodEnd!.year.toString().padLeft(4, '0')}-${periodEnd!.month.toString().padLeft(2, '0')}-${periodEnd!.day.toString().padLeft(2, '0')}",
        "period_key": periodKey,
        "requested_mo_id": requestedMoId,
        "behaviour_key": behaviourKey,
        "with_result": withResult,
        "response_fields": responseFields,
        "auth_user_id": authUserId,
        "indicator_to_mo_id": indicatorToMoId,
        "field_name1": fieldName1,
        "field_value1": fieldValue1,
        "field_name2": fieldName2,
        "field_value2": fieldValue2,
      };
}
