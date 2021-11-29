import 'package:noko_prototype/src/features/map/domain/models/vehicle_data.dart';

class VehicleShortScheduleData {
  final int routeCardNumber;
  final String routeNumber;

  const VehicleShortScheduleData({
    required this.routeCardNumber,
    required this.routeNumber,
  });

  static VehicleShortScheduleData fromJson(Map<String, dynamic> json) {
    return VehicleShortScheduleData(
      routeCardNumber: json['shCard'],
      routeNumber: json['mNumber'],
    );
  }
}

class VehicleFullScheduleData {
  final int routeCardNumber;
  final String routeNumber;
  final VehicleType vehicleType;
  final String initBusStopName;
  final String finalBusStopName;
  final DateTime initTimeFirst;
  final DateTime finalTimeFirst;
  final DateTime initTime;
  final DateTime finalTime;
  final DateTime lunchInitTime;
  final DateTime lunchFinalTime;

  const VehicleFullScheduleData({
    required this.routeCardNumber,
    required this.routeNumber,
    required this.vehicleType,
    required this.initBusStopName,
    required this.finalBusStopName,
    required this.initTimeFirst,
    required this.finalTimeFirst,
    required this.initTime,
    required this.finalTime,
    required this.lunchInitTime,
    required this.lunchFinalTime,
  });

  static VehicleFullScheduleData fromJson(Map<String, dynamic> json) {
    return VehicleFullScheduleData(
      routeCardNumber: json['shCard'],
      routeNumber: json['mNumber'],
      vehicleType: VehicleType.values[json['mMUType']],
      initBusStopName: json['opNameSt'],
      finalBusStopName: json['opNameEnd'],
      initTimeFirst: DateTime.parse(json['timeOpSt']),
      finalTimeFirst: DateTime.parse(json['timeOpEnd']),
      initTime: DateTime.parse(json['timeWorkSt']),
      finalTime: DateTime.parse(json['timeWorkEnd']),
      lunchInitTime: DateTime.parse(json['timeLunchSt']),
      lunchFinalTime: DateTime.parse(json['timeLunchEnd']),
    );
  }
}
