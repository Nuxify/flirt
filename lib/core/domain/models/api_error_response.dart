import 'package:json_annotation/json_annotation.dart';

part 'api_error_response.g.dart';

@JsonSerializable(
  genericArgumentFactories: true,
)
@JsonSerializable()
class APIErrorResponse<T> {
  APIErrorResponse({
    required this.message,
    required this.errorCode,
    required this.data,
  });

  factory APIErrorResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$APIErrorResponseFromJson(json, fromJsonT);
  Map<String, dynamic> toJson(Object Function(T value) toJsonT) =>
      _$APIErrorResponseToJson(this, toJsonT);

  static Map<String, dynamic> socketErrorResponse() {
    return <String, dynamic>{
      'error': 'NO_INTERNET_CONNECTION',
      'user_message': 'No Internet Connection',
    };
  }

  final String message;
  final String? errorCode;
  final T data;
}
