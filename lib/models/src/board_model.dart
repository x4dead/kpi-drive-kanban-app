import 'package:kpi_drive_kanban_app/models/models.dart';

class BoardModel {
  final List<Task>? tasks;
  final int? boardId;
  final String? boardName;
  BoardModel({
    this.tasks,
    this.boardId,
    this.boardName,
  });

  BoardModel copyWith({
    List<Task>? tasks,
    int? boardId,
    String? boardName,
  }) {
    return BoardModel(
        tasks: tasks ?? this.tasks,
        boardId: boardId ?? this.boardId,
        boardName: boardName ?? this.boardName);
  }
}
