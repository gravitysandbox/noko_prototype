import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noko_prototype/core/bloc/app_bloc.dart';
import 'package:noko_prototype/core/bloc/app_state.dart';
import 'package:noko_prototype/core/constants.dart';

class NavigationButton extends StatelessWidget {
  final bool isLeft;

  const NavigationButton({Key? key, required this.isLeft}) : super(key: key);

  void _openSidebarHandler(BuildContext context) {
    isLeft
        ? Scaffold.of(context).openDrawer()
        : Scaffold.of(context).openEndDrawer();
  }

  @override
  Widget build(BuildContext context) {
    const circularRadius = StyleConstants.kDefaultButtonSize * 0.5;

    return BlocBuilder<AppBloc, AppBlocState>(
      buildWhen: (prev, current) {
        return prev.isDarkTheme != current.isDarkTheme;
      },
      builder: (context, state) {
        return Container(
          height: StyleConstants.kDefaultButtonSize,
          width: StyleConstants.kDefaultButtonSize,
          decoration: BoxDecoration(
            borderRadius: isLeft
                ? const BorderRadius.only(
                    topRight: Radius.circular(circularRadius),
                    bottomRight: Radius.circular(circularRadius),
                  )
                : const BorderRadius.only(
                    topLeft: Radius.circular(circularRadius),
                    bottomLeft: Radius.circular(circularRadius),
                  ),
            color: state.isDarkTheme
                ? StyleConstants.kDarkColor()
                : StyleConstants.kLightColor(),
          ),
          child: GestureDetector(
            onTap: () => _openSidebarHandler(context),
            child: Icon(
              isLeft
                  ? Icons.keyboard_arrow_right_outlined
                  : Icons.keyboard_arrow_left_outlined,
              size: StyleConstants.kDefaultButtonSize,
              color: state.isDarkTheme
                  ? StyleConstants.kLightColor()
                  : StyleConstants.kDarkColor(),
            ),
          ),
        );
      },
    );
  }
}
