class RegionData {
  final int regionID;
  final int regionName;

  const RegionData({
    required this.regionID,
    required this.regionName,
  });

  static RegionData fromJson(Map<String, dynamic> json) {
    return RegionData(
      regionID: json['idRegion'],
      regionName: json['regionName'],
    );
  }
}
