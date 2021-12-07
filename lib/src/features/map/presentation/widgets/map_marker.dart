import 'dart:math' as math;

import 'package:flutter/material.dart';

class MapMarker extends StatelessWidget {
  final String description;
  final int vector;
  final bool isDark;
  final bool isAnother;

  const MapMarker({
    Key? key,
    required this.description,
    required this.vector,
    this.isDark = false,
    this.isAnother = false,
  }) : super(key: key);

  static const markerHeight = 60.0;
  static const descriptionHeight = 38.0;
  static const descriptionWidth = 160.0;

  @override
  Widget build(BuildContext context) {
    var angle = (vector + 180.0) * math.pi / 180.0;
    var markerWidth = markerHeight + descriptionWidth + 16.0 + 16.0;

    return SizedBox(
      height: markerHeight,
      width: markerWidth,
      child: Stack(
        alignment: AlignmentDirectional.centerStart,
        children: <Widget>[
          Positioned(
            left: 16.0,
            child: Container(
              height: descriptionHeight,
              padding:
                  const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(descriptionHeight * 0.5),
                  bottomLeft: Radius.circular(descriptionHeight * 0.5),
                  topRight: Radius.circular(5.0),
                  bottomRight: Radius.circular(5.0),
                ),
                color: isDark ? Colors.blueGrey.shade800 : Colors.white,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const SizedBox(
                    width: descriptionHeight,
                  ),
                  Text(
                    description,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.white : Colors.black,
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
              size: const Size(markerHeight, markerHeight),
              painter: TransportIconPainter(
                isAnother: isAnother,
              ),
            ),
          ),
          SizedBox(
            height: markerHeight,
            width: markerHeight,
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                      Radius.circular(descriptionHeight * 0.5)),
                  color: isAnother ? Colors.red : Colors.green,
                ),
                child: Image.asset(
                  'assets/icons/ic_shuttle_route_white.png',
                  height: markerHeight * 0.5,
                  width: markerHeight * 0.5,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TransportIconPainter extends CustomPainter {
  final bool isAnother;

  TransportIconPainter({required this.isAnother});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = isAnother ? Colors.red : Colors.green
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
