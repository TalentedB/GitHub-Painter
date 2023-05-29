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
                    onPressed: () => sl
                        .get<ConvertService>()
                        .createProccessedImage(context, "TODO: path"),
                    child: const Text("chris click here"),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 2 / 3,
                    child: ContributionGrid(grid: state.grid),
                  ),
                  Expanded(
                    child: FutureBuilder(
                      future: sl
                          .get<ConvertService>()
                          .createProccessedImage(context, "TODO: path"),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Container(
                              // decoration: BoxDecoration(
                              child: RawImage(image: snapshot.data)
                              // ),
                              );
                        } else if (snapshot.hasError) {
                          return Text("loading/error");
                        } else {
                          return Text("loading/error");
                        }
                      },
                    ),
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
