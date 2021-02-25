import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'record_request.g.dart';

@JsonSerializable()
class RecordRequest {
  RecordRequest({
    @required this.id,
    @required this.data,
  });

  factory RecordRequest.fromJson(Map<String, dynamic> json) =>
      _$RecordRequestFromJson(json);
  Map<String, dynamic> toJson() => _$RecordRequestToJson(this);

  @JsonKey(required: true)
  final String id;
  @JsonKey(required: true)
  final String data;
}
