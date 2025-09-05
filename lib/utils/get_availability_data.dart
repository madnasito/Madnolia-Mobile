import 'package:flutter/material.dart';
import 'package:madnolia/enums/user-availability.enum.dart';

IconData getIconForAvailability(UserAvailability availability) {
  switch (availability) {
    case UserAvailability.everyone: // Asumiendo que uno de tus options.name es 'available'
      return Icons.check_circle_outline;
    case UserAvailability.partners: // Asumiendo que tienes 'friendsOnly'
      return Icons.group_outlined;
    case UserAvailability.no: // Asumiendo que tienes 'doNotDisturb'
      return Icons.do_not_disturb_on_outlined;
  }
}

Color getColorForAvailability(UserAvailability availability) {
  switch (availability) {
    case UserAvailability.everyone:
      return Colors.green;
    case UserAvailability.partners:
      return Colors.blueAccent;
    case UserAvailability.no:
      return Colors.red;
  }
}