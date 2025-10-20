import 'package:madnolia/database/chat_messages/chat_message_repository.dart';
import 'package:madnolia/database/conversations/conversation_state_repository.dart';
import 'package:madnolia/database/database.dart';
import 'package:madnolia/database/friendships/frienship.repository.dart';
import 'package:madnolia/database/games/games.repository.dart';
import 'package:madnolia/database/match/match_repository.dart';
import 'package:madnolia/database/users/user_repository.dart';

class RepositoryManager {
  static RepositoryManager? _instance;
  
  factory RepositoryManager() {
    return _instance ??= RepositoryManager._internal();
  }
  
  final AppDatabase database;
  late final ChatMessageRepository chatMessage;
  late final ConversationRepository conversation;
  late final FriendshipRepository friendship;
  late final GamesRepository games;
  late final MatchRepository match;
  late final UserRepository user;

  RepositoryManager._internal() : database = AppDatabase() {
    chatMessage = ChatMessageRepository(database);
    conversation = ConversationRepository(database);
    friendship = FriendshipRepository(database);
    games = GamesRepository(database);
    match = MatchRepository(database);
    user = UserRepository(database);
  }

  static Future<void> reset() async {
    if (_instance != null) {
      await _instance!.database.close();
      _instance = null;
    }
  }
}