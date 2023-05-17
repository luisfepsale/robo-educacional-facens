import 'package:flutter/material.dart';
import 'package:roboeducacional/add_button.dart';
import 'package:roboeducacional/bloc_in_line.dart';
import 'package:roboeducacional/custom_app_bar.dart';
import 'package:roboeducacional/tab_view.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool isShowingModal = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    child: Row(
                      children: const [
                        BlocInLine(),
                        BlocInLine(),
                        BlocInLine(),
                        BlocInLine(),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: AddButton(
                      onTap: _openModal,
                    ),
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
