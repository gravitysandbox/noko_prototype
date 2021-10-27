import 'package:flutter/material.dart';

class ContentWrapper extends StatelessWidget {
  final Widget widget;

  const ContentWrapper({Key? key, required this.widget}) : super(key: key);

  static const double _defaultPadding = 20.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(_defaultPadding),
      child: widget,
    );
  }
}
