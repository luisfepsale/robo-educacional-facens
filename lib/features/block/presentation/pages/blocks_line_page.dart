import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:roboeducacional/features/block/domain/block_entity.dart';
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
            itemCount: listOfBlocks.isEmpty ? 1 : listOfBlocks.length,
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(20),
            itemBuilder: (context, index) {
              return Center(
                child: SizedBox(
                  height: 120,
                  child: index == 0
                      ? const _InitialBlock()
                      : DraggableBlock(
                          block: listOfBlocks[index],
                          positionOnLine: index - 1,
                        ),
                ),
              );
            },
          ),
        );
      },
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
            block: (data).copyWith(
              value: value,
            ),
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
    block,
    required this.positionOnLine,
  });
  final int positionOnLine;

  @override
  Widget build(BuildContext context) {
    final block = context.read<BlocksInLineBloc>().state.blocks[positionOnLine];
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
          size: Size(shouldShowPreview ? 100 : 68, 0),
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
