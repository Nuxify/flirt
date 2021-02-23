// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'record_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecordResponse _$RecordResponseFromJson(Map<String, dynamic> json) {
  return RecordResponse(
    id: json['id'] as String,
    data: json['data'] as String,
    createdAt: json['createdAt'] as int,
  );
}

Map<String, dynamic> _$RecordResponseToJson(RecordResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'data': instance.data,
      'createdAt': instance.createdAt,
    };
