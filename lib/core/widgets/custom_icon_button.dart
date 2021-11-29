import 'package:flutter/material.dart';
import 'package:noko_prototype/core/constants.dart';

class CustomIconButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback callback;

  const CustomIconButton({
    Key? key,
    required this.label,
    required this.icon,
    this.color = StyleConstants.kDefaultButtonColor,
    required this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const iconSize = StyleConstants.kDefaultButtonSize * 0.5;

    return GestureDetector(
      onTap: callback,
      child: SizedBox(
        height: StyleConstants.kDefaultButtonSize,
        child: Row(
          children: <Widget>[
            SizedBox(
              height: iconSize,
              width: iconSize,
              child: FittedBox(
                child: Icon(
                  icon,
                  color: color,
                ),
              ),
            ),
            const SizedBox(
              width: StyleConstants.kDefaultPadding,
            ),
            Text(
              label,
              style: TextStyle(
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
