import 'package:flutter/material.dart';
import 'package:github_painter/domain/convert.dart';
import 'package:github_painter/widgets/green_tile.dart';

class ContributionGrid extends StatelessWidget {
  const ContributionGrid({super.key, required this.grid});

  final List<List<GreenIntensity>> grid;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          color: Colors.black,
        ),
        child: GridView.builder(
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: grid[0].length,
          ),
          itemCount: grid.length * grid[0].length, // Total number of cells
          itemBuilder: (BuildContext context, int index) {
            final row = index ~/ grid[0].length;
            final column = index % grid[0].length;
            return GreenTile(intensity: grid[row][column]);
          },
        ),
      ),
    );
  }
}
