import 'package:flutter/material.dart';

import 'block_model.dart';

class ModalInspecao extends StatefulWidget {
  const ModalInspecao({
    super.key,
    required this.block,
  });

  final Bloco block;

  @override
  State<ModalInspecao> createState() => _ModalInspecaoState();
}

class _ModalInspecaoState extends State<ModalInspecao> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(
              width: 3,
              color: Colors.blue,
            )),
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Classe: Nome do movimento",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Color(0xFF2E9AD1),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Color(0xFF585858),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                Text('Ajuda',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2E9AD1),
                    )),
                Icon(
                  Icons.question_mark,
                  color: Color(0xFF2E9AD1),
                  size: 28,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
