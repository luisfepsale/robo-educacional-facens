import 'package:flutter/material.dart';
import 'package:roboeducacional/block.dart';
import 'package:roboeducacional/block_model.dart';
import 'package:roboeducacional/main_screen.dart';

class BlocInLine extends StatefulWidget {
  const BlocInLine(
      {super.key, required this.block, required this.adicionarBloco});
  final Bloco block;
  final VoidCallback? adicionarBloco;

  @override
  State<BlocInLine> createState() => _BlocInLineState();
}

class _BlocInLineState extends State<BlocInLine> {
  bool showPreview = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        DragTarget(
          builder: (_, candidateData, __) => Block(block: widget.block),
          onWillAccept: (data) {
            setState(() {
              showPreview = true;
            });
            return true;
          },
          onLeave: (data) {
            setState(() {
              showPreview = false;
            });
          },
          onAccept: (data) {
            setState(() {
              adicionarBloco(elemento, index);
              showPreview = false;
            });
          },
        ),
        showPreview
            ? Container(
                color: Colors.green,
                height: 100,
                width: 100,
              )
            : const SizedBox(),
      ],
    );
  }
}
