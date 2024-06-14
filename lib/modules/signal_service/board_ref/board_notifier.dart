import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kpi_drive_kanban_app/data/rest/rest_client.dart';
import 'package:kpi_drive_kanban_app/models/models.dart';
import 'package:kpi_drive_kanban_app/modules/signal_service/board_ref/board_state.dart';

class BoardNotifier extends StateNotifier<BoardStateRef> {
  late final RestClient _restClient;
  BoardNotifier() : super(BoardStateRef()) {
    _restClient = RestClient();
  }
  Future getIndicators(RequestBody? requestBody) async {
    try {
      final response = await _restClient.getIndicators(
        requestBody: requestBody ??
            RequestBody(
                periodStart: DateTime(2023, 09, 30),
                periodEnd: DateTime(2024, 01, 31),
                periodKey: 'month',
                authUserId: 2,
                behaviourKey: 'task',
                requestedMoId: 476,
                withResult: false,
                responseFields:
                    'name,indicator_to_mo_id,parent_id,order,parent_name,description'),
      );
      state = state.copyWith(moIndicators: response);
    } catch (e) {
      rethrow;
    }
  }

  Future saveIndicators(RequestBody requestBody) async {
    try {
      await _restClient.saveIndicator(requestBody: requestBody);
    } catch (e) {
      rethrow;
    }
  }
}
