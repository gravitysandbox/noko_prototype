import 'package:flutter/material.dart';
import 'package:noko_prototype/core/constants.dart';

class CategoryButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback callback;

  const CategoryButton({
    Key? key,
    required this.label,
    required this.icon,
    this.color = Constraints.kDefaultButtonColor,
    required this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const iconSize = Constraints.kDefaultButtonSize * 0.5;

    return GestureDetector(
      onTap: callback,
      child: SizedBox(
        height: Constraints.kDefaultButtonSize,
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
              width: Constraints.kDefaultPadding,
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