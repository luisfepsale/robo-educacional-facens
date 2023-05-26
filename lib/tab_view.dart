import 'package:flutter/material.dart';
import 'package:roboeducacional/block.dart';
import 'package:roboeducacional/block_model.dart';

class TabView extends StatefulWidget {
  const TabView({super.key, required this.onDragStarted});

  @override
  State<TabView> createState() => _TabViewState();

  final Function() onDragStarted;
}

final Map<String, List<Bloco>> blocos = {
  "movimentos": [
    Bloco(
        title: "Frente",
        image: 'assets/bloco-frente.svg',
        description: "Este bloco tem a função de andar para frente.",
        value: 0,
        link: "#"),
    Bloco(
        title: "Atrás",
        image: "assets/bloco-atras.svg",
        description: "Este bloco tem a função de andar para trás.",
        value: 0,
        link: "#"),
    Bloco(
        title: "Girar para Direita",
        image: 'assets/bloco-rotacao-direita.svg',
        description: "Este bloco tem a função de rotacionar para direita.",
        value: 0,
        link: "#"),
    Bloco(
        title: "Girar para esquerda",
        image: 'assets/bloco-rotacao.svg',
        description: "Este bloco tem a função de rotacionar para a esquerda.",
        value: 0,
        link: "#"),
  ],
  "inicializadores": [
    Bloco(
        title: "Inicial",
        image: 'assets/Inicializador-1.svg',
        description:
            "Este bloco tem a função de inicializar a sequência lógica.",
        value: 0,
        link: "#"),
  ],
};

class _TabViewState extends State<TabView> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      color: Colors.white,
      height: size.height * 0.5,
      child: DefaultTabController(
        length: blocos.keys.length,
        child: Column(children: [
          Container(
            margin: const EdgeInsets.only(top: 5),
            width: size.width,
            height: 60,
            child: Column(
              children: [
                TabBar(
                  isScrollable: true,
                  indicatorPadding: const EdgeInsets.only(
                    top: 0,
                    right: -9,
                    left: 0,
                    bottom: 8,
                  ),
                  indicator: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Color(0xFF2E9AD1),
                        width: 2.5,
                      ),
                    ),
                  ),
                  indicatorSize: TabBarIndicatorSize.label,
                  labelStyle: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18),
                  tabs: _createTabs(blocos.keys.toList()),
                ),
              ],
            ),
          ),
          // _createTabViews(blocos).first
          Expanded(
              child: TabBarView(
                  children: _createTabViews(blocos, widget.onDragStarted)))
        ]),
      ),
    );
  }
}

List<Widget> _createTabs(List keys) {
  return keys
      .map(
        (e) => Tab(
            child: Text(_uppercaseFirstLetter(e),
                style: const TextStyle(color: Colors.black))),
      )
      .toList();
}

_uppercaseFirstLetter(String value) =>
    value[0].toUpperCase() + value.substring(1);

List<Widget> _createTabViews(Map<String, List<Bloco>> blockMap, onDragStarted) {
  final keys = blockMap.keys;

  final list = keys
      .map((e) => blockMap[e]!
          .map((e) => Block(
                block: e,
                onDragStarted: onDragStarted,
              ))
          .toList())
      .toList();

  final gridList = list
      .map((e) => GridView.count(
            crossAxisCount: 3,
            crossAxisSpacing: 25,
            mainAxisSpacing: 15,
            children: e.map((e) => e).toList(),
          ))
      .toList();

  return gridList;
}
