import 'package:flutter/material.dart';

class ModalBluetoothConnected extends StatefulWidget {
  const ModalBluetoothConnected({
    super.key,
  });

  @override
  State<ModalBluetoothConnected> createState() =>
      _ModalBluetoothConnectedState();
}

class _ModalBluetoothConnectedState extends State<ModalBluetoothConnected> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: SizedBox(
        width: 242,
        height: 351,
        child: Stack(
          children: [
            buildContainer(),
            buildSendButton(),
            buildDisconnectText(),
            buildConnectedText(),
            buildRobotImage(),
            buildDescriptionText(),
          ],
        ),
      ),
    );
  }

  Widget buildContainer() {
    return Positioned(
      left: 0,
      top: 0,
      child: Container(
        width: 242,
        height: 351,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 3, color: Color(0xFF2E9AD1)),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget buildSendButton() {
    return Positioned(
      left: 52,
      top: 261,
      child: SizedBox(
        width: 138,
        height: 38,
        child: Stack(
          children: [
            Container(
              width: 138,
              height: 38,
              decoration: ShapeDecoration(
                color: const Color(0xFFFF6767),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 2, color: Color(0xFFA00000)),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const Positioned(
              left: 35,
              top: 2.5,
              child: SizedBox(
                width: 68,
                child: Text(
                  'Enviar',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDisconnectText() {
    return const Positioned(
      left: 89,
      top: 307,
      child: SizedBox(
        width: 65,
        child: Text(
          'Desconectar',
          style: TextStyle(
            color: Color(0xFF474747),
            fontSize: 10,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
            height: 0,
          ),
        ),
      ),
    );
  }

  Widget buildConnectedText() {
    return const Positioned(
      left: 27,
      top: 135,
      child: Text(
        'Robô conectado !',
        style: TextStyle(
          color: Color(0xFF2580AF),
          fontSize: 22,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w700,
          height: 0,
        ),
      ),
    );
  }

  Widget buildRobotImage() {
    return Positioned(
      left: 74,
      top: 32,
      child: Container(
        width: 95,
        height: 95,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage("https://via.placeholder.com/95x95"),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }

  Widget buildDescriptionText() {
    return const Positioned(
      left: 34,
      top: 182,
      child: SizedBox(
        width: 175,
        child: Text(
          'Clique no botão “Enviar” para que o robô faça a sequência lógica que você desenvolveu!',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF444444),
            fontSize: 10,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
            height: 0,
          ),
        ),
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

