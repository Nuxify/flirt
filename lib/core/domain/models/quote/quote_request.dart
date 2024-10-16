import 'package:json_annotation/json_annotation.dart';

part 'quote_request.g.dart';

@JsonSerializable()
class QuoteRequest {
  QuoteRequest({
    required this.id,
    required this.data,
  });

  factory QuoteRequest.fromJson(Map<String, dynamic> json) =>
      _$QuoteRequestFromJson(json);
  Map<String, dynamic> toJson() => _$QuoteRequestToJson(this);

  final String id;
  final String data;
}
