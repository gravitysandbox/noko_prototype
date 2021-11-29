enum VehicleType {
  autobus,
  none,
  trolleybus,
  minibus,
}

class VehicleData {
  final int vehicleID;
  final int vehicleIDTrBY;
  final String vehicleName;
  final VehicleType vehicleType;
  final String depotName;
  final int regionID;

  const VehicleData({
    required this.vehicleID,
    required this.vehicleIDTrBY,
    required this.vehicleName,
    required this.vehicleType,
    required this.depotName,
    required this.regionID,
  });

  static VehicleData fromJson(Map<String, dynamic> json) {
    return VehicleData(
      vehicleID: json['vehicleId'],
      vehicleIDTrBY: json['idVehicleTrBy'],
      vehicleName: json['vName'],
      vehicleType: VehicleType.values[json['vType']],
      depotName: json['depotName'],
      regionID: json['idRegion'],
    );
  }
}
