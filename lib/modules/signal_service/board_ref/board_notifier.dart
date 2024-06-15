import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kpi_drive_kanban_app/data/rest/rest_client.dart';
import 'package:kpi_drive_kanban_app/models/models.dart';
import 'package:kpi_drive_kanban_app/modules/signal_service/board_ref/board_state.dart';
import 'package:kpi_drive_kanban_app/ui/home_page/home_page.dart';

class BoardNotifier extends StateNotifier<BoardStateRef> {
  late final RestClient _restClient;
  BoardNotifier() : super(BoardStateRef()) {
    _restClient = RestClient();
  }
  Future getIndicators({RequestBody? requestBody}) async {
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
      final list = HomePageFunctions.getColumns(response);
      state = state.copyWith(moIndicators: response, columns: list);
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }

  Future saveIndicators(RequestBody requestBody) async {
    try {
      await _restClient.saveIndicator(requestBody: requestBody);
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }

  void setPosition(
      int listIndex, int itemIndex, int oldListIndex, int oldItemIndex) {
    final list = [...state.columns!];
    final item = list[oldListIndex][oldItemIndex];
    list[oldListIndex].removeAt(oldItemIndex);
    list[listIndex].insert(itemIndex, item);
    state = state.copyWith(columns: list);
  }
}
