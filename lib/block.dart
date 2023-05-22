import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:roboeducacional/block_model.dart';

class Block extends StatefulWidget {
  const Block({
    super.key,
    required this.block,
  });

  final Bloco block;

  @override
  State<Block> createState() => _BlockState();
}

class _BlockState extends State<Block> {
  @override
  Widget build(BuildContext context) {
    final block = widget.block;

    return Draggable(
      data: block.value,
      feedback: SvgPicture.asset(
        block.image,
        height: 100,
        width: 100,
      ),
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: SvgPicture.asset(
          width: 100,
          block.image,
        ),
      ),
    );
  }
}
