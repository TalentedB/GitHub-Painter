import 'package:flutter/material.dart';
import 'package:github_painter/domain/convert.dart';

class GreenTile extends StatefulWidget {
  const GreenTile({super.key, required this.intensity});

  final GreenIntensity intensity;

  @override
  State<GreenTile> createState() => _GreenTileState();
}

class _GreenTileState extends State<GreenTile> {
  bool _isHovering = false;
  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      duration: const Duration(milliseconds: 50),
      scale: (_isHovering && widget.intensity.value() != 0) ? 1.4 : 1,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _isHovering = true),
        onExit: (_) => setState(() => _isHovering = false),
        child: Container(
          margin: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            color: widget.intensity.color(),
            border: Border.all(
              color: Colors.black.withOpacity(0.4),
              width: 1,
            ),
          ),
        ),
      ),
    );
  }
}
