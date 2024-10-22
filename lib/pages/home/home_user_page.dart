import 'package:madnolia/blocs/blocs.dart';
import 'package:madnolia/blocs/sockets/sockets_bloc.dart';
import 'package:madnolia/utils/platform_id_ico.dart';
import 'package:madnolia/utils/socket_handler.dart';
import 'package:madnolia/widgets/molecules/platform_matches_molecule.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:madnolia/models/user/user_model.dart';
import 'package:madnolia/services/user_service.dart';
// import 'package:madnolia/widgets/alert_widget.dart';
import 'package:madnolia/widgets/background.dart';
import 'package:madnolia/widgets/custom_scaffold.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
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
                  cacheExtent: 9999999,
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: userBloc.platforms.length,
                  itemBuilder: (BuildContext context, int platformIndex) {
                    return Column(
                      children:[ 
                        const MyBannerAdWidget(),
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
      final userBloc = context.read<UserBloc>();
      
      if(userBloc.state.id != "") return;
      
      final Map<String, dynamic> userInfo = await UserService().getUserInfo();
      // ignore: use_build_context_synchronously

      final socketBloc = context.read<SocketsBloc>();
      const storage = FlutterSecureStorage();
      if (userInfo.isEmpty) {

        await storage.delete(key: "token");

        userBloc.logOutUser();
        // ignore: use_build_context_synchronously
        // showAlert(context, "Token error");
        // ignore: use_build_context_synchronously
        return context.go("/home");
      }
      final User user = User.fromJson(userInfo);
      
      print(socketBloc.state.clientSocket.io.options?["extraHeaders"]["token"]);

      userBloc.loadInfo(user);

      return userInfo;
    } catch (e) {
      print(e);
      return {};
    }
    
  }

}

class MyBannerAdWidget extends StatefulWidget {
  final AdSize adSize;
  final String adUnitId = "ca-app-pub-5842948645365527/5704194412";
  const MyBannerAdWidget({super.key, this.adSize = AdSize.banner});

  @override
  State<MyBannerAdWidget> createState() => _MyBannerAdWidgetState();
}

class _MyBannerAdWidgetState extends State<MyBannerAdWidget> {

  /// The banner ad to show. This is `null` until the ad is actually loaded.
  BannerAd? _bannerAd;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: widget.adSize.width.toDouble(),
        height: widget.adSize.height.toDouble(),
        child: _bannerAd == null
            // Nothing to render yet.
            ? const SizedBox()
            // The actual ad.
            : SizedBox(
                width: _bannerAd!.size.width.toDouble(),
                height: _bannerAd!.size.height.toDouble(),
                child: AdWidget(ad: _bannerAd!)),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _loadAd();
  }
  /// Loads a banner ad.
  void _loadAd() {
    final bannerAd = BannerAd(
      size: widget.adSize,
      adUnitId: widget.adUnitId,
      request: const AdRequest(),
      listener: BannerAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (ad) {
          if (!mounted) {
            ad.dispose();
            return;
          }
          setState(() {
            _bannerAd = ad as BannerAd;
          });
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (ad, error) {
          debugPrint('BannerAd failed to load: $error');
          ad.dispose();
        },
      ),
    );

    // Start loading.
    bannerAd.load();
  }
}
