import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:roboeducacional/features/bluetooth/presentations/dialogs/modal_connected.dart';

class RobotWidget extends StatelessWidget {
  const RobotWidget({
    super.key,
    required this.item,
  });

  final ScanResult item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: const Color(0xFFC5EBFF),
        border: Border.all(
          color: const Color(0xFF2681AF),
          width: 2.0,
        ),
      ),
      child: GestureDetector(
        onTap: () async {
          item.device.connect().then(
                (value) => showDialog(
                  context: context,
                  builder: (context) =>
                      ModalBluetoothConnected(device: item.device),
                ),
              );
        },
        child: Row(
          children: [
            Image.asset('assets/robot.png'),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Robô ${item.device.name}',
                  style: const TextStyle(
                    color: Color(0xFF1F668A),
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    height: 1,
                  ),
                ),
                const Text(
                  'clique para conectar',
                  style: TextStyle(
                    color: Color(0xFF565656),
                    fontSize: 10,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    height: 1,
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
