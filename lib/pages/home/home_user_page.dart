import 'package:Madnolia/blocs/blocs.dart';
import 'package:Madnolia/blocs/sockets/sockets_bloc.dart';
import 'package:Madnolia/utils/platform_id_ico.dart';
import 'package:Madnolia/widgets/molecules/platform_matches_molecule.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:Madnolia/models/user/user_model.dart';
import 'package:Madnolia/services/user_service.dart';
// import 'package:Madnolia/widgets/alert_widget.dart';
import 'package:Madnolia/widgets/background.dart';
import 'package:Madnolia/widgets/custom_scaffold.dart';
import 'package:socket_io_client/socket_io_client.dart';

class HomeUserPage extends StatefulWidget {
  const HomeUserPage({super.key});

  static const Color mainColor = Colors.deepPurple;

  @override
  State<HomeUserPage> createState() => _HomeUserPageState();
}

class _HomeUserPageState extends State<HomeUserPage> {

  @override
  void initState() {


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    return  FutureBuilder(
        future: _loadInfo(context),
        builder: (context, snapshot) {
          final userBloc = context.read<UserBloc>().state;
          final socketBloc = context.read<SocketsBloc>();
          socketBloc.state.clientSocket.onConnect((_) async {
            socketBloc.updateServerStatus(ServerStatus.online);
          });
          if (snapshot.hasData) {
            return CustomScaffold(
                body: Background(
                child: SafeArea(
                  child: ListView.builder(
                  cacheExtent: 90000,
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: userBloc.platforms.length,
                  itemBuilder: (BuildContext context, int platformIndex) {
                    return Column(
                      children:[ 
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
                              SvgPicture.asset(
                              getPlatformInfo(userBloc.platforms[platformIndex]).path,
                              width: 60,
                              color: Colors.white,
                            )],
                          ),
                        ),
                        PlatformMatchesMolecule(platform: userBloc.platforms[platformIndex])
                      ]
                    );
                  })
                  )
                ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      
    );
  }
  
  _loadInfo(BuildContext context) async {
    try {
      final Map<String, dynamic> userInfo = await UserService().getUserInfo();

    // ignore: use_build_context_synchronously
    final userBloc = context. read<UserBloc>();
    final socketBloc = context.read<SocketsBloc>();
    if (userInfo.isEmpty) {
      const storage = FlutterSecureStorage();

      await storage.delete(key: "token");

      userBloc.logOutUser();
      // ignore: use_build_context_synchronously
      // showAlert(context, "Token error");
      // ignore: use_build_context_synchronously
      return context.go("/home");
    }

    final User user = User.fromJson(userInfo);

    userBloc.loadInfo(user);
    socketBloc.updateSocket();


    return userInfo;
    } catch (e) {
      print(e);
      return {};
    }
    
  }

}
