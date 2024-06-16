part of '../home_page.dart';

class MyBoard extends ConsumerStatefulWidget {
  const MyBoard({super.key});

  @override
  ConsumerState<MyBoard> createState() => _MyBoardConsumerState();
}

class _MyBoardConsumerState extends ConsumerState<MyBoard> {
  // BoardViewController boardViewController = BoardViewController();

  @override
  Widget build(BuildContext context) {
    final boardPod = ref.watch(River.boardPod);
    List<BoardList> lists = List.generate(boardPod.columns?.length ?? 0, (i) {
      return BoardList(
        header: [BoardListHeader(i)],
        draggable: false,
        headerBackgroundColor: Colors.grey[850],
        boardView: BoardViewState(),
        backgroundColor: Colors.grey[850],
        items: List.generate(boardPod.columns![i].length, (itemIndex) {
          return BoardItem(
            item: BoardItemCard(
              boardPod.columns![i][itemIndex],
              // boardViewController
            ),
            onDropItem: (listIndex, itemIndex, oldListIndex, oldItemIndex,
                    state) async =>
                await HomePageFunctions.setItemPosition(listIndex, itemIndex,
                    oldListIndex, oldItemIndex, state, ref, context),
          );
        }),
      );
    });
    return BoardView(
      lists: lists,
      // boardViewController: boardViewController,
      dragDelay: 100,
      width: 300,
    );
  }
}
