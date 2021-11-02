import 'package:flutter/material.dart';
import 'package:noko_prototype/core/constants.dart';
import 'package:noko_prototype/src/features/map/presentation/widgets/custom_divider.dart';

class UnderlinedTextTile extends StatelessWidget {
  final String label, description;
  final VoidCallback callback;
  final bool isDark;

  const UnderlinedTextTile({
    Key? key,
    required this.label,
    required this.description,
    required this.callback,
    this.isDark = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w400,
          ),
        ),
        Text(description),
        const SizedBox(
          height: Constraints.kDefaultPadding * 0.5,
        ),
        CustomDivider(
          color: isDark ? Constraints.kLightColor() : Constraints.kDarkColor(),
        ),
        const SizedBox(
          height: Constraints.kDefaultPadding * 0.8,
        ),
      ],
    );
  }
}
