import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_painter/cubit/grid_cubit.dart';
import 'package:github_painter/di.dart';
import 'package:github_painter/services/convert.dart';
import 'package:github_painter/widgets/contribution_grid.dart';
import 'package:github_painter/widgets/sh_output.dart';
import 'package:github_painter/widgets/year_select.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int year = DateTime.now().year;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromARGB(255, 128, 237, 231),
      body: BlocBuilder<GridCubit, GridState>(
        builder: (context, state) {
          if (state is EditState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () =>
                            sl.get<ConvertService>().importImage(context, year),
                        style: TextButton.styleFrom(
                            foregroundColor:
                                const Color.fromARGB(255, 255, 255, 255),
                            backgroundColor:
                                const Color.fromARGB(255, 106, 106, 106),
                            padding: const EdgeInsets.all(10)),
                        child: const Text("Import"),
                      ),
                      YearSelect(
                        onSubmit: (year) {
                          try {
                            setState(() {
                              this.year = int.parse(year);
                            });
                            print(year);
                          } catch (e) {
                            print("error $e");
                          }
                        },
                      )
                    ],
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 2 / 3,
                    child: ContributionGrid(grid: state.grid),
                  ),

                  TextButton(
                      onPressed: () {
                        context.read<GridCubit>().setGrid(
                            (context.read<GridCubit>().state as EditState).grid,
                            sl
                                .get<ConvertService>()
                                .convertContributionGridToShell(
                                    (context.read<GridCubit>().state
                                            as EditState)
                                        .grid,
                                    year));
                      },
                      child: const Text("Generate Shell Script"),
                      style: TextButton.styleFrom(
                          primary: const Color.fromARGB(255, 255, 255, 255),
                          backgroundColor:
                              const Color.fromARGB(255, 106, 106, 106),
                          padding: const EdgeInsets.all(10))),
                  FractionallySizedBox(
                    widthFactor: 2 / 3,
                    child: ShOutput(
                        output: (context.watch<GridCubit>().state as EditState)
                            .output),
                  ),
                  // Expanded(
                  //   child: FutureBuilder(
                  //     future: sl.get<ConvertService>().createProccessedImage(context, 'assets/images/image5.png'),
                  //     builder: (context, snapshot) {
                  //       if (snapshot.hasData) {
                  //         return Container(
                  //             // decoration: BoxDecoration(
                  //             child: RawImage(image: snapshot.data)
                  //             // ),
                  //             );
                  //       } else if (snapshot.hasError) {
                  //         return Text("loading/error");
                  //       } else {
                  //         return Text("loading/error");
                  //       }
                  //     },
                  //   ),
                  // ),
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
