import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:dio/dio.dart';
import 'package:go_router/go_router.dart';
import 'package:madnolia/i18n/strings.g.dart';
import 'package:madnolia/blocs/blocs.dart';
import 'package:madnolia/blocs/platform_games/platform_games_bloc.dart';
import 'package:madnolia/enums/chat_message_status.enum.dart';
import 'package:madnolia/services/local_notifications_service.dart';
import 'package:madnolia/services/messages_service.dart';
import 'package:madnolia/services/notifications_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madnolia/models/user/user_model.dart';
import 'package:madnolia/services/user_service.dart';
import 'package:madnolia/utils/logout.dart';
import 'package:madnolia/widgets/atoms/buttons/common/atom_create_match_button.dart';
import 'package:madnolia/widgets/scaffolds/custom_scaffold.dart';
import 'package:madnolia/widgets/organism/cards/organism_card_platform_matches.dart';

import '../../widgets/alert_widget.dart';

class HomeUserPage extends StatefulWidget {
  // Changed to StatefulWidget
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
                  child: Text(t.UTILS.RELOAD),
                ),
              );
            } else if (snapshot.hasData) {
              int matchesCount = 0;

              for (var platform in platformsGamesBloc.state.platformGames) {
                matchesCount += platform.games.length;
              }

              if (matchesCount == 0 &&
                  platformsGamesBloc.state.platformGames.isNotEmpty) {
                return SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.3,
                        ), // Espacio para centrar verticalmente
                        Text(
                          t.HOME.NO_MATCHES,
                          style: TextStyle(color: Colors.grey),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 20),
                        AtomCreateMatchButton(),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.3,
                        ), // Espacio para permitir scroll
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
                      final platformGames =
                          platformsGamesBloc.state.platformGames[platformIndex];
                      return OrganismCardPlatformMatches(
                        platformGames: platformGames,
                      );
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

      final User user = await UserService().getUserInfo();
      final int unreadNotificationsCount = await NotificationsService()
          .getNotificationsCount();
      userBloc.add(AddNotifications(value: unreadNotificationsCount));
      userBloc.add(UpdateData(user: user));
      if (platformsGamesBloc.state.platformGames.isEmpty) {
        platformsGamesBloc.add(LoadPlatforms(platforms: user.platforms));
      }

      if (messageBloc.state.unreadUserChats == 0) {
        final chats = await MessagesService().getUsersChats(0);
        for (var chat in chats) {
          if (chat.message.creator != userBloc.state.id &&
              chat.message.status == ChatMessageStatus.sent) {
            messageBloc.add(UpdateUnreadUserChatCount(value: 1));
          }
        }
      }

      return user;
    } catch (e) {
      debugPrint("Load error: $e");

      if(e is DioException){
        debugPrint("Dio Error:  ${e.error.toString()}");
        debugPrint("Dio message: ${e.message}");
        debugPrint("Dio exception: ${e.type}");
        
        
        if(!context.mounted) return;
        switch (e.type) {
          case DioExceptionType.connectionError:
            showAlert(context, t.ERRORS.SERVER.NETWORK_ERROR);
            break;
          case DioExceptionType.badResponse:
            await logoutApp(context);
            if(!context.mounted) return;
            context.go('/login');
          default:
            break;
        }
      }else{
        if(!context.mounted) return;
        await logoutApp(context);
        if(!context.mounted) return;
        context.go('/');    
      }
      rethrow;
    }
  }
}
