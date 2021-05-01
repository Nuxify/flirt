import 'package:json_annotation/json_annotation.dart';

part 'record_request.g.dart';

@JsonSerializable()
class RecordRequest {
  RecordRequest({
    required this.id,
    required this.data,
  });

  factory RecordRequest.fromJson(Map<String, dynamic> json) =>
      _$RecordRequestFromJson(json);
  Map<String, dynamic> toJson() => _$RecordRequestToJson(this);

  final String id;
  final String data;
}
