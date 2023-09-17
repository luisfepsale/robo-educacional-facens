import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roboeducacional/features/block/domain/block_entity.dart';
import 'package:roboeducacional/features/block/presentation/pages/bloc/blocks_in_line_bloc.dart';

class BlocksInLine extends StatelessWidget {
  const BlocksInLine({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          children: [
            BlocBuilder<BlocksInLineBloc, BlocksInLineState>(
              builder: (context, state) {
                return const DraggableListOfBlocs();
              },
            ),
          ],
        ),
      ),
    );
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
            child: ListView.separated(
          separatorBuilder: (context, index) => const SizedBox(
            height: 10,
          ),
          shrinkWrap: true,
          itemCount: listOfBlocks.length,
          itemBuilder: (context, index) {
            return DraggableBlock(positionOnLine: index);
          },
        ));
      },
    );
  }
}

class DraggableBlock extends StatelessWidget {
  const DraggableBlock({super.key, block, required this.positionOnLine});
  final int positionOnLine;

  @override
  Widget build(BuildContext context) {
    final block = context.read<BlocksInLineBloc>().state.blocks[positionOnLine];
    return Center(
      child: Draggable(
        childWhenDragging: const SizedBox(),
        data: positionOnLine,
        feedback: BlockWidget(block: block),
        child: DragTargetWrapper(block: block, positionOnLine: positionOnLine),
      ),
    );
  }
}

class DragTargetWrapper extends StatelessWidget {
  const DragTargetWrapper(
      {super.key, required this.block, required this.positionOnLine});
  final int positionOnLine;
  final BlockEntity block;

  @override
  Widget build(BuildContext context) {
    return DragTarget<int>(
      onAccept: (data) {
        context.read<BlocksInLineBloc>().add(
              BlocksInLineEventChangePositions(
                positionOnLine: positionOnLine,
                pastPositionOnLine: data,
              ),
            );
      },
      builder: (context, candidateData, rejectedData) {
        return BlockWidget(block: block);
      },
    );
  }
}

class BlockWidget extends StatelessWidget {
  const BlockWidget({super.key, required this.block}) : opacity = 1.0;
  const BlockWidget.halfOpacity({super.key, required this.block})
      : opacity = 0.5;
  final BlockEntity block;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity,
      child: Container(
        constraints: const BoxConstraints(maxHeight: 50, maxWidth: 50),
        color: Colors.green,
        child: Center(
          child: Text(
            '${block.id}',
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
