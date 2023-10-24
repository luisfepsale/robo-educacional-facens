// import 'package:flutter/material.dart';

// class ModalSearchDevice extends StatefulWidget {
//   const ModalSearchDevice({
//     Key key,
//   }) : super(key: key);

//   @override
//   State<ModalSearchDevice> createState() => _ModalSearchDeviceState();
// }

// class _ModalSearchDeviceState extends State<ModalSearchDevice> {
//   final List<Map<String, dynamic>> devices = [
//     {
//       'imageUrl': 'https://via.placeholder.com/40x40',
//       'title': 'Robô (ESP32)',
//       'subtitle': 'Clique para conectar',
//     },
//     {
//       'imageUrl': 'https://via.placeholder.com/40x40',
//       'title': 'Robô qualquer',
//       'subtitle': 'Clique para conectar',
//     },
//     {
//       'imageUrl': 'https://via.placeholder.com/40x40',
//       'title': 'Robô qualquer',
//       'subtitle': 'Clique para conectar',
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(20.0),
//       ),
//       child: SizedBox(
//         width: 242,
//         height: 351,
//         child: Stack(
//           children: [
//             Positioned(
//               left: 0,
//               top: 0,
//               child: Container(
//                 width: 242,
//                 height: 351,
//                 decoration: ShapeDecoration(
//                   color: Colors.white,
//                   shape: RoundedRectangleBorder(
//                     side: const BorderSide(width: 3, color: Color(0xFF2E9AD1)),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//               ),
//             ),
//             const Positioned(
//               left: 18,
//               top: 22,
//               child: Text(
//                 'Procurando o Robô',
//                 style: TextStyle(
//                   color: Color(0xFF2580AF),
//                   fontSize: 22,
//                   fontFamily: 'Inter',
//                   fontWeight: FontWeight.w700,
//                   height: 1,
//                 ),
//               ),
//             ),
//             Column(
//               children: devices.map((device) {
//                 return Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 10),
//                   child: _buildDeviceWidget(
//                     imageUrl: device['imageUrl'],
//                     title: device['title'],
//                     subtitle: device['subtitle'],
//                   ),
//                 );
//               }).toList(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildDeviceWidget({
//     String imageUrl,
//     String title,
//     String subtitle,
//   }) {
//     return SizedBox(
//       width: 205,
//       height: 61,
//       child: Stack(
//         children: [
//           Positioned(
//             left: 11,
//             top: 11,
//             child: Container(
//               width: 40,
//               height: 40,
//               decoration: BoxDecoration(
//                 image: DecorationImage(
//                   image: NetworkImage(imageUrl),
//                   fit: BoxFit.fill,
//                 ),
//               ),
//             ),
//           ),
//           Positioned(
//             left: 61,
//             top: 16,
//             child: Text(
//               title,
//               style: const TextStyle(
//                 color: Color(0xFF1F668A),
//                 fontSize: 16,
//                 fontFamily: 'Inter',
//                 fontWeight: FontWeight.w700,
//                 height: 1,
//               ),
//             ),
//           ),
//           Positioned(
//             left: 61,
//             top: 35,
//             child: Text(
//               subtitle,
//               style: const TextStyle(
//                 color: Color(0xFF565656),
//                 fontSize: 10,
//                 fontFamily: 'Inter',
//                 fontWeight: FontWeight.w700,
//                 height: 1,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
