class Match {
  String gameName;
  String gameId;
  int platform;
  num date;
  String user;
  List<String> users;
  String message;
  List<String> likes;
  bool active;
  bool tournament;

  Match({
    required this.gameName,
    required this.gameId,
    required this.platform,
    required this.date,
    required this.user,
    required this.users,
    required this.message,
    required this.likes,
    required this.active,
    required this.tournament,
  });
}
