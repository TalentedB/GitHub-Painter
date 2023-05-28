import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_painter/cubit/grid_cubit.dart';
import 'package:github_painter/di.dart';
import 'package:github_painter/domain/convert.dart';
import 'package:github_painter/widgets/contribution_grid.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: BlocBuilder<GridCubit, GridState>(
        builder: (context, state) {
          if (state is EditState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () => sl.get<ConvertService>().imageToContributionGrid(),
                    child: const Text("chris click here"),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 2 / 3,
                    child: ContributionGrid(grid: state.grid),
                  ),
                ],
              ),
            );
          } else {
            return const Center(
              child: Text("error"),
            );
          }
        },
      ),
    );
  }
}
