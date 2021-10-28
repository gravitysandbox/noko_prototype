import 'package:flutter/material.dart';
import 'package:noko_prototype/src/constants.dart';

class NavigationButton extends StatelessWidget {
  final bool isLeft;

  const NavigationButton({Key? key, required this.isLeft}) : super(key: key);

  void _openSidebarHandler(BuildContext context) {
    isLeft
        ? Scaffold.of(context).openDrawer()
        : Scaffold.of(context).openEndDrawer();
  }

  @override
  Widget build(BuildContext context) {
    const circularRadius = kDefaultButtonSize / 2.0;

    return Container(
      height: kDefaultButtonSize,
      width: kDefaultButtonSize,
      decoration: BoxDecoration(
        borderRadius: isLeft
            ? const BorderRadius.only(
                topRight: Radius.circular(circularRadius),
                bottomRight: Radius.circular(circularRadius),
              )
            : const BorderRadius.only(
                topLeft: Radius.circular(circularRadius),
                bottomLeft: Radius.circular(circularRadius),
              ),
        color: Colors.white,
      ),
      child: GestureDetector(
        onTap: () => _openSidebarHandler(context),
        child: Icon(
          isLeft
              ? Icons.keyboard_arrow_right_outlined
              : Icons.keyboard_arrow_left_outlined,
          size: kDefaultButtonSize,
          color: Colors.grey,
        ),
      ),
    );
  }
}
