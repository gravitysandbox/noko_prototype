import 'package:flutter/material.dart';
import 'package:noko_prototype/src/constants.dart';

class RouteButton extends StatelessWidget {
  final String label;
  final VoidCallback callback;
  final bool isActive;
  final bool isBus;

  const RouteButton({
    Key? key,
    required this.label,
    required this.callback,
    required this.isActive,
    required this.isBus,
  }) : super(key: key);

  static const busActiveColor = Colors.lightGreen;
  static const shuttleActiveColor = Color(0xFFF3CC30);
  static const trolleyActiveColor = Colors.pinkAccent;
  static const disableColor = kDefaultTextColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        height: kDefaultButtonSize * 0.9,
        decoration: BoxDecoration(
          color: isActive
              ? isBus
                  ? busActiveColor
                  : shuttleActiveColor
              : null,
          border: Border.all(color: disableColor),
          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
        ),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(color: isActive ? Colors.white : disableColor),
          ),
        ),
      ),
    );
  }
}
