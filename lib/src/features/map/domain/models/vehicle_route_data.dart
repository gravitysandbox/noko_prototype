class VehicleRouteData {
  final int routeCardNumber;
  final bool? isForwardDirection;
  final int leftVehicleID;
  final int rightVehicleID;
  final int nextBusStopID;
  final String advanceTime;

  const VehicleRouteData({
    required this.routeCardNumber,
    required this.isForwardDirection,
    required this.leftVehicleID,
    required this.rightVehicleID,
    required this.nextBusStopID,
    required this.advanceTime,
  });

  static VehicleRouteData fromJson(Map<String, dynamic> json) {
    final isForward = json['sht_direction'] == 10
        ? true
        : json['sht_direction'] == 11
            ? false
            : null;

    return VehicleRouteData(
      routeCardNumber: json['shCard'],
      isForwardDirection: isForward,
      leftVehicleID: json['idTSLeft'],
      rightVehicleID: json['idTSRight'],
      nextBusStopID: json['idStopPoint'],
      advanceTime: json['timeTS'],
    );
  }
}