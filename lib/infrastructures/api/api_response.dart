import 'package:json_annotation/json_annotation.dart';

part 'api_response.g.dart';

@JsonSerializable(
  genericArgumentFactories: true,
)
class APIResponse<T> {
  APIResponse({
    required this.success,
    required this.message,
    required this.errorCode,
    required this.data,
  });

  factory APIResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
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
  final String? errorCode;
  final T data;
}

@JsonSerializable(
  genericArgumentFactories: true,
)
class APIListResponse<T> {
  APIListResponse({
    required this.success,
    required this.message,
    required this.errorCode,
    required this.data,
  });

  factory APIListResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$APIListResponseFromJson(json, fromJsonT);
  Map<String, dynamic> toJson(Object Function(T value) toJsonT) =>
      _$APIListResponseToJson(this, toJsonT);

  /// base API response
  final bool success;
  final String message;
  final String? errorCode;
  final List<T> data;
}
