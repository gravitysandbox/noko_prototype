import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noko_prototype/core/bloc/app_bloc.dart';
import 'package:noko_prototype/core/bloc/app_state.dart';
import 'package:noko_prototype/core/constants.dart';
import 'package:noko_prototype/core/widgets/content_wrapper.dart';

class CustomSidebar extends StatelessWidget {
  final Widget widget;

  const CustomSidebar({
    Key? key,
    required this.widget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppBlocState>(
      buildWhen: (prev, current) {
        return prev.isDarkTheme != current.isDarkTheme;
      },
      builder: (context, state) {
        return Theme(
          data: Theme.of(context).copyWith(
            canvasColor: state.isDarkTheme
                ? Constraints.kDarkColor()
                : Constraints.kLightColor(),
          ),
          child: Drawer(
            child: ContentWrapper(
              widget: widget,
            ),
          ),
        );
      },
    );
  }
}
