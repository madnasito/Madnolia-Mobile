import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:madnolia/blocs/blocs.dart';
import 'package:madnolia/blocs/platform_games/platform_games_bloc.dart';
import 'package:madnolia/enums/chat_message_status.enum.dart';
import 'package:madnolia/services/local_notifications_service.dart';
import 'package:madnolia/services/messages_service.dart';
import 'package:madnolia/services/notifications_service.dart';
import 'package:madnolia/utils/logout.dart';
import 'package:madnolia/widgets/alert_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:madnolia/models/user/user_model.dart';
import 'package:madnolia/services/user_service.dart';
import 'package:madnolia/widgets/atoms/buttons/common/atom_create_match_button.dart';
import 'package:madnolia/widgets/scaffolds/custom_scaffold.dart';
import 'package:madnolia/widgets/organism/cards/organism_card_platform_matches.dart';


class HomeUserPage extends StatefulWidget {  // Changed to StatefulWidget
  const HomeUserPage({super.key});

  @override
  State<HomeUserPage> createState() => _HomeUserPageState();
}

class _HomeUserPageState extends State<HomeUserPage> {
  late Future<dynamic> _loadInfoFuture;

  @override
  void initState() {
    super.initState();
    _loadInfoFuture = _loadInfo(context);
  }

  void _retryLoadInfo() {
      setState(() {
        _loadInfoFuture = _loadInfo(context);
      });
  }

    @override
  Widget build(BuildContext context) {
    final platformsGamesBloc = context.watch<PlatformGamesBloc>();

    return CustomScaffold(
      body: CustomMaterialIndicator(
        autoRebuild: false,
        onRefresh: () async {
          platformsGamesBloc.add(RestorePlatformsGamesState());
          _retryLoadInfo();
        },
        child: FutureBuilder(
          future: _loadInfoFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError || snapshot.data == null) {
              return Center(
                child: ElevatedButton(
                  onPressed: _retryLoadInfo,
                  child: Text(translate('UTILS.RELOAD')),
                ),
              );
            } else if (snapshot.hasData) {
              int matchesCount = 0;

              for (var platform in platformsGamesBloc.state.platformGames) {
                matchesCount += platform.games.length;
              }

              if (matchesCount == 0 && platformsGamesBloc.state.platformGames.isNotEmpty) {
                return SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: MediaQuery.of(context).size.height * 0.3), // Espacio para centrar verticalmente
                        Text(
                          translate('HOME.NO_MATCHES'),
                          style: TextStyle(color: Colors.grey),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 20),
                        AtomCreateMatchButton(),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.3), // Espacio para permitir scroll
                      ],
                    ),
                  ),
                );
              }

              // Lista con el botón al final
              return ListView(
                physics: AlwaysScrollableScrollPhysics(),
                children: [
                  // Lista de plataformas y partidos
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: platformsGamesBloc.state.platformGames.length,
                    itemBuilder: (BuildContext context, int platformIndex) {
                      final platformGames = platformsGamesBloc.state.platformGames[platformIndex];
                      return OrganismCardPlatformMatches(platformGames: platformGames);
                    },
                  ),
                ],
              );
            }
            return const Placeholder();
          },
        ),
      ),
    );
  }


  Future<dynamic> _loadInfo(BuildContext context) async {
    try {
      await LocalNotificationsService.initialize();
      if (!context.mounted) return null;

      final userBloc = context.read<UserBloc>();
      final messageBloc = context.read<MessageBloc>();
      final platformsGamesBloc = context.read<PlatformGamesBloc>();
      const storage = FlutterSecureStorage();
      final Map<String, dynamic> userInfo = await UserService().getUserInfo();

      if (userInfo.containsKey("error")) {
        if (!context.mounted) return null;
        showErrorServerAlert(context, userInfo);
        throw Exception("Server error");
      } else if (userInfo.containsKey("message")) {
        if (!context.mounted) return null;
        logoutApp(context);
        context.go("/home");
        return null;
      }


      if (userInfo.isEmpty) {
        await storage.delete(key: "token");
        userBloc.logOutUser();
        if (!context.mounted) return null;
        context.go("/home");
        return null;
      }

      final User user = User.fromJson(userInfo);
      final int unreadNotificationsCount = await NotificationsService().getNotificationsCount();
      userBloc.updateNotifications(unreadNotificationsCount);
      userBloc.loadInfo(user);
      if(platformsGamesBloc.state.platformGames.isEmpty) platformsGamesBloc.add(LoadPlatforms(platforms: user.platforms));

      if(messageBloc.state.unreadUserChats == 0) {
        final chats = await MessagesService().getChats(0);
        for (var chat in chats) {
          if(chat.message.creator != userBloc.state.id && chat.message.status == ChatListStatus.sent) messageBloc.add(UpdateUnreadUserChatCount(value: 1));
        }
      }
      
      return userInfo;
    } catch (e) {
      debugPrint("Load error: $e");
      rethrow;
    }
  }
}