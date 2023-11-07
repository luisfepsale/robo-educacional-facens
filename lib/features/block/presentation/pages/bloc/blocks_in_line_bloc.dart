import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:roboeducacional/features/block/domain/block_entity.dart';
import 'package:roboeducacional/features/block/domain/wrapper_entity.dart';

part 'blocks_in_line_event.dart';
part 'blocks_in_line_state.dart';

class SimpleBlocObserver extends BlocObserver {
  const SimpleBlocObserver();

  @override
  void onCreate(BlocBase<dynamic> bloc) {
    super.onCreate(bloc);
    print('onCreate -- bloc: ${bloc.runtimeType}');
  }

  @override
  void onEvent(Bloc<dynamic, dynamic> bloc, Object? event) {
    super.onEvent(bloc, event);
    print('onEvent -- bloc: ${bloc.runtimeType}, event: $event');
  }

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    print('onChange -- bloc: ${bloc.runtimeType}, change: $change');
  }

  @override
  void onTransition(
    Bloc<dynamic, dynamic> bloc,
    Transition<dynamic, dynamic> transition,
  ) {
    super.onTransition(bloc, transition);
    print('onTransition -- bloc: ${bloc.runtimeType}, transition: $transition');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    print('onError -- bloc: ${bloc.runtimeType}, error: $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase<dynamic> bloc) {
    super.onClose(bloc);
    print('onClose -- bloc: ${bloc.runtimeType}');
  }
}

class BlocksInLineBloc extends Bloc<BlocksInLineEvent, BlocksInLineState> {
  BlocksInLineBloc() : super(const BlocksInLineState(blocks: [])) {
    on<BlocksInLineEventRemoveBlock>(_removeBlock);
    on<BlocksInLineEventChangePositions>(_changeBlockPositions);
    on<BlocksInLineEventAddBlock>(_addBlock);
    on<BlocksInLineEventAddBlockInsideRepeater>(_addBlockInsideRepeater);
    on<BlocksInLineEventMoveBlockToRepeater>(_moveBlockToRepeater);
    on<BlocksInLineEventAddRepeater>(_addRepeater);
  }

  int counter = 0;

  _addBlockInsideRepeater(
    BlocksInLineEventAddBlockInsideRepeater event,
    Emitter<BlocksInLineState> emit,
  ) {
    emit(state.copyWith(
      blocks: _insertBlockInRepeater(
        state.blocks.toList(),
        event.block.copyWith(id: counter++),
        event.repeaterId,
      ),
    ));
  }

  _addRepeater(
      BlocksInLineEventAddRepeater event, Emitter<BlocksInLineState> emit) {
    if (event.insertAfterId == null) {
      emit(state.copyWith(
        blocks: [event.repeaterEntity.copyWith(id: counter++), ...state.blocks],
      ));

      print(state.blocks.toList().toString());
      return;
    }
    emit(state.copyWith(
      blocks: _insertAfter(
        state.blocks.toList(),
        event.repeaterEntity.copyWith(id: counter++),
        event.insertAfterId!,
      ),
    ));
  }

  _removeBlock(
      BlocksInLineEventRemoveBlock event, Emitter<BlocksInLineState> emit) {
    emit(state.copyWith(
      blocks: _removeItem(
        state.blocks.toList(),
        event.removeId,
      ),
    ));
  }

  _changeBlockPositions(
    BlocksInLineEventChangePositions event,
    Emitter<BlocksInLineState> emit,
  ) {
    if (event.blockTargetId == null) {
      return;
    }

    print([event.blockTargetId, event.blockId]);

    emit(state.copyWith(
        blocks: _togglePositions(
      state.blocks.toList(),
      event.blockTargetId!,
      event.blockId,
    )));
  }

  _moveBlockToRepeater(
    BlocksInLineEventMoveBlockToRepeater event,
    Emitter<BlocksInLineState> emit,
  ) {
    final block = _findItem(state.blocks.toList(), event.blockId);
    if (block == null) {
      return;
    }

    List<dynamic> newCollection = _removeItem(state.blocks.toList(), block.id);
    newCollection = _insertBlockInRepeater(
      newCollection,
      block,
      event.repeaterId,
    );

    emit(state.copyWith(
      blocks: newCollection,
    ));
  }

  _addBlock(BlocksInLineEventAddBlock event, Emitter<BlocksInLineState> emit) {
    final block = event.block.copyWith(id: counter++);

    if (event.insertAfterId == null) {
      emit(state.copyWith(blocks: [block, ...state.blocks]));
      return;
    }

    emit(state.copyWith(
      blocks: _insertAfter(
        state.blocks.toList(),
        block,
        event.insertAfterId!,
      ),
    ));
  }
}

List _removeItem(List collection, int removeId) {
  List newCollection = collection.toList();
  for (var i = 0; i < collection.length; i++) {
    final el = collection[i];

    if (el is RepeaterEntity) {
      if (el.id == removeId) {
        newCollection.removeAt(i);
        return newCollection;
      } else {
        final list = el.list.toList();
        final index = list.indexWhere((element) => element.id == removeId);
        if (index >= 0) {
          list.removeAt(index);
          newCollection[i] = el.copyWith(list: list);
          return newCollection;
        }
      }
    } else if (el is BlockEntity && el.id == removeId) {
      final list = collection.toList()..removeAt(i);
      newCollection = list;
      return newCollection;
    }
  }

  return newCollection;
}

List<dynamic> _insertAfter(
  List collection,
  dynamic blockToInsert,
  int insertAfterId,
) {
  List newCollection = collection.toList();
  for (var i = 0; i < collection.length; i++) {
    final el = collection[i];

    if (el is RepeaterEntity) {
      if (el.id == insertAfterId) {
        final list = collection.toList()..insert(i + 1, blockToInsert);
        newCollection = list;
        return newCollection;
      }
      final list = el.list.toList();
      final index = list.indexWhere((element) => element.id == insertAfterId);
      if (index >= 0) {
        list.insert(index + 1, blockToInsert);
        newCollection[i] = el.copyWith(list: list);
        return newCollection;
      }
    }
    if (el is BlockEntity && el.id == insertAfterId) {
      final list = collection.toList()..insert(i + 1, blockToInsert);
      newCollection = list;
      return newCollection;
    }
  }

  return newCollection;
}

List<dynamic> _togglePositions(
  List collection,
  int blockTargetId,
  int blockId,
) {
  List newCollection = collection.toList();

  final blockToInsert = _findItem(newCollection, blockId);
  newCollection = _removeItem(newCollection, blockId);
  newCollection = _insertAfter(newCollection, blockToInsert!, blockTargetId);

  return newCollection;
}

dynamic _findItem(List<dynamic> collection, int blockIdToFind) {
  for (var i = 0; i < collection.length; i++) {
    final el = collection[i];

    if (el is RepeaterEntity) {
      if (el.id == blockIdToFind) {
        return el;
      } else {
        for (var el in el.list.toList()) {
          if (el.id == blockIdToFind) {
            return el;
          }
        }
      }
    } else if (el is BlockEntity && el.id == blockIdToFind) {
      return el;
    }
  }
  return null;
}

List<dynamic> _insertBlockInRepeater(
    List<dynamic> collection, BlockEntity blockToInsert, int repeaterId) {
  List<dynamic> newCollection = collection.toList();
  for (var i = 0; i < collection.length; i++) {
    final el = collection[i];

    if (el is RepeaterEntity && el.id == repeaterId) {
      final list = el.list.toList()..add(blockToInsert);
      newCollection[i] = el.copyWith(list: list);
    }
  }

  return newCollection;
}
