part of 'blocks_in_line_bloc.dart';

class BlocksInLineState extends Equatable {
  final List<BlockEntity> blocks;

  const BlocksInLineState({
    this.blocks = const [
      BlockEntity(id: 1),
      BlockEntity(id: 2),
      BlockEntity(id: 3),
      BlockEntity(id: 4),
    ],
  });

  BlocksInLineState copyWith({
    List<BlockEntity>? blocks,
  }) {
    return BlocksInLineState(
      blocks: blocks ?? this.blocks,
    );
  }

  @override
  List<Object> get props => [blocks];
}
