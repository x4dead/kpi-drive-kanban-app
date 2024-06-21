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
            Flexible(
              child: Text(
                boardPod.columns?[boardIndex].boardName ?? '',
                style:
                    theme.textTheme.titleLarge?.copyWith(color: Colors.white),
              ),
            ),
            SizedBox(
              height: 36,
              width: 36,
              child: Card(
                color: Colors.grey.shade800,
                child: AnimatedSwitcher(
                  reverseDuration: Durations.long1,
                  duration: Durations.long1,
                  switchOutCurve: Curves.easeIn,
                  transitionBuilder: (child, animation) =>
                      FadeTransition(opacity: animation, child: child),
                  child: Center(
                    key: ValueKey<int>(
                        boardPod.columns![boardIndex].tasks?.length ?? 0),
                    child: Text(
                      boardPod.columns![boardIndex].tasks?.length.toString() ??
                          '0',
                      style: TextStyle(color: Colors.grey.shade300),
                    ),
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
