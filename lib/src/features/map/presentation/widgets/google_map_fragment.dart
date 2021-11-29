import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:noko_prototype/src/features/map/domain/bloc/geo_bloc.dart';
import 'package:noko_prototype/src/features/map/domain/bloc/geo_state.dart';

class GoogleMapFragment extends StatefulWidget {
  const GoogleMapFragment({Key? key}) : super(key: key);

  @override
  State<GoogleMapFragment> createState() => _GoogleMapFragmentState();
}

class _GoogleMapFragmentState extends State<GoogleMapFragment> {
  static const double _defaultCameraZoom = 12.0;
  static const double _cameraZoom = 15.0;
  static const CameraPosition _defaultCameraPosition = CameraPosition(
    target: LatLng(53.902783, 27.563395),
    zoom: _defaultCameraZoom,
  );

  final Completer<GoogleMapController> _mapController = Completer();

  Set<Marker> _updateMarkers(GeoBlocState state) {
    final Set<Marker> markersToShow = {};

    if (state.yourPosition != null) {
      markersToShow.add(Marker(
        markerId: MarkerId('${state.yourPosition!.routeNumber}-${state.yourPosition!.vehicleID}'),
        icon: state.icons![MapIconBitmap.you]!,
        position: state.yourPosition!.position,
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

    if (state.anotherPositions != null && state.anotherPositions!.isNotEmpty) {
      for (var position in state.anotherPositions!) {
        markersToShow.add(Marker(
          markerId: MarkerId('${position.routeNumber}-${position.vehicleID}'),
          icon: state.icons![MapIconBitmap.another]!,
          position: position.position,
        ));
      }
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
    return BlocConsumer<GeoBloc, GeoBlocState>(
      listener: (context, state) {
        _updateMapTheme(state);
      },
      listenWhen: (prev, current) {
        return prev.currentMapTheme != current.currentMapTheme;
      },
      builder: (context, state) {
        return GoogleMap(
          mapType: MapType.normal,
          mapToolbarEnabled: false,
          compassEnabled: true,
          scrollGesturesEnabled: true,
          zoomGesturesEnabled: true,
          zoomControlsEnabled: true,
          trafficEnabled: state.utils.isTrafficEnabled ?? false,
          initialCameraPosition: _defaultCameraPosition,
          onMapCreated: (controller) => _onMapCreated(controller, state),
          markers: _updateMarkers(state),
          polylines: (state.utils.isRouteEnabled ?? false)
              ? _updatePolylines(state)
              : {},
        );
      },
    );
  }
}
