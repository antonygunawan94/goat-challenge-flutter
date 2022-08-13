import 'package:goat_challenge/src/similar/models/similar_book.dart';

class SimilarSearchBookResult {
  final String? next;
  final List<SimilarBook> books;

  const SimilarSearchBookResult({
    this.next,
    required this.books,
  });

  Map<String, dynamic> toMap() {
    return {
      'next': next,
      'books': books,
    };
  }

  factory SimilarSearchBookResult.fromMap(Map<String, dynamic> json) {
    return SimilarSearchBookResult(
      next: json['next'],
      books: List<SimilarBook>.from(
          json['results'].map((x) => SimilarBook.fromMap(x))),
    );
  }
}
