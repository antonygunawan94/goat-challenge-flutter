import 'package:goat_challenge/src/main/models/main_book.dart';

class MainSearchBookResult {
  final String? next;
  final List<MainBook> books;

  const MainSearchBookResult({
    this.next,
    required this.books,
  });

  Map<String, dynamic> toMap() {
    return {
      'next': next,
      'books': books,
    };
  }

  factory MainSearchBookResult.fromMap(Map<String, dynamic> json) {
    return MainSearchBookResult(
      next: json['next'],
      books:
          List<MainBook>.from(json['results'].map((x) => MainBook.fromMap(x))),
    );
  }
}
