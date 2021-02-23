// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

APIResponse<T> _$APIResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object json) fromJsonT,
) {
  return APIResponse<T>(
    success: json['success'] as bool,
    message: json['message'] as String,
    errorCode: json['errorCode'] as String,
    data: fromJsonT(json['data']),
  );
}

Map<String, dynamic> _$APIResponseToJson<T>(
  APIResponse<T> instance,
  Object Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'errorCode': instance.errorCode,
      'data': toJsonT(instance.data),
    };

APIListResponse<T> _$APIListResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object json) fromJsonT,
) {
  return APIListResponse<T>(
    success: json['success'] as bool,
    message: json['message'] as String,
    errorCode: json['errorCode'] as String,
    data: (json['data'] as List)?.map(fromJsonT)?.toList(),
  );
}

Map<String, dynamic> _$APIListResponseToJson<T>(
  APIListResponse<T> instance,
  Object Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'errorCode': instance.errorCode,
      'data': instance.data?.map(toJsonT)?.toList(),
    };
