import 'package:flutter/material.dart';
import 'package:roboeducacional/features/bluetooth/presentations/dialogs/dialog_base.dart';

class ModalLookRobot extends StatelessWidget {
  const ModalLookRobot({super.key});

  @override
  Widget build(BuildContext context) {
    return DialogBase(
      showTitle: false,
      content: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Image.asset('assets/eye-scanner.png'),
                const SizedBox(height: 20),
                const Text(
                  'Olhe para o robô!',
                  style: TextStyle(
                    color: Color(0xFF2580AF),
                    fontSize: 22,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    height: 1,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Verifique se o robô fez sua sequência corretamente, você pode voltar fazer ajustes se desejar!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF444444),
                    fontSize: 14,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                ),
              ],
            ),
            // const Spacer(),
            Column(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    backgroundColor: const Color(0xFFFF6767),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 35, vertical: 5),
                    shape: RoundedRectangleBorder(
                      side:
                          const BorderSide(width: 2, color: Color(0xFFA00000)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Voltar',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
