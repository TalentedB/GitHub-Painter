part of 'grid_cubit.dart';

abstract class GridState extends Equatable {
  const GridState();

  @override
  List<Object> get props => [];
}

class EditState extends GridState {
  final List<List<GreenIntensity>> grid;

  const EditState(this.grid);

  @override
  List<Object> get props => [];
}
