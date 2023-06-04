import 'package:flutter/material.dart';

import '../services/convert.dart';
import 'green_tile.dart';

class GreenIntensityKey extends StatelessWidget {
  const GreenIntensityKey({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          color: Colors.black,
        ),
        child: Wrap(
          spacing: 8,
          runSpacing: 8,
          // 0, 1 ... 4
          children: List.generate(5, (idx) {
            return Container(
                height: 15,
                width: 15,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(2))),
                child: GreenTile(
                  intensity: GreenIntensity(idx),
                ));
          }),
        ),
      ),
    );
  }
}
