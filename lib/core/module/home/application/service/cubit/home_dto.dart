class QuoteResponseDTO {
  QuoteResponseDTO({
    required this.author,
    required this.content,
  });

  final String author;
  final String content;
}

class QuoteStateDTO {
  QuoteStateDTO({
    required this.quotes,
    required this.authors,
  });
  final List<QuoteResponseDTO> quotes;
  final List<String> authors;
}
