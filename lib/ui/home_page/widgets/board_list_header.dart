part of '../home_page.dart';

class BoardListHeader extends ConsumerWidget {
  const BoardListHeader(this.parentName, {super.key});
  final String parentName;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Text(
              parentName,
              style: theme.textTheme.titleLarge?.copyWith(color: Colors.white),
            ),
            Card(
                // child: Text(boardViewController
                //     .state.listStates[i].itemStates.length
                //     .toString()),
                )
          ],
        ),
      ),
    );
  }
}
