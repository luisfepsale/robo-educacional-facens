import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
          width: 5,
          color: const Color(0xFF172585),
        ),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: const Icon(
                color: Color(0xFF172585),
                Icons.menu,
                size: 35,
              )),
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
            icon: SvgPicture.asset(
              'assets/start.svg',
              height: 120,
              width: 120,
            ),
          ),
        ],
      ),
      // child: Row(
      //   icon: Icon(Icons.menu)
      //   Text("Name Project")
      // ),
    );
  }
}
