import 'package:flutter/material.dart';

class BlocInLine extends StatefulWidget {
  const BlocInLine({super.key});

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
          builder: (_, candidateData, __) => Container(
            height: 100,
            width: 100,
            color: Colors.red,
          ),
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
