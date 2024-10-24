import 'package:flirt/internal/api.dart';
import 'package:json_annotation/json_annotation.dart';

part 'api_error_response.g.dart';

@JsonSerializable()
class APIErrorResponse {
  APIErrorResponse({
    required this.message,
    this.errorCode,
  });

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

  factory APIErrorResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$APIErrorResponseFromJson(json);
  Map<String, dynamic> toJson() => _$APIErrorResponseToJson(this);

  final String message;
  final String? errorCode;
}
