part of '../home_page.dart';

class BoardListHeader extends ConsumerWidget {
  const BoardListHeader(this.boardIndex, {super.key});
  final int boardIndex;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final boardPod = ref.watch(River.boardPod);
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              boardPod.columns?[boardIndex].boardName ?? '',
              style: theme.textTheme.titleLarge?.copyWith(color: Colors.white),
            ),
            SizedBox(
              height: 36,
              width: 36,
              child: Card(
                color: Colors.grey.shade800,
                child: Center(
                  child: Text(
                    boardPod.columns![boardIndex].tasks?.length.toString() ??
                        '',
                    style: TextStyle(color: Colors.grey.shade300),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
