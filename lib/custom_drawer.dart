import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Drawer(
      child: Material(
        color: Color(0xFF2E9AD1),
        child: Column(
          children: [
            DrawerHeader(
                child: Icon(
              Icons.build_circle,
              size: 120,
              color: Colors.white,
            )),
            ListTile(
              leading: Icon(
                Icons.note_add,
                color: Colors.white,
                size: 25,
              ),
              title: Text(
                'Sobre o Projeto',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
