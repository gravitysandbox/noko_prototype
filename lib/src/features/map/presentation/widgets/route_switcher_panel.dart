import 'package:flutter/material.dart';
import 'package:noko_prototype/core/constants.dart';

class RouteSwitcherPanel extends StatelessWidget {
  const RouteSwitcherPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const imageSize = Constraints.kDefaultButtonSize * 0.9;

    return Container(
      height: Constraints.kDefaultButtonSize,
      padding: const EdgeInsets.symmetric(horizontal: Constraints.kDefaultPadding / 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          GestureDetector(
            onTap: () {},
            child: Image.asset(
              'assets/images/btn_bus_green.png',
              height: imageSize,
              width: imageSize,
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Image.asset(
              'assets/images/btn_shuttle_yellow.png',
              height: imageSize,
              width: imageSize,
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Image.asset(
              'assets/images/btn_trolley_grey.png',
              height: imageSize,
              width: imageSize,
            ),
          ),
        ],
      ),
    );
  }
}
