import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:roboeducacional/features/bluetooth/presentations/dialogs/modal_search_device.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 45, horizontal: 20),
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
            icon: SvgPicture.asset(
              'assets/menu.svg',
              height: 100,
              width: 100,
            ),
          ),
          const Text(
            "Project Name",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => const SearchDeviceDialog(),
              );
            },
            icon: SvgPicture.asset(
              'assets/startt.svg',
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
