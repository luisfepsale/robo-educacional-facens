import 'package:equatable/equatable.dart';

class BlockEntity extends Equatable {
  final int id;

  const BlockEntity({
    required this.id,
  });

  @override
  List<Object?> get props => [id];
}
