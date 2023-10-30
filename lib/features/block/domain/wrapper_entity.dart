// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:roboeducacional/features/block/domain/block_entity.dart';

class RepeaterEntity extends BlockEntity {
  final List<BlockEntity> list;
  const RepeaterEntity({this.list = const []});
}
