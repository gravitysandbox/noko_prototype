import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:noko_prototype/core/bloc/app_bloc.dart';
import 'package:noko_prototype/core/bloc/app_state.dart';

class LoadingIndicator extends StatelessWidget {
  final double size;

  const LoadingIndicator({
    Key? key,
    this.size = 100.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppBlocState>(buildWhen: (prev, current) {
      return prev.isDarkTheme != current.isDarkTheme;
    }, builder: (context, state) {
      return SpinKitRing(
        size: size,
        color: state.isDarkTheme ? Colors.white : Colors.blueGrey.shade100,
      );
    });
  }
}
