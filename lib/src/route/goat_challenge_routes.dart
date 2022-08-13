class GoatChallengeRoutes {
  static const main = "/";

  GoatChallengeRoutes._();

  static String detail({int? id}) => "/${id ?? ":id"}";

  static String similar({String? author, String? subject, String? bookshelf}) =>
      "/similar${author != null ? "?author=$author" : ""}${subject != null ? "?subject=$subject" : ""}${bookshelf != null ? "?bookshelf=$bookshelf" : ""}";
}
