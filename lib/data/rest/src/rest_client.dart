import 'dart:developer';
import 'package:kpi_drive_kanban_app/data/rest/rest_client.dart';
import 'package:kpi_drive_kanban_app/models/models.dart';

class RestClient extends DioClient {
  Future<MoIndicators> getIndicators({required RequestBody requestBody}) async {
    const String url = '/get_mo_indicators';

    try {
      log('getIndicators начало запроса');
      final response =
          await post<MoIndicators>(url, data: requestBody.toMapGetIndicators());

      log('getIndicators запрос завершен успешно');
      return response;
    } catch (e) {
      log('getIndicators запрос завершен с ошибкой\n$e');
      rethrow;
    }
  }

  Future<void> saveIndicator({required RequestBody requestBody}) async {
    const String path = '/save_indicator_instance_field';

    try {
      log('saveIndicator начало запроса');
      await post<String>(path, data: requestBody.toMapSaveIndicator());

      log('saveIndicator запрос завершен успешно');
    } catch (e) {
      log('saveIndicator запрос завершен с ошибкой\n$e');
      rethrow;
    }
  }
}
