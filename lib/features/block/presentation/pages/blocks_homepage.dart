import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:roboeducacional/custom_app_bar.dart';
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
        body: Scaffold(
          body: Stack(
            children: [
              Column(
                children: [
                  CustomAppBar(),
                  BlocksInLine(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _AddButton(),
                      _TrashCan(),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AddButton extends StatelessWidget {
  const _AddButton();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: 80,
      icon: SvgPicture.asset(
        'assets/add_button.svg',
      ),
      onPressed: () {
        final listOfBlocks = context.read<BlocksInLineBloc>().state.blocks;
        final result = listOfBlocks.map((e) => '${e.id}').toList();
        print(result);
      },
    );
  }
}

class _TrashCan extends StatelessWidget {
  const _TrashCan();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BlocksInLineBloc, BlocksInLineState>(
      builder: (context, state) {
        return DragTarget<int>(
          onAccept: (data) => context
              .read<BlocksInLineBloc>()
              .add(BlocksInLineEventRemoveBlock(positionOnLine: data)),
          builder: (_, __, ___) => SizedBox(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SvgPicture.asset(
                'assets/lixo.svg',
                height: 80,
                width: 80,
              ),
            ),
          ),
        );
      },
    );
  }
}
