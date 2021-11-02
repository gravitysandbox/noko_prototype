import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:noko_prototype/core/utils/logger.dart';
import 'package:noko_prototype/src/features/map/domain/bloc/geolocation_state.dart';
import 'package:noko_prototype/src/features/map/domain/models/route_destination_model.dart';
import 'package:noko_prototype/src/features/map/domain/usecases/update_position.dart';

class ShadowGeolocationUpdater {
  final UpdatePosition updatePositionUsecase;

  ShadowGeolocationUpdater({
    required this.updatePositionUsecase,
  });

  bool _isInit = false;
  int _currentIndex = 0;

  static const _yourLocations = <LatLng>[
    LatLng(53.854847, 27.571195),
    LatLng(53.854965, 27.571867),
    LatLng(53.855313, 27.572408),
    LatLng(53.855731, 27.572537),
    LatLng(53.856244, 27.572666),
    LatLng(53.856731, 27.572773),
    LatLng(53.858446, 27.572688),
    LatLng(53.859186, 27.572538),
    LatLng(53.859857, 27.572369),
    LatLng(53.860407, 27.572235),
    LatLng(53.860726, 27.572143),
    LatLng(53.861251, 27.572043),
    LatLng(53.862036, 27.571882),
    LatLng(53.862662, 27.571721),
    LatLng(53.863390, 27.571560),
    LatLng(53.864023, 27.571399),
    LatLng(53.864523, 27.571292),
    LatLng(53.865067, 27.571163),
    LatLng(53.865700, 27.571034),
    LatLng(53.866390, 27.570884),
    LatLng(53.867086, 27.570691),
    LatLng(53.867772, 27.570552),
    LatLng(53.868417, 27.570437),
    LatLng(53.869252, 27.570324),
    LatLng(53.869986, 27.570281),
    LatLng(53.870783, 27.570292),
    LatLng(53.871523, 27.570410),
    LatLng(53.872390, 27.570389),
    LatLng(53.873212, 27.570046),
    LatLng(53.874098, 27.569520),
    LatLng(53.874800, 27.569112),
    LatLng(53.875325, 27.568887),
  ];

  static const _busStopLocations = <String, LatLng>{
    'Červieński Market': LatLng(53.855736, 27.572638),
    'Kamvoĺny Combinat': LatLng(53.860428, 27.572401),
    'Soniečnaja': LatLng(53.864539, 27.571396),
    'Siamionava': LatLng(53.869278, 27.570421),
    'Dzianisaŭskaja': LatLng(53.875350, 27.568994),
  };

  static const _routesLocations = <RouteDestinationModel>{
    RouteDestinationModel(
      routeName: 'First route',
      startPosition: LatLng(53.855736, 27.572638),
      destinationPosition: LatLng(53.875350, 27.568994),
    ),
  };

  void startTracking() {
    if (_isInit) return;

    logPrint('***** ShadowGeolocationUpdater startTracking()');
    _isInit = true;

    Timer.periodic(
      const Duration(seconds: 5),
      (_) {
        _currentIndex =
            _currentIndex + 1 < _yourLocations.length ? _currentIndex + 1 : 0;

        updatePositionUsecase(_yourLocations[_currentIndex]);
      },
    );
  }

  GeolocationBlocState initialGeoPosition() {
    return GeolocationBlocState(
      currentPosition: _yourLocations[0],
      busStopPositions: _busStopLocations,
      routesPositions: _routesLocations,
    );
  }
}
