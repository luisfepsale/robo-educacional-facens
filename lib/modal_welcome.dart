import 'package:flutter/material.dart';

class ModalWelcome extends StatelessWidget {
  const ModalWelcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(
              width: 3,
              color: Colors.blue,
            )),
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Bem-vindo ao projeto 'Robô Educacional' ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Color(0xFF2E9AD1),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Este é um projeto de trabalho de conclusão de curso da FACENS (Faculdade de Engenharia de Sorocaba ), realizado pelos alunos: Gabriela Miranda Domingues 190634, Lívia Sayuri Chinem Moreno 190374, Luís Felipe Martins Salinas 190380. O objetivo deste trabalho é apresentar uma nova maneira de ensino nas escolas brasileiras, utilizando tecnologias atuais e economicas. Agrademos a todos que participaram do progresso no desenvolvimento deste projeto. ",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Color(0xFF585858),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: const ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(Color(0xFF2E9AD1))),
                  child: const Text(
                    'Começar Agora!',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
