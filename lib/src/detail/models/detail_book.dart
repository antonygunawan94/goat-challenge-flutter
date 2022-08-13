class DetailBook {
  final int id;
  final String title;
  final List<DetailAuthor> authors;
  final List<DetailTranslator> translators;
  final List<String> subjects;
  final List<String> bookshelves;
  final List<String> languages;
  final bool copyright;
  final String mediaType;
  final DetailFormats formats;
  final int downloadCount;

  DetailBook({
    required this.id,
    required this.title,
    required this.authors,
    required this.translators,
    required this.subjects,
    required this.bookshelves,
    required this.languages,
    required this.copyright,
    required this.mediaType,
    required this.formats,
    required this.downloadCount,
  });

  factory DetailBook.fromMap(Map<String, dynamic> json) => DetailBook(
        id: json["id"],
        title: json["title"],
        authors: List<DetailAuthor>.from(
            json["authors"].map((x) => DetailAuthor.fromMap(x))),
        translators: List<DetailTranslator>.from(
            json["translators"].map((x) => DetailTranslator.fromMap(x))),
        subjects: List<String>.from(json["subjects"].map((x) => x)),
        bookshelves: List<String>.from(json["bookshelves"].map((x) => x)),
        languages: List<String>.from(json["languages"].map((x) => x)),
        copyright: json["copyright"],
        mediaType: json["media_type"],
        formats: DetailFormats.fromMap(json["formats"]),
        downloadCount: json["download_count"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "authors": List<dynamic>.from(authors.map((x) => x.toMap())),
        "translators": List<dynamic>.from(translators.map((x) => x.toMap())),
        "subjects": List<dynamic>.from(subjects.map((x) => x)),
        "bookshelves": List<dynamic>.from(bookshelves.map((x) => x)),
        "languages": List<dynamic>.from(languages.map((x) => x)),
        "copyright": copyright,
        "media_type": mediaType,
        "formats": formats.toMap(),
        "download_count": downloadCount,
      };
}

class DetailAuthor {
  final String name;
  final int? birthYear;
  final int? deathYear;

  DetailAuthor({
    required this.name,
    required this.birthYear,
    required this.deathYear,
  });

  factory DetailAuthor.fromMap(Map<String, dynamic> json) {
    return DetailAuthor(
      name: json["name"],
      birthYear: json["birth_year"],
      deathYear: json["death_year"],
    );
  }

  Map<String, dynamic> toMap() => {
        "name": name,
        "birth_year": birthYear,
        "death_year": deathYear,
      };
}

class DetailTranslator {
  final String name;
  final int? birthYear;
  final int? deathYear;

  DetailTranslator({
    required this.name,
    required this.birthYear,
    required this.deathYear,
  });

  factory DetailTranslator.fromMap(Map<String, dynamic> json) =>
      DetailTranslator(
        name: json["name"],
        birthYear: json["birth_year"],
        deathYear: json["death_year"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "birth_year": birthYear,
        "death_year": deathYear,
      };
}

class DetailFormats {
  DetailFormats({
    required this.applicationXMobipocketEbook,
    required this.applicationEpubZip,
    required this.applicationRdfXml,
    required this.imageJpeg,
    required this.textPlainCharsetUtf8,
    required this.textHtmlCharsetUtf8,
    required this.textHtml,
  });

  final String? applicationXMobipocketEbook;
  final String? applicationEpubZip;
  final String? applicationRdfXml;
  final String? imageJpeg;
  final String? textPlainCharsetUtf8;
  final String? textHtmlCharsetUtf8;
  final String? textHtml;

  factory DetailFormats.fromMap(Map<String, dynamic> json) => DetailFormats(
        applicationXMobipocketEbook: json["application/x-mobipocket-ebook"],
        applicationEpubZip: json["application/epub+zip"],
        applicationRdfXml: json["application/rdf+xml"],
        imageJpeg: json["image/jpeg"],
        textPlainCharsetUtf8: json["text/plain; charset=utf-8"],
        textHtmlCharsetUtf8: json["text/html; charset=utf-8"],
        textHtml: json["text/html"],
      );

  Map<String, dynamic> toMap() => {
        "application/x-mobipocket-ebook": applicationXMobipocketEbook,
        "application/epub+zip": applicationEpubZip,
        "application/rdf+xml": applicationRdfXml,
        "image/jpeg": imageJpeg,
        "text/plain; charset=utf-8": textPlainCharsetUtf8,
        "text/html; charset=utf-8": textHtmlCharsetUtf8,
        "text/html": textHtml,
      };
}
