import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:roboeducacional/block.dart';

class TabView extends StatefulWidget {
  const TabView({super.key});

  @override
  State<TabView> createState() => _TabViewState();
}

class _TabViewState extends State<TabView> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 5),
          width: size.width,
          height: 60,
          child: const DefaultTabController(
            length: 3,
            child: TabBar(
              isScrollable: true,
              indicatorPadding: EdgeInsets.only(
                top: 0,
                right: -9,
                left: 0,
                bottom: 8,
              ),
              indicator: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Color(0xFF2E9AD1),
                    width: 2.5,
                  ),
                ),
              ),
              indicatorSize: TabBarIndicatorSize.label,
              labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              tabs: [
                Tab(
                  child: Text(
                    "Movimento",
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
                Tab(
                  child: Text(
                    "Inicializadorse",
                  ),
                ),
                Tab(
                  child: Text(
                    "Repetidore",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: GridView.count(
              crossAxisCount: 3,
              crossAxisSpacing: 25,
              mainAxisSpacing: 15,
              children: List.generate(100, (index) {
                return const Block();
              }),
            ),
          ),
        ),
      ],
    );
  }
}
