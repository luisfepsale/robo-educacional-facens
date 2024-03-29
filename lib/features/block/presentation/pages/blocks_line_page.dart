import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:roboeducacional/features/block/domain/block_entity.dart';
import 'package:roboeducacional/features/block/domain/wrapper_entity.dart';
import 'package:roboeducacional/features/block/presentation/pages/bloc/blocks_in_line_bloc.dart';
import 'package:roboeducacional/features/block/presentation/pages/bloc/widgets/cupertino_number_picker/cupertino_number_picker.dart';
import 'package:roboeducacional/features/inspect/modal_block.dart';
import 'package:roboeducacional/features/inspect/modal_repeater.dart';

class BlocksInLine extends StatelessWidget {
  const BlocksInLine({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BlocksInLineBloc, BlocksInLineState>(
        builder: (context, state) {
      return const DraggableListOfBlocs();
    });
  }
}

class DraggableListOfBlocs extends StatelessWidget {
  const DraggableListOfBlocs({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BlocksInLineBloc, BlocksInLineState>(
      builder: (context, state) {
        final listOfBlocks = state.blocks;

        return Flexible(
          child: ListView.builder(
            itemCount: listOfBlocks.isEmpty ? 1 : listOfBlocks.length + 1,
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(20),
            itemBuilder: (context, index) {
              final newIndex = index - 1;
              Widget child;
              if (index == 0) {
                child = const _InitialBlock();
              } else if (listOfBlocks[newIndex] is RepeaterEntity) {
                child = _RepeaterBlock(newIndex);
              } else {
                child = DraggableBlock(
                  block: listOfBlocks[newIndex],
                  positionOnLine: newIndex,
                );
              }
              return Center(
                child: SizedBox(
                  height: 110,
                  child: child,
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class _RepeaterBlock extends StatelessWidget {
  const _RepeaterBlock(this.listIndex);
  final int listIndex;

  @override
  Widget build(BuildContext context) {
    RepeaterEntity subList =
        context.read<BlocksInLineBloc>().state.blocks[listIndex];

    final widget = RepeaterWidget(
      subList: subList,
      listIndex: listIndex,
    );
    return DragTarget(
      onAccept: (data) async {
        final bloc = context.read<BlocksInLineBloc>();
        if (data is BlockEntity) {
          final value = await CupertinoNumberPicket.show(context, data.value);

          bloc.add(BlocksInLineEventAddBlock(
            block: (data).copyWith(value: value),
            insertAfterId: subList.id,
          ));
        }
        if (data is RepeaterEntity) {
          final value = await CupertinoNumberPicket.show(context, data.value);

          bloc.add(BlocksInLineEventAddRepeater(
            repeaterEntity: data.copyWith(value: value),
            insertAfterId: subList.id,
          ));
        }
        if (data is int) {
          bloc.add(
            BlocksInLineEventChangePositions(
              blockTargetId: subList.id,
              blockId: data,
            ),
          );
        }
      },
      builder: (context, candidateData, rejectedData) {
        final r = GestureDetector(
          onLongPress: () {
            showDialog(
                context: context,
                builder: (context) => const ModalInspecaoRepeater());
          },
          child: Draggable(
            data: subList.id,
            feedback: SizedBox(height: 110, child: widget),
            childWhenDragging: Opacity(opacity: 0.5, child: widget),
            child: widget,
          ),
        );

        if (candidateData.isNotEmpty) {
          return Row(
            children: [
              r,
              const _PreviewBlock(),
            ],
          );
        } else {
          return r;
        }
      },
    );
  }
}

class _PreviewBlock extends StatelessWidget {
  const _PreviewBlock();

  @override
  Widget build(BuildContext context) {
    return SizedOverflowBox(
      alignment: Alignment.centerLeft,
      size: const Size(70, 0),
      child: SvgPicture.asset(
        'assets/preview.svg',
        width: 80,
      ),
    );
  }
}

class RepeaterWidget extends StatelessWidget {
  const RepeaterWidget({
    super.key,
    required this.subList,
    this.listIndex,
  });

  final RepeaterEntity subList;
  final int? listIndex;

  @override
  Widget build(BuildContext context) {
    final content = Container(
      decoration: const BoxDecoration(
        color: Color(0xFFFF8C00),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(8),
          bottomRight: Radius.circular(8),
        ),
        border: Border(
          bottom: BorderSide(width: 2, color: Color(0xFFA52E00)),
          top: BorderSide(width: 2, color: Color(0xFFA52E00)),
          right: BorderSide(width: 2, color: Color(0xFFA52E00)),
          left: BorderSide(width: 0, color: Color(0xFFA52E00)),
        ),
      ),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: subList.list.isNotEmpty && listIndex != null
                ? ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: subList.list.length,
                    itemBuilder: (context, index) => DraggableBlock(
                      shouldAcceptRepeater: false,
                      block: subList.list[index],
                      positionOnLine: listIndex!,
                    ),
                  )
                : Center(
                    child: DragTarget(
                      hitTestBehavior: HitTestBehavior.opaque,
                      onAccept: (data) async {
                        final bloc = context.read<BlocksInLineBloc>();
                        if (data is BlockEntity && data is! RepeaterEntity) {
                          final value = await CupertinoNumberPicket.show(
                              context, data.value);

                          bloc.add(BlocksInLineEventAddBlockInsideRepeater(
                            block: (data).copyWith(value: value),
                            repeaterId: subList.id,
                          ));
                        }
                        if (data is int) {
                          bloc.add(
                            BlocksInLineEventMoveBlockToRepeater(
                              repeaterId: subList.id,
                              blockId: data,
                            ),
                          );
                        }
                      },
                      builder: (context, candidateData, rejectedData) {
                        Widget widget;

                        if (candidateData.isNotEmpty) {
                          widget = const _PreviewBlock();
                        } else {
                          widget = SvgPicture.asset(
                            'assets/empty-block.svg',
                          );
                        }

                        return SizedBox(
                          width: 80,
                          height: 80,
                          child: widget,
                        );
                      },
                    ),
                  ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SvgPicture.asset(
                  'assets/repeater-icon.svg',
                  height: 50,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF8C00),
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    border: Border.all(
                      width: 2,
                      color: const Color(0xFFA52E00),
                    ),
                  ),
                  child: Text(
                    subList.value.toString(),
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    return Row(
      children: [
        Column(
          children: [
            Expanded(
              child: Container(
                width: 12,
                decoration: const BoxDecoration(
                  color: Color(0xFFFF8C00),
                  border: Border(
                    bottom: BorderSide(width: 0, color: Color(0xFFA52E00)),
                    top: BorderSide(width: 2, color: Color(0xFFA52E00)),
                    right: BorderSide(width: 0, color: Color(0xFFA52E00)),
                    left: BorderSide(width: 2, color: Color(0xFFA52E00)),
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                  ),
                ),
              ),
            ),
            Container(
              width: 12,
              height: 42,
              decoration: const BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(6),
                  bottomRight: Radius.circular(6),
                ),
                border: Border(
                  bottom: BorderSide(width: 2, color: Color(0xFFA52E00)),
                  top: BorderSide(width: 2, color: Color(0xFFA52E00)),
                  right: BorderSide(width: 2, color: Color(0xFFA52E00)),
                  left: BorderSide(width: 0, color: Color(0xFFA52E00)),
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: 12,
                decoration: const BoxDecoration(
                  color: Color(0xFFFF8C00),
                  border: Border(
                    bottom: BorderSide(width: 2, color: Color(0xFFA52E00)),
                    top: BorderSide(width: 0, color: Color(0xFFA52E00)),
                    right: BorderSide(width: 0, color: Color(0xFFA52E00)),
                    left: BorderSide(width: 2, color: Color(0xFFA52E00)),
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                  ),
                ),
              ),
            ),
          ],
        ),
        content,
        SizedOverflowBox(
          size: const Size(0, 0),
          alignment: const Alignment(-0.68, 0),
          child: Container(
            width: 13,
            height: 42,
            decoration: const BoxDecoration(
              color: Color(0xFFFF8C00),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
              border: Border(
                bottom: BorderSide(width: 2, color: Color(0xFFA52E00)),
                top: BorderSide(width: 2, color: Color(0xFFA52E00)),
                right: BorderSide(width: 2, color: Color(0xFFA52E00)),
                left: BorderSide(width: 0, color: Color(0xFFA52E00)),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class _InitialBlock extends StatelessWidget {
  const _InitialBlock();

  @override
  Widget build(BuildContext context) {
    return DragTarget(
      onAccept: (data) async {
        final bloc = context.read<BlocksInLineBloc>();
        if (data is BlockEntity) {
          final value = await CupertinoNumberPicket.show(context, data.value);

          bloc.add(BlocksInLineEventAddBlock(
            block: (data).copyWith(value: value),
            insertAfterId: null,
          ));
        }
        if (data is RepeaterEntity) {
          final value = await CupertinoNumberPicket.show(context, data.value);

          bloc.add(BlocksInLineEventAddRepeater(
            repeaterEntity: data.copyWith(value: value),
            insertAfterId: null,
          ));
        }
        if (data is int) {
          bloc.add(
            BlocksInLineEventChangePositions(
              blockTargetId: null,
              blockId: data,
            ),
          );
        }
      },
      builder: (_, candidateData, __) {
        bool shouldShowPreview = (candidateData.isNotEmpty);
        return Row(
          children: [
            SizedOverflowBox(
              size: const Size(95, 0),
              alignment: Alignment.centerLeft,
              child: Center(
                child: SizedBox(
                  width: 110,
                  child: SvgPicture.asset('assets/bloco-inicial.svg'),
                ),
              ),
            ),
            shouldShowPreview ? const _PreviewBlock() : const SizedBox()
          ],
        );
      },
    );
  }
}

class DraggableBlock extends StatelessWidget {
  const DraggableBlock({
    super.key,
    required this.block,
    required this.positionOnLine,
    this.shouldAcceptRepeater = true,
  });

  final int positionOnLine;
  final BlockEntity block;
  final bool shouldAcceptRepeater;

  @override
  Widget build(BuildContext context) {
    return DragTarget(
      onAccept: (data) async {
        final bloc = context.read<BlocksInLineBloc>();
        if (data is BlockEntity) {
          final value = await CupertinoNumberPicket.show(context, data.value);

          bloc.add(BlocksInLineEventAddBlock(
            block: (data).copyWith(
              value: value,
            ),
            insertAfterId: block.id,
          ));
        }
        if (data is RepeaterEntity && shouldAcceptRepeater) {
          final value = await CupertinoNumberPicket.show(context, data.value);

          bloc.add(BlocksInLineEventAddRepeater(
            repeaterEntity: data.copyWith(value: value),
            insertAfterId: block.id,
          ));
        }
        if (data is int) {
          bloc.add(
            BlocksInLineEventChangePositions(
              blockTargetId: block.id,
              blockId: data,
            ),
          );
        }
      },
      builder: (_, candidateData, ___) {
        bool shouldShowPreview =
            (candidateData.isNotEmpty && candidateData[0] != block.id);

        final widget = SizedOverflowBox(
          size: const Size(66, 0),
          alignment: Alignment.centerLeft,
          child: GestureDetector(
            onLongPress: () {
              showDialog(
                context: context,
                builder: (context) => ModalInspecaoBlock(block: block),
              );
            },
            child: Draggable(
              data: block.id,
              childWhenDragging: BlockWidget.halfOpacity(
                block: block,
                showValue: true,
              ),
              feedback: Center(
                  child: BlockWidget.halfOpacity(
                block: block,
                showValue: true,
              )),
              child: BlockWidget(block: block, showValue: true),
            ),
          ),
        );

        if (shouldShowPreview) {
          return Row(
            children: [
              widget,
              const _PreviewBlock(),
            ],
          );
        } else {
          return widget;
        }
      },
    );
  }
}

class BlockWidget extends StatelessWidget {
  const BlockWidget(
      {super.key,
      required this.block,
      this.showValue = false,
      this.size = 110.0})
      : opacity = 1.0;
  const BlockWidget.halfOpacity(
      {super.key, required this.block, this.showValue = false})
      : opacity = 0.5,
        size = 110.0;
  final BlockEntity block;
  final double opacity;
  final bool showValue;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity,
      child: Center(
        child: SizedBox(
          width: 80,
          height: size,
          child: Stack(
            alignment: Alignment.center,
            children: [
              LayoutBuilder(builder: (context, constraints) {
                return SizedBox(
                  height: constraints.maxHeight - 10,
                  child: SvgPicture.asset(block.image),
                );
              }),
              if (showValue)
                Positioned(
                  bottom: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2E9AD1),
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      border: Border.all(
                        width: 2,
                        color: const Color(0xFF172585),
                      ),
                    ),
                    child: Text(
                      block.value.toString(),
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
