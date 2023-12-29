import 'dart:convert';

import 'package:Madnolia/services/games_service.dart';
import 'package:Madnolia/utils/platform_id_ico.dart';
import 'package:Madnolia/widgets/match_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:Madnolia/models/user_model.dart';
import 'package:Madnolia/providers/user_provider.dart';
import 'package:Madnolia/services/sockets_service.dart';
import 'package:Madnolia/services/user_service.dart';
// import 'package:Madnolia/widgets/alert_widget.dart';
import 'package:Madnolia/widgets/background.dart';
import 'package:Madnolia/widgets/custom_scaffold.dart';
import 'package:provider/provider.dart';
import 'package:Madnolia/models/game_home_model.dart';

import 'package:Madnolia/models/game_model.dart' as gameCard;

class HomeUserPage extends StatefulWidget {
  const HomeUserPage({super.key});

  static const Color mainColor = Colors.deepPurple;

  @override
  State<HomeUserPage> createState() => _HomeUserPageState();
}

class _HomeUserPageState extends State<HomeUserPage> {
  late SocketService socketService;
  late UserProvider userProvider;

  @override
  void initState() {
    userProvider = Provider.of<UserProvider>(context, listen: false);
    socketService = Provider.of<SocketService>(context, listen: false);
    socketService.connect();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _loadInfo(context, userProvider),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return CustomScaffold(
              body: Background(
            child: SafeArea(
                child: FutureBuilder(
              future: _loadGames(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<dynamic>> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: snapshot.data?.length,
                      itemBuilder: (BuildContext context, int index) {
                        print(getPlatformInfo(snapshot.data?[index].platform)
                            .path);
                        return Column(
                          children: [
                            Container(
                              width: double.infinity,
                              color: Colors.black,
                              child: Wrap(
                                alignment: WrapAlignment.center,
                                crossAxisAlignment: WrapCrossAlignment.center,
                                runAlignment: WrapAlignment.center,
                                spacing: 20,
                                children: [
                                  Text(snapshot.data?[index].name,
                                      style: TextStyle(fontSize: 20)),
                                  SvgPicture.asset(
                                    getPlatformInfo(
                                            snapshot.data?[index].platform)
                                        .path,
                                    height: 50,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                            ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
                              itemCount: snapshot.data?[index].games.length,
                              itemBuilder: (BuildContext context, int i) {
                                final game = snapshot.data?[index].games[i];
                                final platforms = game.platforms;

                                var plataformaEncontrada = platforms.firstWhere(
                                    (plataforma) =>
                                        plataforma.platformId ==
                                        snapshot.data?[index].platform);

                                return GestureDetector(
                                  onTap: () => GoRouter.of(context)
                                      .push("/game", extra: {
                                    "platform_category":
                                        snapshot.data?[index].platformCategory,
                                    "platform": snapshot.data?[index].platform,
                                    "game": gameCard.Game(
                                        backgroundImage: game.backgroundImage,
                                        id: game.gameId,
                                        name: game.name)
                                  }),
                                  child: GameCard(
                                      game: gameCard.Game(
                                          backgroundImage: game.backgroundImage,
                                          id: game.gameId,
                                          name: game.name),
                                      bottom: Text(
                                          "\n ${plataformaEncontrada.amount} Matches created")),
                                );
                              },
                            )
                          ],
                        );
                      });
                } else {
                  return Center(
                    child: Column(
                      children: [
                        CircularProgressIndicator(),
                        Text("Loading games")
                      ],
                    ),
                  );
                }
              },
            )),
          ));
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  _loadInfo(BuildContext context, UserProvider user) async {
    final userInfo = await UserService().getUserInfo();

    if (userInfo["ok"] == false) {
      const storage = FlutterSecureStorage();

      await storage.delete(key: "token");
      // ignore: use_build_context_synchronously
      // showAlert(context, "Token error");
      // ignore: use_build_context_synchronously
      return context.go("/home");
    }

    user.user = userFromJson(jsonEncode(userInfo));

    return userInfo;
  }

  Future<List> _loadGames() async {
    final gamesResp = await GamesService().getHomeGames();

    if (gamesResp["ok"]) {
      final platforms = gamesResp["platforms"];

      final values =
          platforms.map((e) => GamesHomeResponse.fromJson(e)).toList();

      return values;
    } else {
      return [];
    }
  }
}
