import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: const Color(0xFF2E9AD1),
        child: Column(
          children: const [
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
                'Novo Arquivo',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.folder_copy,
                color: Colors.white,
                size: 25,
              ),
              title: Text('Carregar Arquivo',
                  style: TextStyle(fontSize: 20, color: Colors.white)),
            ),
            ListTile(
              leading: Icon(
                Icons.save_alt,
                color: Colors.white,
                size: 25,
              ),
              title: Text('Salvar no Computador',
                  style: TextStyle(fontSize: 20, color: Colors.white)),
            ),
            Divider(
              thickness: 3,
              height: 20,
              color: Color(0xFF172585),
            ),
            ListTile(
              leading: Icon(
                Icons.info_outline,
                color: Colors.white,
                size: 25,
              ),
              title: Text('Sobre',
                  style: TextStyle(fontSize: 20, color: Colors.white)),
            ),
            ListTile(
              leading: Icon(
                Icons.content_paste,
                color: Colors.white,
                size: 25,
              ),
              title: Text('Termos de Uso',
                  style: TextStyle(fontSize: 20, color: Colors.white)),
            ),
            ListTile(
              leading: Icon(
                Icons.help_outline,
                color: Colors.white,
                size: 25,
              ),
              title: Text('Ajuda',
                  style: TextStyle(fontSize: 20, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
