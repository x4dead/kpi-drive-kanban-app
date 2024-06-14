import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kpi_drive_kanban_app/modules/signal_service/board_ref/board_notifier.dart';
import 'package:kpi_drive_kanban_app/modules/signal_service/board_ref/board_state.dart';

class River {
  static final boardPod = StateNotifierProvider<BoardNotifier, BoardStateRef>(
      (ref) => BoardNotifier());
}
