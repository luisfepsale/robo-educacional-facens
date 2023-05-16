import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:roboeducacional/custom_app_bar.dart';
import 'package:roboeducacional/modal_inspecao.dart';
import 'package:roboeducacional/tab_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  get size => null;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      backgroundColor: const Color(0xFFE9E9E9),
      body: const CustomAppBar(),
      // child: ModalInspecao(),

      // appBar: AppBar(
      //   title: Text('nome do projeto'),
      // ),
      floatingActionButton: Builder(builder: (context) {
        double height = MediaQuery.of(context).size.height;

        return FloatingActionButton.large(
          shape: RoundedRectangleBorder(
              side: const BorderSide(
                width: 5,
                color: Color.fromARGB(255, 159, 14, 14),
              ),
              borderRadius: BorderRadius.circular(100)),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              builder: (context) => SizedBox(
                height: height * 0.5,
                child: const TabView(),
              ),
            );
          },
          backgroundColor: const Color(0xFFEE3131),
          child: const Icon(
            Icons.add,
            size: 80,
          ),
        );
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    ));
  }
}



// void main() {
//   runApp(MaterialApp(
//       home: Scaffold(
//       appBar: AppBar(
//       title: Text('nome do projeto'),
//     ),
//     floatingActionButton: FloatingActionButton(
//       onPressed: () {},
//       child: Icon(Icons.add),
//     ),
//     floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
//   )));
// }
