import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:madnolia/blocs/blocs.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:go_router/go_router.dart';

import 'package:animate_do/animate_do.dart';
import 'package:madnolia/style/text_style.dart';
import 'package:madnolia/widgets/atoms/text_atoms/center_title_atom.dart';



import 'package:madnolia/widgets/scaffolds/custom_scaffold.dart';

import '../../widgets/platform_icon_widget.dart';

class NewPage extends StatefulWidget {
  const NewPage({super.key});

  @override
  State<NewPage> createState() => _NewPageState();
  
}

class _NewPageState extends State<NewPage> {
  int selectedPlatform = 0;
  @override
  Widget build(BuildContext context) {

    if (GoRouterState.of(context).extra != null) {
      if (GoRouterState.of(context).extra is int) {
        selectedPlatform = GoRouterState.of(context).extra as int;
      }
    }

  return CustomScaffold(
      body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              FadeIn(
                  delay: const Duration(milliseconds: 300),
                  child: CenterTitleAtom(
                    text: translate("CREATE_MATCH.TITLE"),
                    textStyle: neonTitleText,
                  )),
              const SizedBox(height: 10),
              SingleChildScrollView(
                dragStartBehavior: DragStartBehavior.start,
                child: FadeIn(
                  delay: const Duration(seconds: 1),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      ...userPlatforms(),
                      const SizedBox(height: 70),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      
    );
  }

  List<Widget> userPlatforms() {
    final userBloc = context.watch<UserBloc>();
    List<Platform> platforms = [
      Platform(
          id: 17,
          path: "assets/platforms/playstation_portable.svg",
          active: userBloc.state.platforms.contains(17) ? true : false,
          size: 20, padding: 10),
      Platform(
          id: 15,
          path: "assets/platforms/playstation_2.svg",
          active: userBloc.state.platforms.contains(15) ? true : false,
          size: 20, padding: 20),
      Platform(
          id: 16,
          path: "assets/platforms/playstation_3.svg",
          active: userBloc.state.platforms.contains(16) ? true : false,
          size: 20, padding: 20),
      Platform(
          id: 18,
          path: "assets/platforms/playstation_4.svg",
          active: userBloc.state.platforms.contains(18) ? true : false,
          size: 20, padding: 20),
      Platform(
          id: 187,
          path: "assets/platforms/playstation_5.svg",
          active: userBloc.state.platforms.contains(187) ? true : false,
          size: 20, padding: 20),
      Platform(
          id: 19,
          path: "assets/platforms/playstation_vita.svg",
          active: userBloc.state.platforms.contains(19) ? true : false,
          size: 20, padding: 20),
      Platform(
          id: 9,
          active: userBloc.state.platforms.contains(9) ? true : false,
          path: "assets/platforms/nintendo_ds.svg",
          size: 20,
          padding: 20),
      Platform(
          id: 8,
          active: userBloc.state.platforms.contains(8) ? true : false,
          path: "assets/platforms/nintendo_3ds.svg",
          size: 20,
          padding: 20),
      Platform(
          id: 11,
          active: userBloc.state.platforms.contains(11) ? true : false,
          path: "assets/platforms/nintendo_wii.svg",
          size: 20,
          padding: 20),
      Platform(
          id: 10,
          active: userBloc.state.platforms.contains(10) ? true : false,
          path: "assets/platforms/nintendo_wiiu.svg",
          size: 20,
          padding: 20),
      Platform(
          id: 7,
          active: userBloc.state.platforms.contains(7) ? true : false,
          path: "assets/platforms/nintendo_switch.svg",
          size: 20, padding: 20),
      Platform(
          id: 14,
          active: userBloc.state.platforms.contains(14) ? true : false,
          path: "assets/platforms/xbox_360.svg",
          size: 20, padding: 20),
      Platform(
          id: 1,
          active: userBloc.state.platforms.contains(1) ? true : false,
          path: "assets/platforms/xbox_one.svg",
          size: 20, padding: 20),
      Platform(
          id: 186,
          active: userBloc.state.platforms.contains(186) ? true : false,
          path: "assets/platforms/xbox_series.svg",
          size: 20, padding: 20),
      Platform(
          id: 4,
          active: userBloc.state.platforms.contains(4) ? true : false,
          path: "assets/platforms/pc_2.svg",
          size: 20, padding: 20),
      Platform(
          id: 21,
          active: userBloc.state.platforms.contains(21) ? true : false,
          path: "assets/platforms/mobile.svg",
          size: 20, padding: 20)
    ];
    return platforms
        .map((item) => FadeIn(
            child: item.active
                ? Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: NeonPlatformButton(
                    platform: item,
                    onTap: () {
                        // widget.selectedPlatform = item.id;
                        // setState(() {});
                        context.push("/search_game", extra: item.id);
                      },
                      sizeMultiplier: 0.6
                    ),
                )
                : Container()))
        .toList();
  }
}

class NeonPlatformButton extends StatelessWidget {
  final Platform platform;
  final VoidCallback onTap;
  final double sizeMultiplier;

  const NeonPlatformButton({
    super.key,
    required this.platform,
    required this.onTap,
    this.sizeMultiplier = 0.8,
  });

  @override
  Widget build(BuildContext context) {
    final iconSize = (platform.size * MediaQuery.of(context).size.width) / 100 * sizeMultiplier;
    final baseNeonColor = _getPlatformColor(platform.id);
    
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        foregroundColor: baseNeonColor,
        padding: EdgeInsets.zero,
        
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22), // Menos redondeado que un círculo
          side: BorderSide(
            color: baseNeonColor.withValues(alpha: 0.7),
            width: 1.5,
          ),
        ),
        // elevation: 0,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: baseNeonColor.withValues(alpha: 0.3),
              blurRadius: 8.0,
              spreadRadius: 1.0,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.all(20),
              child: SvgPicture.asset(
                platform.path,
                height: iconSize,
                colorFilter: ColorFilter.mode(
                  Color.lerp(baseNeonColor, Colors.white, 0.6)!, // 60% blanco, 40% color neón
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Color _getPlatformColor(int platformId) {
    // Asignar colores neón según la plataforma
    switch (platformId) {
      case 4: // PC
        return const Color.fromARGB(255, 64, 255, 255); // Cian neón
      case 7: // Nintendo Switch
      case 8: // Nintendo 3DS
      case 9: // Nintendo DS
      case 10: // Nintendo WiiU
      case 11: // Nintendo Wii
        return const Color.fromARGB(255, 255, 45, 136); // Rosa neón
      case 14: // Xbox 360
      case 1: // Xbox One
      case 186: // Xbox Series
        return const Color.fromARGB(255, 48, 255, 131); // Verde neón
      case 15: // PlayStation 2
      case 16: // PlayStation 3
      case 18: // PlayStation 4
      case 187: // PlayStation 5
      case 17: // PlayStation Portable
      case 19: // PlayStation Vita
        return const Color.fromARGB(255, 56, 135, 255); // Azul neón
      case 21: // Smartphone
        return const Color.fromARGB(255, 255, 255, 52); // Amarillo neón
      default:
        return const Color(0xFFFFFFFF); // Blanco neón por defecto
    }
  }
}

