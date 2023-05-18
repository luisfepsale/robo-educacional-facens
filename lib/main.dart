import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:roboeducacional/custom_app_bar.dart';
import 'package:roboeducacional/modal_inspecao.dart';
import 'package:roboeducacional/modal_welcome.dart';
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
      body: const ModalWelcome(),
      // const CustomAppBar(),
      // child: ModalInspecao(),
      drawer: Drawer(
        child: Material(
          color: const Color(0xFF2E9AD1),
          child: Column(
            children: const [
              DrawerHeader(
                  child: Icon(
                Icons.build_circle,
                size: 120,
                color: Colors.white,
              )),
              ListTile(
                leading: Icon(
                  Icons.note_add,
                  color: Colors.white,
                  size: 25,
                ),
                title: Text(
                  'Novo Arquivo',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.folder_copy,
                  color: Colors.white,
                  size: 25,
                ),
                title: Text('Carregar Arquivo',
                    style: TextStyle(fontSize: 20, color: Colors.white)),
              ),
              ListTile(
                leading: Icon(
                  Icons.save_alt,
                  color: Colors.white,
                  size: 25,
                ),
                title: Text('Salvar no Computador',
                    style: TextStyle(fontSize: 20, color: Colors.white)),
              ),
              Divider(
                thickness: 3,
                height: 20,
                color: Color(0xFF172585),
              ),
              ListTile(
                leading: Icon(
                  Icons.info_outline,
                  color: Colors.white,
                  size: 25,
                ),
                title: Text('Sobre',
                    style: TextStyle(fontSize: 20, color: Colors.white)),
              ),
              ListTile(
                leading: Icon(
                  Icons.content_paste,
                  color: Colors.white,
                  size: 25,
                ),
                title: Text('Termos de Uso',
                    style: TextStyle(fontSize: 20, color: Colors.white)),
              ),
              ListTile(
                leading: Icon(
                  Icons.help_outline,
                  color: Colors.white,
                  size: 25,
                ),
                title: Text('Ajuda',
                    style: TextStyle(fontSize: 20, color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
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
