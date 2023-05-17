import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Block extends StatefulWidget {
  const Block({super.key, required this.onDragStarted});

  final Function() onDragStarted;

  @override
  State<Block> createState() => _BlockState();
}

class _BlockState extends State<Block> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Draggable(
        data: 10,
        onDragStarted: widget.onDragStarted,
        feedback: SvgPicture.asset(
          'assets/bloco1.svg',
          height: 100,
          width: 100,
        ),
        child: Padding(
          padding: const EdgeInsets.all(7.0),
          child: SvgPicture.asset(
            'assets/bloco1.svg',
          ),
        ),
      ),
    );
  }
}
