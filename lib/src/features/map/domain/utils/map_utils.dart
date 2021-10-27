import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:noko_prototype/core/utils/logger.dart';

class MapUtils {
  Future<BitmapDescriptor> loadMarkerImageFromAsset(
    BuildContext context,
    String assetSrc,
  ) async {
    logPrint('***** MapUtils loadMarkerImageFromAsset()');

    final imageConfiguration = createLocalImageConfiguration(
      context,
      size: const Size.square(20.0),
    );

    return await BitmapDescriptor.fromAssetImage(
      imageConfiguration,
      assetSrc,
    );
  }

  Future<List<LatLng>> loadPolylineCoordinates(
      LatLng origin, LatLng destination) async {
    logPrint('***** MapUtils loadPolylineCoordinates()');

    List<LatLng> polylineCoordinates = [];
    PolylineResult result = await PolylinePoints().getRouteBetweenCoordinates(
      'AIzaSyARXT_cl5yR-B43lLm9ih5pSb9GtDm62S8',
      PointLatLng(origin.latitude, origin.longitude),
      PointLatLng(destination.latitude, destination.longitude),
    );

    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    } else {
      logPrint('***** MapUtils loadPolylineCoordinates()');
    }

    return polylineCoordinates;
  }

  Set<Polyline> getPolylinesWithCurrentPosition(List<LatLng> polylines, LatLng position) {
    final Set<Polyline> polylinesToShow = {};
    final coordinates = [...polylines];
    final currentPositionIndexToInsert = _mathCurrentPositionIndex(
      polylines,
      position,
    );

    coordinates.insert(currentPositionIndexToInsert, position);

    polylinesToShow.add(Polyline(
      polylineId: const PolylineId('Previous route'),
      width: 8,
      points:
      coordinates.getRange(0, currentPositionIndexToInsert + 1).toList(),
      startCap: Cap.roundCap,
      color: Colors.grey,
      zIndex: 2,
    ));

    polylinesToShow.add(Polyline(
      polylineId: const PolylineId('Future route'),
      width: 8,
      points: coordinates
          .getRange(currentPositionIndexToInsert, coordinates.length)
          .toList(),
      endCap: Cap.roundCap,
      color: Colors.blue,
      zIndex: 1,
    ));

    return polylinesToShow;
  }

  int _mathCurrentPositionIndex(List<LatLng> coordinates, LatLng position) {
    logPrint('***** MapUtils loadPolylineCoordinates()');
    int prevIndex = 0, nextIndex = 1;

    final x0 = position.longitude;
    final y0 = position.latitude;

    var prevX = coordinates[prevIndex].longitude;
    var prevY = coordinates[prevIndex].latitude;
    var nextX = coordinates[nextIndex].longitude;
    var nextY = coordinates[nextIndex].latitude;

    var prevDelta = sqrt(pow((prevX - x0), 2) + pow((prevY - y0), 2));
    var nextDelta = sqrt(pow((nextX - x0), 2) + pow((nextY - y0), 2));

    double nDelta = prevDelta + nextDelta;

    for (var i = nextIndex; i < coordinates.length - 1; i++) {
      var x1 = coordinates[i].longitude;
      var y1 = coordinates[i].latitude;
      var x2 = coordinates[i + 1].longitude;
      var y2 = coordinates[i + 1].latitude;

      var delta1 = sqrt(pow((x1 - x0), 2) + pow((y1 - y0), 2));
      var delta2 = sqrt(pow((x2 - x0), 2) + pow((y2 - y0), 2));

      if (nDelta >= delta1 + delta2) {
        nDelta = delta1 + delta2;
        prevIndex = i;
        nextIndex = i + 1;
      }
    }

    return nextIndex;
  }
}
