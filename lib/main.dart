import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roboeducacional/features/block/presentation/pages/bloc/blocks_in_line_bloc.dart';
import 'package:roboeducacional/features/block/presentation/pages/bloc/widgets/block_library/cubit/block_library_cubit.dart';
import 'package:roboeducacional/features/block/presentation/pages/blocks_homepage.dart';

import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => BlocksInLineBloc(),
        ),
        BlocProvider(
          create: (context) => BlockLibraryCubit(),
        ),
      ],
      child: const MaterialApp(home: BlocksHomePage()),
    );
  }
}
