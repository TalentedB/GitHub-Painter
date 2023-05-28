import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:github_painter/domain/convert.dart';

part 'grid_state.dart';

class GridCubit extends Cubit<GridState> {
  GridCubit()
      : super(EditState(List.generate(7, (_) => List.generate(52, (_) => GreenIntensity(Random().nextInt(4))))));
}
