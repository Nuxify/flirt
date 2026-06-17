class RemoteConfigDTO {
  RemoteConfigDTO({
    required this.id,
    required this.minimumRequiredVersion,
    required this.storeUrl,
    required this.currentVersion,
    required this.isVersionLower,
  });

  final String id;
  final String minimumRequiredVersion;
  final String storeUrl;
  final String currentVersion;
  final bool isVersionLower;
}
