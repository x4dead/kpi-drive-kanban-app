import 'package:kpi_drive_kanban_app/models/models.dart';

class BoardStateRef {
  final MoIndicators? moIndicators;
  final List<List<Row_>>? columns;

  BoardStateRef({
    this.moIndicators,
    this.columns,
  });
  BoardStateRef copyWith(
      {MoIndicators? moIndicators, List<List<Row_>>? columns}) {
    return BoardStateRef(
      moIndicators: moIndicators ?? this.moIndicators,
      columns: columns ?? this.columns,
    );
  }
}
