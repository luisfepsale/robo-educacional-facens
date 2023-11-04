import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:roboeducacional/features/block/domain/block_entity.dart';
import 'package:roboeducacional/features/block/domain/wrapper_entity.dart';
import 'package:roboeducacional/features/block/presentation/pages/bloc/blocks_in_line_bloc.dart';
import 'package:roboeducacional/features/block/presentation/pages/bloc/widgets/cupertino_number_picker/cupertino_number_picker.dart';

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
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: subList.list.length,
              itemBuilder: (context, index) => DraggableBlock(
                block: subList.list[index],
                positionOnLine: listIndex,
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
                  child: const Text(
                    '10',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );

    final widget = Row(
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

    return SizedBox(
      child: Draggable(
        data: listIndex,
        feedback: const SizedBox(),
        childWhenDragging: Opacity(opacity: 0.5, child: widget),
        child: widget,
      ),
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
            positionOnLine: -1,
          ));
        }
        if (data is int) {
          bloc.add(
            BlocksInLineEventChangePositions(
              positionOnLine: 0,
              pastPositionOnLine: data,
            ),
          );
        }
      },
      builder: (_, candidateData, __) {
        bool shouldShowPreview = (candidateData.isNotEmpty);
        return SizedOverflowBox(
          size: Size(shouldShowPreview ? 115 : 95, 0),
          alignment: Alignment.centerLeft,
          child: Center(
            child: SizedBox(
              width: 110,
              child: SvgPicture.asset('assets/bloco-inicial.svg'),
            ),
          ),
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
  });

  final int positionOnLine;
  final BlockEntity block;

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
            positionOnLine: positionOnLine,
          ));
        }
        if (data is int) {
          bloc.add(
            BlocksInLineEventChangePositions(
              positionOnLine: positionOnLine,
              pastPositionOnLine: data,
            ),
          );
        }
      },
      builder: (_, candidateData, ___) {
        bool shouldShowPreview =
            (candidateData.isNotEmpty && candidateData[0] != positionOnLine);
        return SizedOverflowBox(
          size: Size(shouldShowPreview ? 100 : 66, 0),
          alignment: Alignment.centerLeft,
          child: Draggable(
            data: positionOnLine,
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
        );
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
