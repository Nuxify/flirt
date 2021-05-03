import 'package:json_annotation/json_annotation.dart';

part 'record_response.g.dart';

@JsonSerializable()
class RecordResponse {
  RecordResponse({
    required this.id,
    required this.data,
    required this.createdAt,
  });

  factory RecordResponse.fromJson(Map<String, dynamic> json) =>
      _$RecordResponseFromJson(json);
  Map<String, dynamic> toJson() => _$RecordResponseToJson(this);

  final String? id;
  final String? data;
  final int? createdAt;
}
