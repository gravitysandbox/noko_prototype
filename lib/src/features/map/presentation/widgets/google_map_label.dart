import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:noko_prototype/core/constants.dart';
import 'package:noko_prototype/src/features/map/domain/bloc/geo_bloc.dart';
import 'package:noko_prototype/src/features/map/domain/bloc/geo_state.dart';
import 'package:noko_prototype/src/features/map/domain/models/vehicle_route_destination.dart';

class GoogleMapLabel extends StatefulWidget {
  const GoogleMapLabel({Key? key}) : super(key: key);

  static const double size = 60.0;

  @override
  State<GoogleMapLabel> createState() => _GoogleMapLabelState();
}

class _GoogleMapLabelState extends State<GoogleMapLabel> {
  bool _isInit = false;
  late Timer _timer;
  String? _time;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInit) {
      _timer = Timer.periodic(const Duration(seconds: 1), (_) {
        _updateCurrentTime();
      });
      _isInit = true;
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _updateCurrentTime() {
    setState(() {
      _time = DateFormat('kk:mm').format(DateTime.now()).toString();
    });
  }

  Widget _buildDestinationLabel(VehicleRouteDestination? destination) {
    return Text(
      destination != null ? destination.destinationBusStop.busStopName : '...',
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
        return prev.yourDestination!.routeID != current.yourDestination!.routeID;
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
                        child: _buildDestinationLabel(state.yourDestination),
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
