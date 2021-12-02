import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noko_prototype/core/constants.dart';
import 'package:noko_prototype/core/widgets/custom_divider.dart';
import 'package:noko_prototype/src/features/garage/domain/bloc/garage_bloc.dart';
import 'package:noko_prototype/src/features/garage/domain/bloc/garage_state.dart';

class GarageScreen extends StatelessWidget {
  static const routeName = '/garage';

  const GarageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTextStyle(
        style: StyleConstants.kDarkTheme.textTheme.bodyText2!,
        child: Scaffold(
          backgroundColor: StyleConstants.kDarkColor(),
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(bottom: StyleConstants.kDefaultPadding),
            child: FloatingActionButton(
              child: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          appBar: AppBar(
            title: const Text('Гараж'),
          ),
          body: BlocBuilder<GarageBloc, GarageBlocState>(
              builder: (context, state) {
            return ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemCount: state.vehicles.length,
              separatorBuilder: (context, index) {
                return CustomDivider(
                  size: 1.0,
                  thickness: 1.0,
                  color: Colors.grey.withOpacity(0.3),
                );
              },
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Image.asset(state.schedules[index] != null
                      ? 'assets/images/btn_shuttle_yellow.png'
                      : 'assets/images/btn_shuttle_grey.png'),
                  title: Text(
                      '${state.vehicles[index].vehicleName} - ${state.vehicles[index].vehicleID}'),
                  subtitle: Text(
                    state.vehicles[index].vehicleType.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                );
              },
            );
          }),
        ),
      ),
    );
  }
}
