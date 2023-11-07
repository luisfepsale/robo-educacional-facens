// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'blocks_in_line_bloc.dart';

sealed class BlocksInLineEvent extends Equatable {
  const BlocksInLineEvent();
}

class BlocksInLineEventAddBlock extends BlocksInLineEvent {
  final BlockEntity block;
  final int? insertAfterId;

  const BlocksInLineEventAddBlock({
    required this.block,
    this.insertAfterId,
  });

  @override
  List<Object?> get props => [block, insertAfterId];
}

class BlocksInLineEventAddRepeater extends BlocksInLineEvent {
  final RepeaterEntity repeaterEntity;
  final int? insertAfterId;

  const BlocksInLineEventAddRepeater({
    required this.repeaterEntity,
    this.insertAfterId,
  });

  @override
  List<Object?> get props => [repeaterEntity, insertAfterId];
}

class BlocksInLineEventAddBlockInsideRepeater extends BlocksInLineEvent {
  final BlockEntity block;
  final int repeaterId;

  const BlocksInLineEventAddBlockInsideRepeater({
    required this.block,
    required this.repeaterId,
  });

  @override
  List<Object?> get props => [block, repeaterId];
}

class BlocksInLineEventMoveBlockToRepeater extends BlocksInLineEvent {
  final int blockId;
  final int repeaterId;

  const BlocksInLineEventMoveBlockToRepeater({
    required this.blockId,
    required this.repeaterId,
  });

  @override
  List<Object?> get props => [blockId, repeaterId];
}

class BlocksInLineEventChangePositions extends BlocksInLineEvent {
  final int? blockTargetId;
  final int blockId;

  const BlocksInLineEventChangePositions({
    required this.blockTargetId,
    required this.blockId,
  });

  @override
  List<Object?> get props => [blockTargetId, blockId];
}

class BlocksInLineEventRemoveBlock extends BlocksInLineEvent {
  final int removeId;

  const BlocksInLineEventRemoveBlock({required this.removeId});

  @override
  List<Object?> get props => [removeId];
}
