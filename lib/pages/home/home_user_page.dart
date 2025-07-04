import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:madnolia/blocs/blocs.dart';
import 'package:madnolia/blocs/platform_games/platform_games_bloc.dart';
import 'package:madnolia/enums/chat_message_status.enum.dart';
import 'package:madnolia/services/local_notifications_service.dart';
import 'package:madnolia/services/messages_service.dart';
import 'package:madnolia/services/notifications_service.dart';
import 'package:madnolia/utils/platforms.dart';
import 'package:madnolia/widgets/alert_widget.dart';
import 'package:madnolia/widgets/atoms/ads/atom_banner_ad.dart';
import 'package:madnolia/widgets/molecules/molecule_platform_matches.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:madnolia/models/user/user_model.dart';
import 'package:madnolia/services/user_service.dart';
// import 'package:madnolia/widgets/alert_widget.dart';
import 'package:madnolia/widgets/custom_scaffold.dart';


class HomeUserPage extends StatefulWidget {  // Changed to StatefulWidget
  const HomeUserPage({super.key});

  @override
  State<HomeUserPage> createState() => _HomeUserPageState();
}

class _HomeUserPageState extends State<HomeUserPage> {
  int _retryCount = 0;
  final int _maxRetries = 3;
  late Future<dynamic> _loadInfoFuture;

  @override
  void initState() {
    super.initState();
    _loadInfoFuture = _loadInfo(context);
  }

  void _retryLoadInfo() {
    if (_retryCount < _maxRetries) {
      setState(() {
        _retryCount++;
        _loadInfoFuture = _loadInfo(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    
    final platformsGamesBloc = context.watch<PlatformGamesBloc>();
    
    return CustomScaffold(
      body: CustomMaterialIndicator(
        autoRebuild: false,
        onRefresh: () async {
          platformsGamesBloc.add(RestorePlatformsGamesState());
          _retryLoadInfo(); // Also retry when manually refreshing
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
              final userBloc = context.watch<UserBloc>().state;
              return ListView.builder(
                cacheExtent: 9999999,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: userBloc.platforms.length,
                itemBuilder: (BuildContext context, int platformIndex) {
                  return Column(
                    children: [
                      kDebugMode ? SizedBox() : const AtomBannerAd(),
                      Container(
                        width: double.infinity,
                        color: Colors.black45,
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          runAlignment: WrapAlignment.center,
                          spacing: 20,
                          children: [
                            Text(getPlatformInfo(userBloc.platforms[platformIndex]).name),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SvgPicture.asset(
                                getPlatformInfo(userBloc.platforms[platformIndex]).path,
                                width: 90,
                                colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                              ),
                            ),
                          ],
                        ),
                      ),
                      MoleculePlatformMatches(platform: userBloc.platforms[platformIndex])
                    ],
                  );
                },
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
      debugPrint('Loading info... Attempt ${_retryCount + 1}/$_maxRetries');
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
        await storage.delete(key: "token");
        userBloc.logOutUser();
        if (!context.mounted) return null;
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
          if(chat.message.creator != userBloc.state.id && chat.message.status == ChatMessageStatus.sent) messageBloc.add(UpdateUnreadUserChatCount(value: 1));
        }
      }
      
      return userInfo;
    } catch (e) {
      debugPrint("Load error: $e");
      rethrow;
    }
  }
}