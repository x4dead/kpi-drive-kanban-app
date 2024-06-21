part of '../home_page.dart';

class MyBoard extends ConsumerStatefulWidget {
  const MyBoard({super.key});

  @override
  ConsumerState<MyBoard> createState() => _MyBoardConsumerState();
}

class _MyBoardConsumerState extends ConsumerState<MyBoard> {
  @override
  Widget build(BuildContext context) {
    final boardPod = ref.watch(River.boardPod);
    List<BoardList> lists = List.generate(boardPod.columns?.length ?? 0, (i) {
      return BoardList(
        header: [BoardListHeader(i)],
        draggable: false,
        headerBackgroundColor: Colors.grey[850],
        boardView: BoardViewState(),
        footer: Container(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Icon(
                Icons.add,
                color: Colors.grey.shade300,
              ),
              const SizedBox(width: 10),
              Text(
                'New Item',
                style: TextStyle(
                  color: Colors.grey.shade300,
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.grey[850],
        items:
            List.generate(boardPod.columns![i].tasks?.length ?? 0, (itemIndex) {
          return BoardItem(
            item: BoardItemCard(boardPod.columns![i].tasks![itemIndex]),
            onDropItem: (listIndex, itemIndex, oldListIndex, oldItemIndex,
                    state) async =>
                await HomePageFunctions.setItemPosition(listIndex, itemIndex,
                    oldListIndex, oldItemIndex, state, ref, context),
          );
        }),
      );
    });
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: BoardView(
        lists: lists,
        dragDelay: 100,
      ),
    );
  }
}
