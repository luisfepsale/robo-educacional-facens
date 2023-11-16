import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:roboeducacional/custom_app_bar.dart';
import 'package:roboeducacional/custom_drawer.dart';
import 'package:roboeducacional/features/block/domain/block_entity.dart';
import 'package:roboeducacional/features/block/presentation/pages/bloc/blocks_in_line_bloc.dart';
import 'package:roboeducacional/features/block/presentation/pages/bloc/widgets/block_library/block_library.dart';
import 'package:roboeducacional/features/block/presentation/pages/bloc/widgets/block_library/cubit/block_library_cubit.dart';
import 'package:roboeducacional/features/block/presentation/pages/blocks_line_page.dart';

class BlocksHomePage extends StatelessWidget {
  const BlocksHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      drawer: CustomDrawer(),
      backgroundColor: Color(0xFFE9E9E9),
      body: Stack(
        children: [
          Column(
            children: [
              CustomAppBar(),
              Expanded(
                child: Row(
                  children: [
                    BlocksInLine(),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _AddButton(),
                  _TrashCan(),
                ],
              )
            ],
          ),
          BlocksLibrary(),
        ],
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
      onPressed: () async {
        context.read<BlockLibraryCubit>().openLibrary();
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
        return DragTarget(
          onAccept: (data) {
            if (data is BlockEntity) {
              return;
            }

            if (data is int) {
              context
                  .read<BlocksInLineBloc>()
                  .add(BlocksInLineEventRemoveBlock(removeId: data));
            }
          },
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
