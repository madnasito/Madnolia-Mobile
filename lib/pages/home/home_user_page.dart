import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:madnolia/blocs/blocs.dart';
import 'package:madnolia/cubits/cubits.dart';
import 'package:madnolia/utils/platforms.dart';
import 'package:madnolia/widgets/alert_widget.dart';
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

import '../../services/sockets_service.dart';

class HomeUserPage extends StatelessWidget {
  const HomeUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    
    final platformGamesCubit = context.watch<PlatformGamesCubit>();
    return  CustomScaffold(
              body: CustomMaterialIndicator(
                autoRebuild: false,
                onRefresh: () async{ 
                  // setState(() { 
                    platformGamesCubit.cleanData();
                    // print(platformGamesCubit.state.data);
                  // });
                 },
                child: FutureBuilder(
                  future: _loadInfo(context),
                  builder: (context, snapshot) {
                    if(snapshot.hasData){
                      final userBloc = context.watch<UserBloc>().state;
                      return ListView.builder(
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
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SvgPicture.asset(
                                      getPlatformInfo(userBloc.platforms[platformIndex]).path,
                                      width: 90,
                                      colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                                    ))],
                                ),
                              ),
                              MoleculePlatformMatches(platform: userBloc.platforms[platformIndex])
                            ]
                          );
                        }
                        );
                    } else if(!snapshot.hasData){
                      return const Center(child: CircularProgressIndicator());
                    }else if(snapshot.hasError){
                      return const Center(child: Text("Check your connection"));
                    }else{
                      return const Placeholder();
                    }
                  },
                ),
              ),
            );
    // FutureBuilder(
    //     future: _loadInfo(context),
    //     builder: (context, snapshot) {
    //       final userBloc = context.read<UserBloc>().state;
          
    //       if (snapshot.hasData) {
    //         return 
    //       } 
    //     },
      
    // );
  }
  
  _loadInfo(BuildContext context) async {
    try {
      final userBloc = context.read<UserBloc>();

      final Map<String, dynamic> userInfo = await UserService().getUserInfo();

      if (userInfo.containsKey("error")) {
        // Check if the widget is still mounted before using context
        if (!context.mounted) return;
        return showErrorServerAlert(context, userInfo);
      }

      const storage = FlutterSecureStorage();
      await initializeService();
      
      if (userInfo.isEmpty) {
        await storage.delete(key: "token");
        userBloc.logOutUser();
        
        // Check if the widget is still mounted before using context
          if (!context.mounted) return;
          return context.go("/home");
        
      }

      final User user = User.fromJson(userInfo);
      userBloc.loadInfo(user);
      
      return userInfo;
    } catch (e) {
      debugPrint(e.toString());
      return null;
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
