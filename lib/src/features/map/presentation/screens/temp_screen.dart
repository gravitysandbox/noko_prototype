import 'dart:math' as math;
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:noko_prototype/locator.dart';
import 'package:noko_prototype/src/features/map/domain/utils/marker_generator.dart';

class TempScreen extends StatefulWidget {
  static const routeName = '/temp';

  const TempScreen({Key? key}) : super(key: key);

  @override
  _TempScreenState createState() => _TempScreenState();
}

class _TempScreenState extends State<TempScreen> {
  List<Marker> markers = [];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        GoogleMap(
          initialCameraPosition: const CameraPosition(
            target: LatLng(45.811328, 15.975862),
            zoom: 10.0,
          ),
          markers: markers.toSet(),
        ),
      ],
    );
  }

  @override
  void didChangeDependencies() {
    locator<MarkerGenerator>().generate(
      markerWidgets(),
      context,
      (bitmaps) {
        setState(() {
          markers = mapBitmapsToMarkers(bitmaps);
        });
      },
    );
    super.didChangeDependencies();
  }

  List<Marker> mapBitmapsToMarkers(List<Uint8List> bitmaps) {
    List<Marker> markersList = [];
    bitmaps.asMap().forEach((i, bmp) {
      final city = cities[i];
      markersList.add(Marker(
        markerId: MarkerId(city.name),
        anchor: const Offset(0.1215, 0.5),
        position: city.position,
        icon: BitmapDescriptor.fromBytes(bmp),
      ));
      markersList.add(Marker(
        markerId: MarkerId('${city.name}_temp'),
        position: city.position,
        icon: BitmapDescriptor.defaultMarker,
      ));
    });
    return markersList;
  }

  Widget _getMarkerWidget(String name) {
    var degrees = math.Random().nextInt(360);
    var angle = (degrees + 180.0) * math.pi / 180.0;
    var description = 'A17 +01:04 / 2751 AI-3';

    var markerHeight = 60.0;
    var markerWidth = 60.0 + 160.0 + 16.0 + 11.0;

    return SizedBox(
      height: markerHeight,
      width: markerWidth,
      child: Stack(
        alignment: AlignmentDirectional.centerStart,
        children: <Widget>[
          Positioned(
            left: 11.0,
            child: Container(
              height: 38.0,
              padding:
                  const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(19.0),
                  bottomLeft: Radius.circular(19.0),
                  topRight: Radius.circular(5.0),
                  bottomRight: Radius.circular(5.0),
                ),
                color: Colors.white,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const SizedBox(
                    width: 38.0,
                  ),
                  Text(
                    description,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                  ),
                ],
              ),
            ),
          ),
          Transform.rotate(
            angle: angle,
            child: CustomPaint(
              size: const Size(60.0, 60.0),
              painter: TransportIconPainter(),
            ),
          ),
          SizedBox(
            height: 60.0,
            width: 60.0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(4.0),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(19.0)),
                  color: Colors.green,
                ),
                child: Image.asset(
                  'assets/icons/ic_shuttle_route_white.png',
                  height: 30.0,
                  width: 30.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> markerWidgets() {
    return cities.map((c) => _getMarkerWidget(c.name)).toList();
  }
}

List<City> cities = const [
  City("Zagreb", LatLng(45.792565, 15.995832)),
  City("Ljubljana", LatLng(46.037839, 14.513336)),
  City("Novo Mesto", LatLng(45.806132, 15.160768)),
  City("Varaždin", LatLng(46.302111, 16.338036)),
  City("Maribor", LatLng(46.546417, 15.642292)),
  City("Rijeka", LatLng(45.324289, 14.444480)),
  City("Karlovac", LatLng(45.489728, 15.551561)),
  City("Klagenfurt", LatLng(46.624124, 14.307974)),
  City("Graz", LatLng(47.060426, 15.442028)),
  City("Celje", LatLng(46.236738, 15.270346))
];

class City {
  final String name;
  final LatLng position;

  const City(this.name, this.position);
}

class TransportIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.fill
      ..strokeWidth = 0;

    double width = size.width;
    double height = size.height;

    Path path = Path();
    path.moveTo(15.0, height * 0.7);
    path.lineTo((width * 0.5) - 3.0, height - 3.0);
    path.lineTo((width * 0.5) + 3.0, height - 3.0);
    path.lineTo(width - 15.0, height * 0.7);
    path.moveTo(15.0, height * 0.7);

    canvas.drawPath(path, paint);
    canvas.drawCircle(Offset(width * 0.5, height - 4.0), 3.0, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
