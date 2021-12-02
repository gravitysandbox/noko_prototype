import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:noko_prototype/core/widgets/loading_indicator.dart';
import 'package:noko_prototype/locator.dart';
import 'package:noko_prototype/src/features/map/domain/bloc/geo_bloc.dart';
import 'package:noko_prototype/src/features/map/domain/bloc/geo_state.dart';
import 'package:noko_prototype/src/features/map/domain/models/vehicle_position.dart';
import 'package:noko_prototype/src/features/map/domain/utils/marker_generator.dart';
import 'package:noko_prototype/src/features/map/presentation/widgets/map_marker.dart';

class GoogleMapFragment extends StatefulWidget {
  const GoogleMapFragment({Key? key}) : super(key: key);

  @override
  State<GoogleMapFragment> createState() => _GoogleMapFragmentState();
}

class _GoogleMapFragmentState extends State<GoogleMapFragment> {
  static const double _defaultCameraZoom = 12.0;
  static const double _cameraZoom = 15.0;
  static const Offset _markerAnchor = Offset(0.1215, 0.5);
  static const CameraPosition _defaultCameraPosition = CameraPosition(
    target: LatLng(52.43143829191202, 30.994871299403773),
    zoom: _defaultCameraZoom,
  );

  final Completer<GoogleMapController> _mapController = Completer();
  Set<Marker> _nearestMarkers = {};
  Set<Marker> _anotherMarkers = {};
  bool _isInit = false;

  void _generateMarkerBitmaps(
      List<VehiclePosition> vehicles, bool isDark, bool isNearestMarkers,
      {bool withRebuild = false}) {
    locator<MarkerGenerator>().generate(
      vehicles
          .map((pos) => MapMarker(
                description: pos.routeNumber,
                vector: pos.vector,
                isDark: isDark,
              ))
          .toList(),
      context,
      (bitmaps) {
        if (withRebuild) {
          setState(() {
            isNearestMarkers
                ? _nearestMarkers = _mapBitmapsToMarkers(bitmaps, vehicles)
                : _anotherMarkers = _mapBitmapsToMarkers(bitmaps, vehicles);
          });
        } else {
          isNearestMarkers
              ? _nearestMarkers = _mapBitmapsToMarkers(bitmaps, vehicles)
              : _anotherMarkers = _mapBitmapsToMarkers(bitmaps, vehicles);
        }
      },
    );
  }

  Set<Marker> _mapBitmapsToMarkers(
      List<Uint8List> bitmaps, List<VehiclePosition> vehicles) {
    final Set<Marker> markersToShow = {};

    bitmaps.asMap().forEach((i, bmp) {
      markersToShow.add(Marker(
        markerId:
            MarkerId('${vehicles[i].routeNumber}-${vehicles[i].vehicleID}'),
        anchor: _markerAnchor,
        position: vehicles[i].position,
        icon: BitmapDescriptor.fromBytes(bmp),
      ));
    });

    return markersToShow;
  }

  Set<Marker> _updateMarkers(GeoBlocState state) {
    final Set<Marker> markersToShow = {};

    if (state.yourPosition != null) {
      markersToShow.add(Marker(
        markerId: MarkerId(
            '${state.yourPosition!.routeNumber}-${state.yourPosition!.vehicleID}'),
        icon: state.icons![MapIconBitmap.you]!,
        position: state.yourPosition!.position,
        zIndex: 10,
      ));

      for (var stop in state.yourDestination!.busStops) {
        markersToShow.add(Marker(
          markerId: MarkerId(stop.busStopName),
          icon: state.icons![MapIconBitmap.busStop]!,
          position: stop.busStopPosition,
        ));
      }

      if (state.utils.isTrackingEnabled!) {
        Future.delayed(const Duration(milliseconds: 500)).then((_) {
          _moveCamera(state.yourPosition!.position);
        });
      }
    }

    if (state.nearestPositions != null && state.nearestPositions!.isNotEmpty) {
      Future.delayed(Duration.zero).then((_) => _generateMarkerBitmaps(
          state.nearestPositions!,
          state.currentMapTheme == MapThemeStyle.dark,
          true));
    }

    if (state.anotherPositions != null && state.anotherPositions!.isNotEmpty) {
      Future.delayed(Duration.zero).then((_) => _generateMarkerBitmaps(
          state.anotherPositions!,
          state.currentMapTheme == MapThemeStyle.dark,
          false));
    }

    return markersToShow;
  }

  Set<Polyline> _updatePolylines(GeoBlocState state) {
    final Set<Polyline> polylinesToShow = {};

    polylinesToShow.add(Polyline(
      polylineId: const PolylineId('You route'),
      width: 6,
      points: state.yourRoute,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
      color: state.currentMapTheme == MapThemeStyle.light
          ? Colors.blue
          : Colors.deepOrange,
    ));

    return polylinesToShow;
  }

  void _onMapCreated(
    GoogleMapController mapController,
    GeoBlocState state,
  ) {
    _mapController.complete(mapController);
    _updateMapTheme(state);

    if (!_isInit) {
      _generateMarkerBitmaps(
        state.nearestPositions!,
        state.currentMapTheme == MapThemeStyle.dark,
        true,
        withRebuild: true,
      );

      setState(() {
        _isInit = true;
      });
    }
  }

  void _updateMapTheme(GeoBlocState state) {
    if (state.mapThemes == null) return;
    _mapController.future.then((controller) {
      controller.setMapStyle(state.currentMapTheme == MapThemeStyle.dark
          ? state.mapThemes![MapThemeStyle.dark]
          : state.mapThemes![MapThemeStyle.light]);
    });
  }

  void _moveCamera(LatLng coordinates) {
    _mapController.future.then((controller) =>
        controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target: coordinates,
          zoom: _cameraZoom,
        ))));
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return BlocConsumer<GeoBloc, GeoBlocState>(
      listener: (context, state) {
        _updateMapTheme(state);
      },
      listenWhen: (prev, current) {
        return prev.currentMapTheme != current.currentMapTheme;
      },
      builder: (context, state) {
        return Stack(
          children: <Widget>[
            GoogleMap(
              mapType: MapType.normal,
              mapToolbarEnabled: false,
              compassEnabled: true,
              scrollGesturesEnabled: true,
              zoomGesturesEnabled: true,
              zoomControlsEnabled: true,
              trafficEnabled: state.utils.isTrafficEnabled ?? false,
              initialCameraPosition: _defaultCameraPosition,
              onMapCreated: (controller) => _onMapCreated(controller, state),
              markers: {
                ..._nearestMarkers,
                ..._anotherMarkers,
                ..._updateMarkers(state)
              },
              polylines: (state.utils.isRouteEnabled ?? false)
                  ? _updatePolylines(state)
                  : {},
            ),
            if (!_isInit)
              Positioned(
                left: (mq.size.width * 0.5) - (LoadingIndicator.size * 0.5),
                bottom: (mq.size.height * 0.5) - (LoadingIndicator.size * 0.5),
                child: const LoadingIndicator(),
              ),
          ],
        );
      },
    );
  }
}
