import 'dart:async';
import 'dart:io';

import 'package:flirt/internal/api.dart';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';

part 'api_error_response.g.dart';

/// Safely maps any caught [error] to an [APIErrorResponse].
///
/// Cubits historically relied on `on APIErrorResponse catch` clauses to split
/// API failures from unexpected errors. In AOT release builds a non-matching
/// typed catch can surface as a "not a subtype ... in type cast" TypeError
/// instead of falling through to the generic handler, which is the root cause
/// of several production crashes (e.g. a raw ClientException reaching the
/// catch site). Catching generically and mapping here removes the typed-catch
/// cast entirely while preserving sensible error messages.
APIErrorResponse translateError(Object error) {
  if (error is APIErrorResponse) {
    return error;
  }
  if (error is SocketException || error is http.ClientException) {
    return APIErrorResponse.socketErrorResponse();
  }
  if (error is TimeoutException) {
    return APIErrorResponse.timeoutErrorResponse();
  }
  return APIErrorResponse.typeCastingErrorResponse();
}

@JsonSerializable()
class APIErrorResponse {
  APIErrorResponse({required this.message, this.errorCode});
  factory APIErrorResponse.timeoutErrorResponse() => APIErrorResponse(
    message: APIErrorStatus.timeoutError.errorMessage,
    errorCode: APIErrorStatus.timeoutError.errorTemplate,
  );

  factory APIErrorResponse.socketErrorResponse() => APIErrorResponse(
    message: APIErrorStatus.socketExceptionError.errorMessage,
    errorCode: APIErrorStatus.socketExceptionError.errorTemplate,
  );

  factory APIErrorResponse.typeCastingErrorResponse() => APIErrorResponse(
    message: APIErrorStatus.typeCastingError.errorMessage,
    errorCode: APIErrorStatus.typeCastingError.errorTemplate,
  );

  factory APIErrorResponse.unauthorizedErrorResponse() => APIErrorResponse(
    message: APIErrorStatus.unauthorized.errorMessage,
    errorCode: APIErrorStatus.unauthorized.errorTemplate,
  );

  factory APIErrorResponse.serverErrorResponse() => APIErrorResponse(
    message: APIErrorStatus.serverError.errorMessage,
    errorCode: APIErrorStatus.serverError.errorTemplate,
  );

  factory APIErrorResponse.fromJson(Map<String, dynamic> json) =>
      _$APIErrorResponseFromJson(json);
  Map<String, dynamic> toJson() => _$APIErrorResponseToJson(this);

  final String message;
  final String? errorCode;
}
