import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roboeducacional/features/block/domain/block_entity.dart';
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
        (e) => blockLibrary[e]!.map((e) {
          final BlockEntity blockEntity = BlockEntity.fromMap(e);
          return BlocBuilder<BlockLibraryCubit, BlockLibraryState>(
            builder: (context, state) {
              return Column(
                children: [
                  Draggable(
                    data: blockEntity,
                    feedback: BlockWidget.halfOpacity(
                      block: BlockEntity.fromMap(e),
                    ),
                    onDragStarted: () =>
                        context.read<BlockLibraryCubit>().closeLibrary(),
                    child: BlockWidget(
                      block: blockEntity,
                      size: 80,
                    ),
                  ),
                  Text(
                    blockEntity.title,
                    textAlign: TextAlign.center,
                  )
                ],
              );
            },
          );
        }).toList(),
      )
      .toList();

  final gridList = list
      .map((e) => GridView.count(
            crossAxisCount: 3,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            children: e.map((e) => e).toList(),
          ))
      .toList();

  return gridList;
}
