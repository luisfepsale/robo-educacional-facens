// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'block_library_cubit.dart';

class BlockLibraryState extends Equatable {
  const BlockLibraryState({
    this.isLibraryOpen = false,
  });
  final bool isLibraryOpen;

  @override
  List<Object> get props => [isLibraryOpen];

  BlockLibraryState copyWith({
    bool? isLibraryOpen,
  }) {
    return BlockLibraryState(
      isLibraryOpen: isLibraryOpen ?? this.isLibraryOpen,
    );
  }
}
