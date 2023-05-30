part of 'grid_cubit.dart';

abstract class GridState extends Equatable {
  const GridState();

  @override
  List<Object> get props => [];
}

class EditState extends GridState {
  final List<List<GreenIntensity>> grid;
  final String output;

  const EditState(this.grid, this.output);

  @override
  bool operator ==(Object other) {
    return false;
  }

  @override
  List<Object> get props => [grid, output];
}
