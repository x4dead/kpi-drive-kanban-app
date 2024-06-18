import 'package:kpi_drive_kanban_app/models/models.dart';

class BoardStateRef {
  final MoIndicators? moIndicators;
  final List<BoardModel>? columns;

  BoardStateRef({
    this.moIndicators,
    this.columns,
  });
  BoardStateRef copyWith(
      {MoIndicators? moIndicators, List<BoardModel>? columns}) {
    return BoardStateRef(
      moIndicators: moIndicators ?? this.moIndicators,
      columns: columns ?? this.columns,
    );
  }
}
