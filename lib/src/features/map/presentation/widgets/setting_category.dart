import 'package:flutter/material.dart';
import 'package:noko_prototype/core/constants.dart';
import 'package:noko_prototype/core/widgets/multiple_switch.dart';

class SettingCategory extends StatelessWidget {
  final String label;
  final Set<String> switches;
  final Function(int) callback;
  final int activePosition;
  final bool isDisabled;

  const SettingCategory({
    Key? key,
    required this.label,
    required this.switches,
    required this.callback,
    required this.activePosition,
    this.isDisabled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            label,
            style: const TextStyle(
              fontSize: 18.0,
            ),
          ),
          const SizedBox(
            height: Constraints.kDefaultPadding * 0.5,
          ),
          AbsorbPointer(
            absorbing: isDisabled,
            child: MultipleSwitch(
              width: constraints.maxWidth,
              switches: switches,
              callback: callback,
              activePosition: activePosition,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              isDisabled: isDisabled,
            ),
          ),
        ],
      );
    });
  }
}
