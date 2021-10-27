import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noko_prototype/locator.dart';
import 'package:noko_prototype/src/features/map/domain/bloc/geolocation_bloc.dart';
import 'package:noko_prototype/src/features/map/domain/models/geolocation_state.dart';
import 'package:noko_prototype/src/features/map/domain/usecases/update_map_utils.dart';

class MapUtilsPanel extends StatelessWidget {
  const MapUtilsPanel({Key? key}) : super(key: key);

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

        return Column(
          children: <Widget>[
            FloatingActionButton(
              heroTag: 'Enable tracking',
              backgroundColor: isTrackingEnabled ? Colors.green : Colors.grey,
              onPressed: () => _enableTrackingModeHandler(isTrackingEnabled),
              child: const Icon(Icons.center_focus_strong_outlined),
            ),
            const SizedBox(
              height: 10.0,
            ),
            FloatingActionButton(
              heroTag: 'Enable route',
              backgroundColor: isRouteEnabled ? Colors.green : Colors.grey,
              onPressed: () => _enableRouteModeHandler(isRouteEnabled),
              child: const Icon(Icons.alt_route),
            ),
            const SizedBox(
              height: 10.0,
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
