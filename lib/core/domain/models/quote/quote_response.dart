import 'package:json_annotation/json_annotation.dart';

part 'quote_response.g.dart';

@JsonSerializable()
class QuoteResponse {
  QuoteResponse({
    required this.author,
    required this.content,
  });

  factory QuoteResponse.fromJson(Map<String, dynamic> json) =>
      _$QuoteResponseFromJson(json);
  Map<String, dynamic> toJson() => _$QuoteResponseToJson(this);

  @JsonKey(name: 'a')
  final String author;
  @JsonKey(name: 'q')
  final String content;
}
