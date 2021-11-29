import 'package:flutter/material.dart';
import 'package:noko_prototype/core/constants.dart';

class TopUpBalanceButton extends StatelessWidget {
  final String label;
  final VoidCallback callback;

  const TopUpBalanceButton({
    Key? key,
    required this.label,
    required this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: StyleConstants.kDefaultButtonSize * 0.25,
          horizontal: StyleConstants.kDefaultButtonSize * 0.2,
        ),
        decoration: BoxDecoration(
          color: StyleConstants.kDarkColor(),
          borderRadius: const BorderRadius.all(
              Radius.circular(StyleConstants.kDefaultButtonSize * 0.4)),
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 16.0,
            color: StyleConstants.kPrimaryColor,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
