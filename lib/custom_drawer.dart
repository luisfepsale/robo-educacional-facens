import 'package:flutter/material.dart';
import 'package:roboeducacional/modal_welcome.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: const Color(0xFF2E9AD1),
        child: Column(
          children: [
            const DrawerHeader(
                child: Icon(
              Icons.build_circle,
              size: 120,
              color: Colors.white,
            )),
            ListTile(
              leading: const Icon(
                Icons.note_add,
                color: Colors.white,
                size: 25,
              ),
              title: const Text(
                'Sobre o Projeto',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              onTap: () {
                Scaffold.of(context).closeDrawer();

                showDialog(
                  context: context,
                  builder: (context) => const ModalWelcome(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
