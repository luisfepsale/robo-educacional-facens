import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:roboeducacional/features/block/domain/block_entity.dart';

part 'blocks_in_line_event.dart';
part 'blocks_in_line_state.dart';

class BlocksInLineBloc extends Bloc<BlocksInLineEvent, BlocksInLineState> {
  BlocksInLineBloc() : super(const BlocksInLineState()) {
    on<BlocksInLineEventRemoveBlock>(_removeBlock);
    on<BlocksInLineEventChangePositions>(_changeBlockPositions);
    on<BlocksInLineEventAddBlock>(_addBlock);
  }

  _removeBlock(
      BlocksInLineEventRemoveBlock event, Emitter<BlocksInLineState> emit) {
    emit(state.copyWith(
      blocks: state.blocks.toList()..removeAt(event.positionOnLine),
    ));
  }

  _changeBlockPositions(
      BlocksInLineEventChangePositions event, Emitter<BlocksInLineState> emit) {
    final list = state.blocks.toList();
    final bloc = list[event.pastPositionOnLine];
    list
      ..removeAt(event.pastPositionOnLine)
      ..insert(event.positionOnLine + 1, bloc);

    emit(state.copyWith(blocks: list));
  }

  _addBlock(BlocksInLineEventAddBlock event, Emitter<BlocksInLineState> emit) {
    emit(state.copyWith(blocks: state.blocks.toList()..add(event.block)));
  }
}
