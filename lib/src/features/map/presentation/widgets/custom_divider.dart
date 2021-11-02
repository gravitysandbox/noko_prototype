import 'package:flutter/material.dart';
import 'package:noko_prototype/core/constants.dart';

class CustomDivider extends StatelessWidget {
  final bool isVertical;
  final double? size, thickness, indent, endIndent;
  final Color? color;

  const CustomDivider({
    Key? key,
    this.isVertical = false,
    this.size = 2.0,
    this.thickness = 2.0,
    this.indent = 0.0,
    this.endIndent = 0.0,
    this.color = Constraints.kDefaultButtonColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isVertical
        ? VerticalDivider(
            width: size,
            thickness: thickness,
            indent: indent,
            endIndent: endIndent,
            color: color,
          )
        : Divider(
            height: size,
            thickness: thickness,
            indent: indent,
            endIndent: endIndent,
            color: color,
          );
  }
}
