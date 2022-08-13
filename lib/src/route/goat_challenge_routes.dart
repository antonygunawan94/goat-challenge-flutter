class GoatChallengeRoutes {
  static const main = "/";

  GoatChallengeRoutes._();

  static String detail({int? id}) => "/${id ?? ":id"}";
}
