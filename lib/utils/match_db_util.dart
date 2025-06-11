import 'package:madnolia/models/match/minimal_match_model.dart' show MinimalMatch;
import 'package:madnolia/database/providers/match_db.dart' show MatchProvider, MinimalMatchDb;
import 'package:madnolia/services/match_service.dart' show MatchService;

Future<MinimalMatchDb?> getMatchDb (String id) async {

    try {
      
      MinimalMatchDb? matchDb;
      if(await MatchProvider.getMatch(id) == null) {
        final Map<String, dynamic> matchInfo = await MatchService().getMatch(id);
        final MinimalMatch minimalMatch = MinimalMatch.fromJson(matchInfo);
        matchDb = MinimalMatchDb(
          date: minimalMatch.date, 
          platform: minimalMatch.platform, 
          title: minimalMatch.title, 
          id: minimalMatch.id
        );
        await MatchProvider.insertMatch(matchDb);
      } else {
        matchDb = await MatchProvider.getMatch(id);
      }

      return matchDb;
    } catch (e) {
      throw Exception(e);
    }
  }