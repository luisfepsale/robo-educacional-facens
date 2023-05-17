import 'package:flutter/material.dart';
import 'package:roboeducacional/block.dart';

class TabView extends StatefulWidget {
  const TabView({super.key});

  @override
  State<TabView> createState() => _TabViewState();
}

class Bloco {
  final String title;
  final String image;
  final String description;
  final double value;
  final String link;

  Bloco(
      {required this.title,
      required this.image,
      required this.description,
      required this.value,
      required this.link});
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
  "repetidores": [
    Bloco(
        title: "Repetidor",
        image: '',
        description:
            "Este bloco tem a função de repetir todos os blocos que estão dentro deste.",
        value: 0,
        link: "#"),
  ]
};

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
