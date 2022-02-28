import 'package:com_nico_develop_click_combat/helpers/painter_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgAvatar extends StatelessWidget {
  final DrawableRoot svgRoot;
  final double size;
  final double paddingDelta;

  const SvgAvatar({
    Key? key,
    required this.svgRoot,
    this.size = 180,
    this.paddingDelta = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 10,
        horizontal:
            (MediaQuery.of(context).size.width - size - paddingDelta) / 2,
      ),
      height: size + 20,
      width: double.infinity,
      child: CustomPaint(
        painter: PainterHelper(
          svgRoot,
          Size(
            size,
            size,
          ),
        ),
      ),
    );
  }
}
