import 'dart:ui';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:madnolia/i18n/strings.g.dart';
import 'package:madnolia/enums/match-status.enum.dart';
import 'package:madnolia/models/match/match_with_game_model.dart';
import 'package:flutter/material.dart';
import 'package:madnolia/utils/platforms.dart';
import 'package:madnolia/widgets/atoms/media/game_image_atom.dart';
import 'package:intl/intl.dart';

class GameCard extends StatelessWidget {
  final String name;
  final String? background;
  final Widget bottom;
  const GameCard({
    super.key,
    required this.name,
    required this.background,
    required this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black45,
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.only(bottom: 10, top: 2),
      child: Column(
        children: [
          AtomGameImage(name: name, background: background),
          bottom,
        ],
      ),
    );
  }
}

class MatchCard extends StatelessWidget {
  final MatchWithGame data;

  const MatchCard({super.key, required this.data});
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

  @override
  Widget build(BuildContext context) {
    // Define un color y un texto basado en el estado del match
    Color statusColor;
    String statusText;

    switch (data.match.status) {
      case MatchStatus.waiting:
        statusColor = Colors.amberAccent; // Color para "en espera"
        statusText = t.MATCH.STATUS.WAITING;
        break;
      case MatchStatus.running:
        statusColor = Colors.greenAccent; // Color para "en curso"
        statusText = t.MATCH.STATUS.RUNNING;
        break;
      case MatchStatus.finished:
        statusColor = Colors.blueGrey; // Color para "terminado"
        statusText = t.MATCH.STATUS.FINISHED;
        break;
      case MatchStatus.cancelled:
        statusColor = Colors.redAccent; // Color para "cancelado"
        statusText = t.MATCH.STATUS.CANCELLED;
        break;
    }

    final platformInfo = getPlatformInfo(data.match.platform.id);
    final platformColor = _getPlatformColor(data.match.platform.id);
    final platformIcon = Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: platformColor.withValues(alpha: 0.3),
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
            padding: const EdgeInsets.all(8),
            child: SvgPicture.asset(
              platformInfo.path,
              height: 15,
              colorFilter: ColorFilter.mode(
                Color.lerp(platformColor, Colors.white, 0.6)!,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
      ),
    );
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black45,
            blurRadius: 5,
            offset: const Offset(0, 3), // Sombra hacia abajo
          ),
        ],
      ),
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AtomGameImage(
            name: data.game.name,
            background: data.game.background,
            child: platformIcon,
          ),
          const SizedBox(height: 10),
          Text(
            data.match.title,
            style: const TextStyle(
              color: Colors.cyanAccent,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            DateFormat(
              'EEEE, d MMMM yyyy - hh:mm a',
              LocaleSettings.currentLocale.languageCode,
            ).format(data.match.date),
            style: const TextStyle(color: Colors.white70, fontSize: 14),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 6),
            decoration: BoxDecoration(
              color: statusColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black45,
                  blurRadius: 5,
                  offset: Offset(0, 3), // Sombra hacia abajo
                ),
              ],
            ),
            child: Text(
              statusText,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
