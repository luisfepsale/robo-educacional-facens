// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'blocks_in_line_bloc.dart';

sealed class BlocksInLineEvent extends Equatable {
  const BlocksInLineEvent();
}

class BlocksInLineEventAddBlock extends BlocksInLineEvent {
  final BlockEntity block;
  final int positionOnLine;

  const BlocksInLineEventAddBlock({
    required this.block,
    required this.positionOnLine,
  });

  @override
  List<Object?> get props => [block];
}

class BlocksInLineEventChangePositions extends BlocksInLineEvent {
  final int pastPositionOnLine;
  final int positionOnLine;

  const BlocksInLineEventChangePositions(
      {required this.positionOnLine, required this.pastPositionOnLine});

  @override
  List<Object?> get props => [pastPositionOnLine, positionOnLine];
}

class BlocksInLineEventRemoveBlock extends BlocksInLineEvent {
  final int positionOnLine;

  const BlocksInLineEventRemoveBlock({required this.positionOnLine});

  @override
  List<Object?> get props => [positionOnLine];
}
