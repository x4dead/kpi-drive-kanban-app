import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kpi_drive_kanban_app/models/models.dart';
import 'package:kpi_drive_kanban_app/modules/signal_service/river/river.dart';
import 'package:kpi_drive_kanban_app/ui/home_page/widgets/flutter_boardview/board_item.dart';
import 'package:kpi_drive_kanban_app/ui/home_page/widgets/flutter_boardview/board_list.dart';
import 'package:kpi_drive_kanban_app/ui/home_page/widgets/flutter_boardview/boardview.dart';

part 'home_page_functions.dart';
part 'widgets/my_board.dart';
part 'widgets/board_item_card.dart';
part 'widgets/board_list_header.dart';

final getIndicators = FutureProvider(
    (ref) async => await ref.read(River.boardPod.notifier).getIndicators());

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageConsumerState();
}

class _HomePageConsumerState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    final moIndicators = ref.watch(River.boardPod).moIndicators;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(25, 25, 25, 1),
      appBar: AppBar(
        backgroundColor: Colors.grey[850],
        centerTitle: true,
        title: const Text(
          'Flutter Kanban',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
              onPressed: !ref.watch(getIndicators).isLoading
                  ? () {
                      ref.invalidate(getIndicators);
                    }
                  : null,
              icon: Icon(
                CupertinoIcons.refresh,
                color: !ref.watch(getIndicators).isLoading
                    ? Colors.grey.shade300
                    : Colors.grey.shade600,
              ))
        ],
      ),
      body: ref.watch(getIndicators).when(
          skipLoadingOnRefresh: false,
          skipLoadingOnReload: false,
          data: (data) {
            if (moIndicators?.data == null) {
              return const Text('Пусто');
            }
            return const MyBoard();
          },
          error: (e, stackTrace) => Center(
                child: Text(e.toString(), textAlign: TextAlign.center),
              ),
          loading: () => Center(
                  child: CupertinoActivityIndicator(
                color: Colors.grey.shade300,
              ))),
    );
  }
}
