import 'package:flutter/material.dart';
import 'package:noko_prototype/src/constants.dart';

class TileButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback callback;

  const TileButton({
    Key? key,
    required this.label,
    required this.icon,
    this.color = kDefaultTextColor,
    required this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const iconSize = kDefaultButtonSize * 0.5;

    return GestureDetector(
      onTap: callback,
      child: SizedBox(
        height: kDefaultButtonSize,
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
              width: kDefaultPadding,
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
