import 'package:flutter/foundation.dart';

class RecordRequestDTO {
  RecordRequestDTO({
    @required this.id,
    @required this.data,
  });

  final String id;
  final String data;
}

class RecordResponseDTO {
  RecordResponseDTO({
    this.id,
    this.data,
    this.createdAt,
  });

  final String id;
  final String data;
  final int createdAt;
}
