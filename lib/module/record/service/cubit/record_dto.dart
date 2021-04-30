class RecordRequestDTO {
  RecordRequestDTO({
    required this.id,
    required this.data,
  });

  final String id;
  final String data;
}

class RecordResponseDTO {
  RecordResponseDTO({
    required this.id,
    required this.data,
    required this.createdAt,
  });

  final String id;
  final String data;
  final int createdAt;
}
