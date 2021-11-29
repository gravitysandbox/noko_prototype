import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noko_prototype/core/constants.dart';

class GarageScreen extends StatelessWidget {
  static const routeName = '/garage';

  const GarageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTextStyle(
        style: StyleConstants.kDarkTheme.textTheme.bodyText2!,
        child: Scaffold(
          backgroundColor: StyleConstants.kPrimaryColor,
          body: Column(
            children: <Widget>[],
          ),
        ),
      ),
    );
  }
}
