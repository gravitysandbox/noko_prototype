import 'package:flutter/material.dart';
import 'package:noko_prototype/core/constants.dart';
import 'package:noko_prototype/core/widgets/custom_divider.dart';

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
          height: StyleConstants.kDefaultPadding * 0.5,
        ),
        CustomDivider(
          color: isDark ? StyleConstants.kLightColor() : StyleConstants.kDarkColor(),
        ),
        const SizedBox(
          height: StyleConstants.kDefaultPadding * 0.8,
        ),
      ],
    );
  }
}
