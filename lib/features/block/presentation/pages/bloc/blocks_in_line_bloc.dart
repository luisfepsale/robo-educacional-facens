import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:roboeducacional/features/block/domain/block_entity.dart';
import 'package:roboeducacional/features/block/domain/wrapper_entity.dart';

part 'blocks_in_line_event.dart';
part 'blocks_in_line_state.dart';

const _repeater =
    RepeaterEntity(list: [BlockEntity(), BlockEntity(), BlockEntity()]);

class BlocksInLineBloc extends Bloc<BlocksInLineEvent, BlocksInLineState> {
  BlocksInLineBloc()
      : super(const BlocksInLineState(
          blocks: [BlockEntity(), _repeater, BlockEntity(), BlockEntity()],
        )) {
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
    BlocksInLineEventChangePositions event,
    Emitter<BlocksInLineState> emit,
  ) {
    if (event.pastPositionOnLine == event.positionOnLine) {
      return;
    }

    final list = state.blocks.toList();
    final el = list[event.pastPositionOnLine];
    list
      ..removeAt(event.pastPositionOnLine)
      ..insert(event.positionOnLine, el);

    emit(state.copyWith(blocks: list));
  }

  _addBlock(BlocksInLineEventAddBlock event, Emitter<BlocksInLineState> emit) {
    final list = state.blocks.toList();
    list.insert(event.positionOnLine + 1, event.block);

    emit(state.copyWith(blocks: list));
  }

  List _removeItem(List collection, BlockEntity elToRemove) {
    List ccList = collection.toList();

    for (var el in collection) {
      if (identical(el, elToRemove)) {
        ccList.remove(elToRemove);
      }
    }

    return ccList;
  }
}
