class AppServerVersionResponse {
  final String version;
  AppServerVersionResponse(this.version);
  AppServerVersionResponse.fromMap(Map<String, dynamic> map)
      : version = map['version'];
}
