import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roboeducacional/features/block/domain/block_entity.dart';
import 'package:roboeducacional/features/block/domain/wrapper_entity.dart';
import 'package:roboeducacional/features/block/presentation/pages/bloc/widgets/block_library/cubit/block_library_cubit.dart';
import 'package:roboeducacional/features/block/presentation/pages/blocks_line_page.dart';

class BlocksLibrary extends StatelessWidget {
  const BlocksLibrary({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BlockLibraryCubit, BlockLibraryState>(
      builder: (context, state) {
        if (!state.isLibraryOpen) {
          return const SizedBox();
        }
        return const Positioned.fill(
          child: Stack(
            children: [
              _Background(),
              _BottomSheetLibrary(),
            ],
          ),
        );
      },
    );
  }
}

class _Background extends StatelessWidget {
  const _Background();

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: GestureDetector(
        onTap: () => context.read<BlockLibraryCubit>().closeLibrary(),
        child: Container(
          color: Colors.black38,
        ),
      ),
    );
  }
}

class _BottomSheetLibrary extends StatelessWidget {
  const _BottomSheetLibrary();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: constraints.maxHeight * 0.5,
          width: constraints.maxWidth,
          padding: const EdgeInsets.all(10.0),
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 4,
                offset: Offset(-3, 0),
              )
            ],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: const _TabView(),
        ),
      );
    });
  }
}

class _TabView extends StatelessWidget {
  const _TabView();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: blockLibrary.keys.length,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 5),
              height: 60,
              child: Column(
                children: [
                  TabBar(
                    isScrollable: true,
                    indicatorPadding: const EdgeInsets.only(
                      top: 0,
                      right: -9,
                      left: 0,
                      bottom: 8,
                    ),
                    indicator: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Color(0xFF2E9AD1),
                          width: 2.5,
                        ),
                      ),
                    ),
                    indicatorSize: TabBarIndicatorSize.label,
                    labelStyle: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                    tabs: _createTabs(blockLibrary.keys.toList()),
                  ),
                ],
              ),
            ),
            // _createTabViews(blocos).first
            Expanded(
                child: TabBarView(
                    children: _createTabViews(blockLibrary, context)))
          ],
        ));
  }
}

List<Widget> _createTabs(List keys) {
  return keys
      .map(
        (e) => Tab(
            child: Text(_uppercaseFirstLetter(e),
                style: const TextStyle(color: Colors.black))),
      )
      .toList();
}

_uppercaseFirstLetter(String value) =>
    value[0].toUpperCase() + value.substring(1);

List<Widget> _createTabViews(
    Map<String, List<Map<String, dynamic>>> blockLibrary, context) {
  final keys = blockLibrary.keys;

  final list = keys
      .map(
        (e) => blockLibrary[e]!.map((entry) {
          if (e == 'controladores') {
            const RepeaterEntity repeaterEntity = RepeaterEntity(
              title: "Repetidor",
            );

            return BlocBuilder<BlockLibraryCubit, BlockLibraryState>(
                builder: (context, state) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 110,
                          width: 215,
                          child: Column(
                            children: [
                              Expanded(
                                child: Draggable(
                                  data: repeaterEntity,
                                  feedback: const SizedBox(
                                    height: 110,
                                    child: RepeaterWidget(
                                      subList: repeaterEntity,
                                    ),
                                  ),
                                  onDragStarted: () => context
                                      .read<BlockLibraryCubit>()
                                      .closeLibrary(),
                                  child: const RepeaterWidget(
                                    subList: repeaterEntity,
                                  ),
                                ),
                              ),
                              Text(
                                repeaterEntity.title,
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                        ),
                      ],
                    ));
          }
          final BlockEntity blockEntity = BlockEntity.fromMap(entry);
          return BlocBuilder<BlockLibraryCubit, BlockLibraryState>(
            builder: (context, state) {
              return Column(
                children: [
                  Draggable(
                    data: BlockEntity.fromMap(entry),
                    feedback: BlockWidget.halfOpacity(
                      block: BlockEntity.fromMap(entry),
                    ),
                    onDragStarted: () =>
                        context.read<BlockLibraryCubit>().closeLibrary(),
                    child: BlockWidget(
                      block: blockEntity,
                      size: 80,
                    ),
                  ),
                  Text(
                    BlockEntity.fromMap(entry).title,
                    textAlign: TextAlign.center,
                  )
                ],
              );
            },
          );
        }).toList(),
      )
      .toList();

  final gridList = [
    GridView.count(
      crossAxisCount: 3,
      crossAxisSpacing: 15,
      mainAxisSpacing: 15,
      children: [...list[0]],
    ),
    ...list[1],
  ];

  return gridList;
}
