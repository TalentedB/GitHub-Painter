import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:github_painter/services/convert.dart';

part 'grid_state.dart';

class GridCubit extends Cubit<GridState> {
  GridCubit()
      : super(EditState(List.generate(
            7,
            (_) => List.generate(
                52, (_) => GreenIntensity(Random().nextInt(4))))));

  void setGrid(List<List<GreenIntensity>> newGrid) => emit(EditState(newGrid));

  // to call (remember imports)
  // context.read<GridCubit>().METHOD_NAME
}
