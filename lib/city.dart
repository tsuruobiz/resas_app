class City {
  final int prefCode;
  final String cityCode;
  final String cityName;
  final String bigCityFlag;

  // Suggested code may be subject to a license. Learn more: ~LicenseLog:1753241084.
  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      prefCode: json['prefCode'] as int,
      cityCode: json['cityCode'] as String,
      cityName: json['cityName'] as String,
      bigCityFlag: json['bigCityFlag'] as String,
    );
  }

  City({
    required this.prefCode,
    required this.cityCode,
    required this.cityName,
    required this.bigCityFlag,
  });
}
