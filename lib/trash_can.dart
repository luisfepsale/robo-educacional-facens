import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TrashCan extends StatefulWidget {
  const TrashCan({super.key});

  @override
  State<TrashCan> createState() => _TrashCanState();
}

class _TrashCanState extends State<TrashCan> {
  @override
  bool _isTrashCanActive = false;

  @override
  Widget build(BuildContext context) {
    return DragTarget(
      onMove: (_) {
        setState(() {
          _isTrashCanActive = true;
        });
      },
      onLeave: (_) {
        setState(() {
          _isTrashCanActive = false;
        });
      },
      onAccept: (_) {
        setState(() {
          _isTrashCanActive = false;
        });
      },
      builder: (_, __, ___) => SizedBox(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SvgPicture.asset(
            color: _isTrashCanActive ? Colors.red : null,
            'assets/lixo.svg',
            height: 80,
            width: 80,
          ),
        ),
      ),
    );
  }
}
