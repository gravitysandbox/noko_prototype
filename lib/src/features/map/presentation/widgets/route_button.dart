import 'package:flutter/material.dart';
import 'package:noko_prototype/core/constants.dart';

class RouteButton extends StatelessWidget {
  final String label;
  final VoidCallback callback;
  final bool isActive, isDark;

  const RouteButton({
    Key? key,
    required this.label,
    required this.callback,
    required this.isActive,
    this.isDark = false,
  }) : super(key: key);

  static const busActiveColor = Colors.lightGreen;
  static const shuttleActiveColor = Color(0xFFF3CC30);
  static const trolleyActiveColor = Colors.pinkAccent;
  static const disableColor = Constraints.kDefaultButtonColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        height: Constraints.kDefaultButtonSize * 0.9,
        decoration: BoxDecoration(
          color: isActive ? busActiveColor : null,
          border: Border.all(
            color: disableColor,
            width: 2.0,
          ),
          borderRadius: const BorderRadius.all(
              Radius.circular(Constraints.kDefaultButtonSize * 0.2)),
        ),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              color: (isDark || isActive) ? Colors.white : disableColor,
            ),
          ),
        ),
      ),
    );
  }
}
