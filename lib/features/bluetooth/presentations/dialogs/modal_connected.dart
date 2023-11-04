import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:roboeducacional/features/bluetooth/presentations/dialogs/dialog_base.dart';
import 'package:roboeducacional/features/bluetooth/presentations/dialogs/modal_look_robot.dart';

class ModalBluetoothConnected extends StatelessWidget {
  const ModalBluetoothConnected({super.key, required this.device});

  final BluetoothDevice device;

  @override
  Widget build(BuildContext context) {
    return DialogBase(
      showTitle: false,
      content: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Image.asset('assets/robot-2.png'),
              const SizedBox(height: 20),
              const Text(
                'Robô conectado!',
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
                'Clique no botão “Enviar” para que o robô faça a sequência lógica que você desenvolveu!',
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
              StreamBuilder<List<BluetoothService>>(
                stream: device.services,
                initialData: const [],
                builder: (c, snapshot) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      backgroundColor: const Color(0xFFFF6767),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 35, vertical: 5),
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                            width: 2, color: Color(0xFFA00000)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      snapshot.data!.first.characteristics.first.write(
                        [0],
                        withoutResponse: true,
                      ).then((value) => showDialog(
                            context: context,
                            builder: (context) => const ModalLookRobot(),
                          ));
                    },
                    child: const Text(
                      'Enviar',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  );
                },
              ),
              TextButton(
                style: TextButton.styleFrom(
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                onPressed: () {
                  device
                      .disconnect()
                      .then((value) => Navigator.of(context).pop());
                },
                child: const Text(
                  'Desconectar',
                  style: TextStyle(
                    color: Color(0xFF474747),
                    fontSize: 14,
                    fontFamily: 'Inter',
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';

// class ModalBluetoothConnected extends StatefulWidget {
//   const ModalBluetoothConnected({
//     super.key,
//   });

//   @override
//   State<ModalBluetoothConnected> createState() =>
//       _ModalBluetoothConnectedState();
// }

// class _ModalBluetoothConnectedState extends State<ModalBluetoothConnected> {
//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(20.0),
//       ),
//       child: SizedBox(
//         width: 242,
//         height: 351,
//         child: Center(
//           child: Container(
//             width: 242,
//             height: 351,
//             decoration: ShapeDecoration(
//               color: Colors.white,
//               shape: RoundedRectangleBorder(
//                 side: const BorderSide(width: 3, color: Color(0xFF2E9AD1)),
//                 borderRadius: BorderRadius.circular(10),
//               ),
//             ),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 buildRobotImage(),
//                 buildConnectedText(),
//                 buildDescriptionText(),
//                 buildSendButton(),
//                 buildDisconnectText(),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget buildSendButton() {
//     return SizedBox(
//       width: 138,
//       height: 38,
//       child: Stack(
//         children: [
//           Container(
//             width: 138,
//             height: 38,
//             decoration: ShapeDecoration(
//               color: const Color(0xFFFF6767),
//               shape: RoundedRectangleBorder(
//                 side: const BorderSide(width: 2, color: Color(0xFFA00000)),
//                 borderRadius: BorderRadius.circular(10),
//               ),
//             ),
//           ),
//           const Align(
//             alignment: Alignment.center,
//             child: Text(
//               'Enviar',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 22,
//                 fontFamily: 'Inter',
//                 fontWeight: FontWeight.w700,
//                 height: 0,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget buildDisconnectText() {
//     return const SizedBox(
//       width: 65,
//       child: Text(
//         'Desconectar',
//         style: TextStyle(
//           color: Color(0xFF474747),
//           fontSize: 10,
//           fontFamily: 'Inter',
//           fontWeight: FontWeight.w700,
//           height: 0,
//         ),
//       ),
//     );
//   }

//   Widget buildConnectedText() {
//     return const Text(
//       'Robô conectado !',
//       style: TextStyle(
//         color: Color(0xFF2580AF),
//         fontSize: 22,
//         fontFamily: 'Inter',
//         fontWeight: FontWeight.w700,
//         height: 0,
//       ),
//     );
//   }

//   Widget buildRobotImage() {
//     return Container(
//       width: 95,
//       height: 95,
//       decoration: const BoxDecoration(
//         image: DecorationImage(
//           image: NetworkImage("https://via.placeholder.com/95x95"),
//           fit: BoxFit.fill,
//         ),
//       ),
//     );
//   }

//   Widget buildDescriptionText() {
//     return const SizedBox(
//       width: 175,
//       child: Text(
//         'Clique no botão “Enviar” para que o robô faça a sequência lógica que você desenvolveu!',
//         textAlign: TextAlign.center,
//         style: TextStyle(
//           color: Color(0xFF444444),
//           fontSize: 10,
//           fontFamily: 'Inter',
//           fontWeight: FontWeight.w700,
//           height: 0,
//         ),
//       ),
//     );
//   }
// }

