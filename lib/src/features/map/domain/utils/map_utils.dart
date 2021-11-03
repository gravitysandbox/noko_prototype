import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:noko_prototype/core/utils/logger.dart';

class MapUtils {
  final PolylinePoints routeService = PolylinePoints();

  Future<BitmapDescriptor> loadMarkerImageFromAsset(
    BuildContext context,
    String assetSrc,
  ) async {
    logPrint('***** MapUtils loadMarkerImageFromAsset()');

    final imageConfiguration = createLocalImageConfiguration(
      context,
      size: const Size.square(15.0),
    );

    return await BitmapDescriptor.fromAssetImage(
      imageConfiguration,
      assetSrc,
    );
  }

  Future<List<LatLng>> loadRouteCoordinates(
      LatLng origin, LatLng destination) async {
    logPrint('***** MapUtils loadRouteCoordinates()');

    List<LatLng> polylineCoordinates = [];
    PolylineResult result = await routeService.getRouteBetweenCoordinates(
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
}
