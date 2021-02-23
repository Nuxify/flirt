// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'record_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecordRequest _$RecordRequestFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['id', 'data']);
  return RecordRequest(
    id: json['id'] as String,
    data: json['data'] as String,
  );
}

Map<String, dynamic> _$RecordRequestToJson(RecordRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'data': instance.data,
    };
