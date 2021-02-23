import 'package:json_annotation/json_annotation.dart';

part 'api_response.g.dart';

@JsonSerializable(
  genericArgumentFactories: true,
)
class APIResponse<T> {
  APIResponse({this.success, this.message, this.errorCode, this.data});

  factory APIResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object json) fromJsonT,
  ) =>
      _$APIResponseFromJson(json, fromJsonT);
  Map<String, dynamic> toJson(Object Function(T value) toJsonT) =>
      _$APIResponseToJson(this, toJsonT);

  static Map<String, dynamic> socketErrorResponse() {
    return <String, dynamic>{
      'success': false,
      'message': 'No Internet Connection',
      'errorCode': 'NO_INTERNET_CONNECTION',
    };
  }

  /// base API response
  final bool success;
  final String message;
  @JsonKey(nullable: true)
  final String errorCode;
  @JsonKey(nullable: true)
  final T data;
}

@JsonSerializable(
  genericArgumentFactories: true,
)
class APIListResponse<T> {
  APIListResponse({this.success, this.message, this.errorCode, this.data});

  factory APIListResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object json) fromJsonT,
  ) =>
      _$APIListResponseFromJson(json, fromJsonT);
  Map<String, dynamic> toJson(Object Function(T value) toJsonT) =>
      _$APIListResponseToJson(this, toJsonT);

  /// base API response
  final bool success;
  final String message;
  @JsonKey(nullable: true)
  final String errorCode;
  @JsonKey(nullable: true)
  final List<T> data;
}
