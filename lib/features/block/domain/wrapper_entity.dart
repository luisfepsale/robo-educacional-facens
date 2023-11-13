// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:roboeducacional/features/block/domain/block_entity.dart';

class RepeaterEntity extends Equatable {
  final int id;
  final List<BlockEntity> list;
  final int value;
  final String title;

  const RepeaterEntity({
    this.id = 0,
    this.value = 0,
    required this.title,
    this.list = const [],
  });

  @override
  List<Object?> get props => [list, id];

  RepeaterEntity copyWith({
    int? value,
    int? id,
    List<BlockEntity>? list,
  }) {
    return RepeaterEntity(
      list: list ?? this.list,
      title: '',
      value: value ?? this.value,
      id: id ?? this.id,
    );
  }

  List<String> toCode() {
    final List<String> code = ['r'];

    for (final block in list) {
      code.addAll(block.toCode());
    }

    code.add('sr');

    return code;
  }

  factory RepeaterEntity.fromMap(Map<String, dynamic> map) {
    return RepeaterEntity(
      title: map['title'] as String,
      list: List<BlockEntity>.from(
        (map['list'] as List<int>).map<BlockEntity>(
          (x) => BlockEntity.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }
}
