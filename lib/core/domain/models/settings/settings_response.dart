import 'package:json_annotation/json_annotation.dart';

part 'settings_response.g.dart';

@JsonSerializable()
class RemoteConfigResponse {
  RemoteConfigResponse({
    required this.id,
    required this.minimumRequiredVersion,
    required this.appUrl,
  });

  factory RemoteConfigResponse.fromJson(Map<String, dynamic> json) =>
      _$RemoteConfigResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteConfigResponseToJson(this);

  final String id;
  final String minimumRequiredVersion;
  final String appUrl;
}
