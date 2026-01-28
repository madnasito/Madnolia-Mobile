import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:madnolia/models/platform/platform_icon_model.dart';

class AtomNeonPlatformButton extends StatelessWidget {
  final PlatformIconModel platform;
  final VoidCallback onTap;
  final double sizeMultiplier;

  const AtomNeonPlatformButton({
    super.key,
    required this.platform,
    required this.onTap,
    this.sizeMultiplier = 0.8,
  });

  @override
  Widget build(BuildContext context) {
    final iconSize =
        (platform.size * MediaQuery.of(context).size.width) /
        100 *
        sizeMultiplier;
    final baseNeonColor = _getPlatformColor(platform.id);

    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        foregroundColor: baseNeonColor,
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22),
          side: BorderSide(
            color: baseNeonColor.withValues(alpha: 0.7),
            width: 1.5,
          ),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: baseNeonColor.withValues(alpha: 0.3),
              blurRadius: 8.0,
              spreadRadius: 1.0,
            ),
          ],
        ),
        padding: const EdgeInsets.all(20),
        child: SvgPicture.asset(
          platform.path,
          height: iconSize,
          colorFilter: ColorFilter.mode(
            Color.lerp(baseNeonColor, Colors.white, 0.6)!,
            BlendMode.srcIn,
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
