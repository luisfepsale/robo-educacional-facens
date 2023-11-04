import 'package:flutter/material.dart';

class DialogBase extends StatelessWidget {
  const DialogBase({
    super.key,
    this.showTitle = true,
    required this.content,
  });

  final bool showTitle;
  final Widget content;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        side: BorderSide(
          color: Color(0xFF2E9AD1),
          width: 3.0,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(20.0),
        width: 242,
        height: 351,
        child: Column(
          children: [
            showTitle ? _buildTitle() : const SizedBox(),
            Expanded(child: content),
          ],
        ),
      ),
    );
  }
}

_buildTitle() {
  return const Text(
    'Procurando o Robô',
    style: TextStyle(
      color: Color(0xFF2580AF),
      fontSize: 22,
      fontFamily: 'Inter',
      fontWeight: FontWeight.w700,
      height: 1,
    ),
  );
}
