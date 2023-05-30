import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_painter/cubit/grid_cubit.dart';
import 'package:github_painter/di.dart';
import 'package:github_painter/services/convert.dart';
import 'package:github_painter/widgets/contribution_grid.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  XFile? _image;

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
                    onPressed: () =>
                        sl.get<ConvertService>().createProccessedImage(context, 'assets/images/image9.png'),
                    child: const Text("chris click here"),
                  ),
                  TextButton(
                    onPressed: () async => _image = await sl.get<ConvertService>().pickImg(),
                    child: const Text("pick img"),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 2 / 3,
                    child: ContributionGrid(grid: state.grid),
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
