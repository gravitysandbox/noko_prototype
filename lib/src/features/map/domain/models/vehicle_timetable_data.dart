class VehicleTimetableData {
  final bool? isForwardDirection;
  final bool? isNextTripAvailable;
  final bool? isChangeDirectionAvailable;
  final List<TimetableData> timetable;

  const VehicleTimetableData({
    required this.isForwardDirection,
    required this.isNextTripAvailable,
    required this.isChangeDirectionAvailable,
    required this.timetable,
  });

  static VehicleTimetableData fromJson(Map<String, dynamic> json) {
    final isForward = json['sht_direction'] == 10
        ? true
        : json['sht_direction'] == 11
            ? false
            : null;

    return VehicleTimetableData(
      isForwardDirection: isForward,
      isNextTripAvailable: json['showNextTripButton'],
      isChangeDirectionAvailable: json['showChangeDirectionButton'],
      timetable: (json['raspCard'] as List<dynamic>)
          .map((timetable) => TimetableData.fromJson(timetable))
          .toList(),
    );
  }
}

class TimetableData {
  final int routeID;
  final int busStopID;
  final DateTime arrivalTime;
  final bool isControlPoint;

  const TimetableData({
    required this.routeID,
    required this.busStopID,
    required this.arrivalTime,
    required this.isControlPoint,
  });

  static TimetableData fromJson(Map<String, dynamic> json) {
    return TimetableData(
      routeID: json['idMarshrutWO'],
      busStopID: json['idStopPoint'],
      arrivalTime: DateTime.parse(json['planTime']),
      isControlPoint: json['shts_checkpoint'],
    );
  }
}
