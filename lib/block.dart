import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:roboeducacional/block_model.dart';

class Block extends StatelessWidget {
  const Block({
    super.key,
    required this.block,
    this.onDragStarted,
  });

  final Bloco block;
  final VoidCallback? onDragStarted;

  @override
  Widget build(BuildContext context) {
    return Draggable(
      data: block.value,
      feedback: SvgPicture.asset(
        block.image,
        height: 100,
        width: 100,
      ),
      onDragStarted: onDragStarted,
      child: InkWell(
        onTap: () {
          print("message");
        },
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: SvgPicture.asset(
            width: 100,
            block.image,
          ),
        ),
      ),
    );
  }
}
