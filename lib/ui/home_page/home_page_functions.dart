part of 'home_page.dart';

class HomePageFunctions {
  static List<BoardModel> getColumns(MoIndicators? moIndicators) {
    final List<BoardModel> columns = [];
    for (Row_ row in moIndicators?.data?.rows ?? []) {
      int parentId = row.parentId!;
      // Проверяем, есть ли уже список для этого parentId
      var column = columns.firstWhere(
          (col) => (col.tasks?.isNotEmpty ?? false) && col.boardId == parentId,
          orElse: () => BoardModel());
      if (column.boardId == null) {
        // Если нет, создаем новый список и добавляем его в columns
        column =
            BoardModel(boardId: parentId, boardName: row.parentName, tasks: []);
        columns.add(column);
      }
      // Добавляем строку в соответствующий список
      column.tasks?.add(row);
    }
    return columns;
  }

  static void _showSnackBar(BuildContext context, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: isError ? Colors.red[300] : Colors.lightGreen[300],
        duration: const Duration(seconds: 1),
        content: Row(
          children: [
            Icon(
                isError
                    ? CupertinoIcons.xmark_circle_fill
                    : CupertinoIcons.checkmark_alt_circle_fill,
                color: Colors.white),
            const SizedBox(width: 10),
            Text(
                isError
                    ? 'Не удалось переместить задачу'
                    : 'Задача успешно перемещена!',
                style: const TextStyle(color: Colors.white))
          ],
        ),
      ),
    );
  }

  static Future setItemPosition(
    int? listIndex,
    int? itemIndex,
    int? oldListIndex,
    int? oldItemIndex,
    BoardItemState state,
    WidgetRef ref,
    BuildContext context,
  ) async {
    if (listIndex != oldListIndex || itemIndex != oldItemIndex) {
      final boardNotifier = ref.read(River.boardPod.notifier);
      final boardPod = ref.watch(River.boardPod);
      try {
        boardNotifier.setPosition(
            listIndex!, itemIndex!, oldListIndex!, oldItemIndex!);
        final newPos = boardPod.columns?[listIndex].tasks?[itemIndex];
        await ref
            .read(River.boardPod.notifier)
            .saveIndicators(
              RequestBody(
                periodStart: DateTime(2023, 09, 30),
                periodEnd: DateTime(2024, 01, 31),
                periodKey: 'month',
                authUserId: 2,
                fieldName1: 'parent_id',
                fieldValue1: newPos?.parentId,
                fieldName2: 'order',
                fieldValue2: itemIndex + 1,
                indicatorToMoId: newPos?.indicatorToMoId,
              ),
            )
            .then((v) {
          if (context.mounted) {
            _showSnackBar(context);
          }
        });
      } catch (e) {
        if (context.mounted) {
          boardNotifier.setPosition(
              oldListIndex!, oldItemIndex!, listIndex!, itemIndex!);

          _showSnackBar(context, isError: true);
        }
      }
    }
  }
}
