import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
      height: 60,
      alignment: Alignment.center,

      decoration: BoxDecoration(
        color: const Color(0xFF2E9AD1),
        border: Border.all(
            width: 6, color: const Color.fromRGBO(19, 31, 109, 0.612)),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.menu, size: 34)),
          const Text("Project Name",
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  color: Colors.white,
                  shadows: <Shadow>[
                    Shadow(
                      offset: Offset(2.0, 2.0),
                      blurRadius: 10.0,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ])),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.play_circle_outline_sharp,
                size: 34,
              )),
        ],
      ),
      // child: Row(
      //   icon: Icon(Icons.menu)
      //   Text("Name Project")
      // ),
    );
  }
}
