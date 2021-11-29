import 'package:flutter/material.dart';
import 'package:noko_prototype/core/constants.dart';

class CustomOutlinedButton extends StatelessWidget {
  final String title;
  final String? subtitle;
  final TextStyle? titleStyle, subtitleStyle;
  final Widget asset;
  final Widget? leading;
  final Color color;
  final VoidCallback callback;
  final bool isActive;

  CustomOutlinedButton({
    Key? key,
    required this.title,
    this.subtitle,
    this.titleStyle,
    this.subtitleStyle,
    required this.asset,
    this.leading,
    this.color = StyleConstants.kDefaultButtonColor,
    required this.callback,
    this.isActive = false,
  }) : super(key: key);

  final Color _activeColor = StyleConstants.kPrimaryColor;
  final Color _disableColor = Colors.grey.withOpacity(0.3);

  @override
  Widget build(BuildContext context) {
    const buttonSize = StyleConstants.kDefaultButtonSize * 1.2;
    const assetSize = StyleConstants.kDefaultButtonSize * 0.8;

    return GestureDetector(
      onTap: callback,
      child: Container(
        height: buttonSize,
        padding: const EdgeInsets.symmetric(
          vertical: StyleConstants.kDefaultPadding * 0.4,
          horizontal: StyleConstants.kDefaultPadding * 0.6,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: isActive ? _activeColor : _disableColor,
            width: 2.0,
          ),
          borderRadius: const BorderRadius.all(
              Radius.circular(StyleConstants.kDefaultButtonSize * 0.2)),
        ),
        child: Row(
          children: <Widget>[
            SizedBox(
              height: assetSize,
              width: assetSize,
              child: FittedBox(
                child: asset,
              ),
            ),
            const SizedBox(
              width: StyleConstants.kDefaultPadding * 0.7,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        title,
                        style: titleStyle ??
                            TextStyle(
                              fontSize: 20.0,
                              color: color,
                            ),
                      ),
                      if (subtitle != null)
                        Text(
                          subtitle!,
                          style: subtitleStyle ??
                              TextStyle(
                                fontSize: 14.0,
                                color: color.withOpacity(0.5),
                              ),
                        ),
                    ],
                  ),
                  if (leading != null) leading!,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
