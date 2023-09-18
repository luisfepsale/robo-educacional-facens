import 'package:flutter/material.dart';
import 'package:roboeducacional/bluetooth.dart';
import 'package:roboeducacional/features/block/presentation/pages/blocks_homepage.dart';

import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const FlutterBlueApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: BlocksHomePage());
  }
}
