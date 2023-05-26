import 'package:flutter/material.dart';
import 'package:roboeducacional/add_button.dart';
import 'package:roboeducacional/bloc_in_line.dart';
import 'package:roboeducacional/block_model.dart';
import 'package:roboeducacional/custom_app_bar.dart';
import 'package:roboeducacional/custom_drawer.dart';
import 'package:roboeducacional/tab_view.dart';
import 'package:roboeducacional/trash_can.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool isShowingModal = false;
  List<Bloco> blocksList = [
    Bloco(
      title: "Girar para Direita",
      image: 'assets/bloco-atras.svg',
      description: "Este bloco tem a função de rotacionar para direita.",
      value: 0,
      link: "#",
    ),
    Bloco(
      title: "Girar para Direita",
      image: 'assets/bloco-frente.svg',
      description: "Este bloco tem a função de rotacionar para direita.",
      value: 0,
      link: "#",
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      backgroundColor: const Color(0xFFE9E9E9),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomAppBar(),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(children: _createBlocksInLine(blocksList)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: AddButton(
                          onTap: _openModal,
                        ),
                      ),
                      const TrashCan(),
                    ],
                  )
                ]),
            Container(
              height: isShowingModal ? null : 0,
              color: Colors.black38,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: _closeModal,
                    ),
                  ),
                  TabView(
                    onDragStarted: () {
                      _closeModal();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _closeModal() {
    setState(() {
      isShowingModal = false;
    });
  }

  _openModal() {
    setState(() {
      isShowingModal = true;
    });
  }
}

List<Widget> _createBlocksInLine(List blocksList) {
  return blocksList.map((e) => BlocInLine(block: e)).toList();
}
