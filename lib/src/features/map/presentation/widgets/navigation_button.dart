import 'package:flutter/material.dart';

class NavigationButton extends StatelessWidget {
  final bool isLeft;

  const NavigationButton({Key? key, required this.isLeft}) : super(key: key);

  static const double _buttonSize = 50.0;

  void _openSidebarHandler(BuildContext context) {
    isLeft
        ? Scaffold.of(context).openDrawer()
        : Scaffold.of(context).openEndDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: isLeft
            ? const BorderRadius.only(
                topRight: Radius.circular(_buttonSize / 2.0),
                bottomRight: Radius.circular(_buttonSize / 2.0),
              )
            : const BorderRadius.only(
                topLeft: Radius.circular(_buttonSize / 2.0),
                bottomLeft: Radius.circular(_buttonSize / 2.0),
              ),
        color: Colors.white,
      ),
      child: GestureDetector(
        onTap: () => _openSidebarHandler(context),
        child: Icon(
          isLeft
              ? Icons.keyboard_arrow_right_outlined
              : Icons.keyboard_arrow_left_outlined,
          size: _buttonSize,
          color: Colors.grey,
        ),
      ),
    );
  }
}
