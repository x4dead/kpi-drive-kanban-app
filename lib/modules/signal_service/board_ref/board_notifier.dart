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
                periodStart: DateTime(2024, 05, 1),
                periodEnd: DateTime(2024, 05, 31),
                periodKey: 'month',
                authUserId: 2,
                behaviourKey: 'task',
                requestedMoId: 478,
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
    final item = list[oldListIndex]
        .tasks?[oldItemIndex]
        .copyWith(parentId: list[listIndex].boardId, order: itemIndex + 1);
    list[oldListIndex].tasks?.removeAt(oldItemIndex);
    list[listIndex].tasks?.insert(itemIndex, item!);
    state = state.copyWith(columns: list);
  }
}
