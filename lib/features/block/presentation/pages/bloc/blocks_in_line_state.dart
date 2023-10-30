part of 'blocks_in_line_bloc.dart';

class BlocksInLineState extends Equatable {
  final List<dynamic> blocks;

  const BlocksInLineState({
    this.blocks = const [],
  });

  BlocksInLineState copyWith({
    List<dynamic>? blocks,
  }) {
    return BlocksInLineState(
      blocks: blocks ?? this.blocks,
    );
  }

  @override
  List<Object> get props => [blocks];
}
