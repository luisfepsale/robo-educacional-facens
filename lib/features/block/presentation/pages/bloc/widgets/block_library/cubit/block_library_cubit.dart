import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'block_library_state.dart';

class BlockLibraryCubit extends Cubit<BlockLibraryState> {
  BlockLibraryCubit() : super(const BlockLibraryState());

  void openLibrary() {
    emit(state.copyWith(isLibraryOpen: true));
  }

  void closeLibrary() {
    emit(state.copyWith(isLibraryOpen: false));
  }
}
