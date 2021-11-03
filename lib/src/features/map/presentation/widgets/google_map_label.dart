import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:noko_prototype/core/constants.dart';
import 'package:noko_prototype/src/features/map/domain/bloc/geo_bloc.dart';
import 'package:noko_prototype/src/features/map/domain/bloc/geo_state.dart';
import 'package:noko_prototype/src/features/map/domain/models/route_destination_model.dart';

class GoogleMapLabel extends StatefulWidget {
  const GoogleMapLabel({Key? key}) : super(key: key);

  static const double size = 60.0;

  @override
  State<GoogleMapLabel> createState() => _GoogleMapLabelState();
}

class _GoogleMapLabelState extends State<GoogleMapLabel> {
  bool _isInit = false;
  String? _time;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInit) {
      Timer.periodic(const Duration(seconds: 1), (_) {
        _updateCurrentTime();
      });
      _isInit = true;
    }
  }

  void _updateCurrentTime() {
    setState(() {
      _time = DateFormat('kk:mm').format(DateTime.now()).toString();
    });
  }

  Widget _buildDestinationLabel(RouteDestinationModel? destination) {
    return Text(
      destination != null ? destination.busStopPositions.keys.first : '...',
      style: const TextStyle(
        fontSize: 16.0,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GeoBloc, GeoBlocState>(
      buildWhen: (prev, current) {
        return prev.currentDestination != current.currentDestination;
      },
      builder: (context, state) {
        return SizedBox(
          height: GoogleMapLabel.size,
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: StyleConstants.kDefaultPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Image.asset(
                  'assets/icons/ic_my_transport.png',
                  height: GoogleMapLabel.size * 0.5,
                  width: GoogleMapLabel.size * 0.5,
                ),
                const SizedBox(
                  width: StyleConstants.kDefaultPadding * 0.5,
                ),
                Expanded(
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: StyleConstants.kDefaultPadding * 0.5),
                        child: Text(
                          _time ?? '--:--',
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        child: _buildDestinationLabel(state.currentDestination),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: StyleConstants.kDefaultPadding * 0.5,
                ),
                const Text('M18/14'),
              ],
            ),
          ),
        );
      },
    );
  }
}
