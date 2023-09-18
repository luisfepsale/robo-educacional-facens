import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roboeducacional/features/block/presentation/pages/bloc/blocks_in_line_bloc.dart';
import 'package:roboeducacional/features/block/presentation/pages/blocks_line_page.dart';

class BlocksHomePage extends StatelessWidget {
  const BlocksHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BlocksInLineBloc(),
      child: const Scaffold(
        backgroundColor: Color(0xFFE9E9E9),
        body: Stack(
          children: [
            Column(
              children: [
                BlocksInLine(),
                _TrashCan(),
                // ElevatedButton(
                //     onPressed: () {
                //       showDialog(
                //           context: context,
                //           builder: (context) {
                //             return const BluetoothScreen(listLogic: []);
                //           });
                //     },
                //     child: const Text('Executar'))
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _TrashCan extends StatelessWidget {
  const _TrashCan();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BlocksInLineBloc, BlocksInLineState>(
      builder: (context, state) {
        return Align(
          alignment: Alignment.bottomRight,
          child: DragTarget<int>(
            onAccept: (data) {
              context
                  .read<BlocksInLineBloc>()
                  .add(BlocksInLineEventRemoveBlock(positionOnLine: data));
            },
            builder: (context, candidateData, rejectedData) {
              return const Padding(
                padding: EdgeInsets.all(16.0),
                child: Icon(Icons.delete, size: 32),
              );
            },
          ),
        );
      },
    );
  }
}
