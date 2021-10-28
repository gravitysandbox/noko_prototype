import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noko_prototype/locator.dart';
import 'package:noko_prototype/src/constants.dart';
import 'package:noko_prototype/src/features/map/domain/bloc/geolocation_bloc.dart';
import 'package:noko_prototype/src/features/map/domain/models/geolocation_state.dart';
import 'package:noko_prototype/src/features/map/domain/usecases/update_map_utils.dart';

class MapUtilsPanel extends StatelessWidget {
  const MapUtilsPanel({Key? key}) : super(key: key);

  void _reverseRouteModeHandler(bool isRouteReversed) {
    locator<UpdateMapUtils>()
        .call(MapUtilsState(isRouteReversed: !isRouteReversed));
  }

  void _enableTrackingModeHandler(bool isTrackingEnabled) {
    locator<UpdateMapUtils>()
        .call(MapUtilsState(isTrackingEnabled: !isTrackingEnabled));
  }

  void _enableRouteModeHandler(bool isRouteEnabled) {
    locator<UpdateMapUtils>()
        .call(MapUtilsState(isRouteEnabled: !isRouteEnabled));
  }

  void _enableTrafficModeHandler(bool isTrafficEnabled) {
    locator<UpdateMapUtils>()
        .call(MapUtilsState(isTrafficEnabled: !isTrafficEnabled));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GeolocationBloc, GeolocationState>(
      builder: (context, state) {
        final isTrackingEnabled = state.utils.isTrackingEnabled!;
        final isRouteEnabled = state.utils.isRouteEnabled!;
        final isTrafficEnabled = state.utils.isTrafficEnabled!;
        final isRouteReversed = state.utils.isRouteReversed!;

        return Column(
          children: <Widget>[
            FloatingActionButton(
              heroTag: 'Reverse route',
              backgroundColor: isRouteReversed ? Colors.green : Colors.grey,
              onPressed: () => _reverseRouteModeHandler(isRouteReversed),
              child: const Icon(Icons.repeat),
            ),
            const SizedBox(
              height: kDefaultPadding / 2.0,
            ),
            FloatingActionButton(
              heroTag: 'Enable tracking',
              backgroundColor: isTrackingEnabled ? Colors.green : Colors.grey,
              onPressed: () => _enableTrackingModeHandler(isTrackingEnabled),
              child: const Icon(Icons.center_focus_strong_outlined),
            ),
            const SizedBox(
              height: kDefaultPadding / 2.0,
            ),
            FloatingActionButton(
              heroTag: 'Enable route',
              backgroundColor: isRouteEnabled ? Colors.green : Colors.grey,
              onPressed: () => _enableRouteModeHandler(isRouteEnabled),
              child: const Icon(Icons.alt_route),
            ),
            const SizedBox(
              height: kDefaultPadding / 2.0,
            ),
            FloatingActionButton(
              heroTag: 'Enable traffic',
              backgroundColor: isTrafficEnabled ? Colors.green : Colors.grey,
              onPressed: () => _enableTrafficModeHandler(isTrafficEnabled),
              child: const Icon(Icons.traffic),
            ),
          ],
        );
      },
    );
  }
}
