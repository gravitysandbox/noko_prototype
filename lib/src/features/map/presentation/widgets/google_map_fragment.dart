import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:noko_prototype/locator.dart';
import 'package:noko_prototype/src/features/map/domain/bloc/geolocation_bloc.dart';
import 'package:noko_prototype/src/features/map/domain/models/geolocation_state.dart';
import 'package:noko_prototype/src/features/map/domain/utils/map_utils.dart';

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

  Set<Marker> _updateMarkers(GeolocationState state) {
    final Set<Marker> markersToShow = {};

    if (state.busStopPositions.isNotEmpty) {
      state.busStopPositions.forEach((name, geo) {
        markersToShow.add(Marker(
          markerId: MarkerId(name.toString()),
          icon: state.busStopIcon ??
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          position: geo,
        ));
      });
    }

    if (state.currentPosition != null) {
      markersToShow.add(Marker(
        markerId: MarkerId(state.currentPosition.toString()),
        icon: state.myPositionIcon ??
            BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        position: state.currentPosition!,
      ));

      if (state.utils.isTrackingEnabled!) {
        Future.delayed(const Duration(milliseconds: 500)).then((_) {
          _animateCamera(state.currentPosition!);
        });
      }
    }

    return markersToShow;
  }

  Set<Polyline> _updatePolylines(GeolocationState state) {
    if (state.routePolylines != null && state.routePolylines!.isNotEmpty) {
      return locator<MapUtils>().getPolylinesWithCurrentPosition(
        state.routePolylines!,
        state.currentPosition!,
      );
    }

    return {};
  }

  void _onMapCreated(GoogleMapController mapController) {
    _mapController.complete(mapController);
  }

  void _animateCamera(LatLng coordinates) {
    _mapController.future.then((controller) =>
        controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target: coordinates,
          zoom: _cameraZoom,
        ))));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GeolocationBloc, GeolocationState>(
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
          onMapCreated: _onMapCreated,
          markers: _updateMarkers(state),
          polylines: (state.utils.isRouteEnabled ?? false)
              ? _updatePolylines(state)
              : {},
        );
      },
    );
  }
}
