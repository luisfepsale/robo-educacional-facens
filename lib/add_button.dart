import 'package:flutter/material.dart';

class AddButton extends StatelessWidget {
  const AddButton({super.key, required this.onTap});

  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          color: const Color(0xFFEE3131),
          borderRadius: BorderRadius.circular(100),
          border: Border.all(
            width: 5,
            color: const Color.fromARGB(255, 159, 14, 14),
          ),
        ),
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 80,
        ),
      ),
    );
  }
}
