class QuoteRequestDTO {
  QuoteRequestDTO({
    required this.id,
    required this.data,
  });

  final String id;
  final String data;
}

class QuoteResponseDTO {
  QuoteResponseDTO({
    required this.id,
    required this.author,
    required this.en,
  });

  final String id;
  final String author;
  final String en;
}

class QuoteStateDTO {
  QuoteStateDTO({
    required this.quotes,
    required this.authors,
  });
  final List<QuoteResponseDTO> quotes;
  final List<String> authors;
}
