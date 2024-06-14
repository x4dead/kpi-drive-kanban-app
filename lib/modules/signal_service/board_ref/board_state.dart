import 'package:kpi_drive_kanban_app/models/models.dart';

class BoardStateRef {
  final MoIndicators? moIndicators;

  BoardStateRef({
    this.moIndicators,
  });
  BoardStateRef copyWith({MoIndicators? moIndicators}) {
    return BoardStateRef(moIndicators: moIndicators ?? this.moIndicators);
  }
}
