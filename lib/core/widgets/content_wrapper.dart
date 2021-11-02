import 'package:flutter/material.dart';
import 'package:noko_prototype/core/constants.dart';

class ContentWrapper extends StatelessWidget {
  final Widget widget;
  final double verticalPadding;
  final double horizontalPadding;

  const ContentWrapper({
    Key? key,
    required this.widget,
    this.verticalPadding = Constraints.kDefaultPadding,
    this.horizontalPadding = Constraints.kDefaultPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: verticalPadding,
        horizontal: horizontalPadding,
      ),
      child: widget,
    );
  }
}
