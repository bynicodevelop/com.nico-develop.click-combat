import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PainterHelper extends CustomPainter {
  final DrawableRoot svg;
  final Size size;

  PainterHelper(
    this.svg,
    this.size,
  );

  @override
  void paint(Canvas canvas, Size size) {
    svg.scaleCanvasToViewBox(
      canvas,
      this.size,
    );
    svg.clipCanvasToViewBox(
      canvas,
    );
    svg.draw(
      canvas,
      Rect.zero,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
