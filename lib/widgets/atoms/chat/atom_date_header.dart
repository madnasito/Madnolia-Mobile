import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:madnolia/i18n/strings.g.dart';

class AtomDateHeader extends StatelessWidget {
  final DateTime date;

  const AtomDateHeader({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 16),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.black45,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          _formatDate(date),
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final messageDate = DateTime(date.year, date.month, date.day);

    if (messageDate == today) {
      return t.CHAT.TODAY; // Ensure you have this key or fallback
    } else if (messageDate == yesterday) {
      return t.CHAT.YESTERDAY; // Ensure you have this key or fallback
    } else {
      return DateFormat.yMMMMd(
        LocaleSettings.currentLocale.languageCode,
      ).format(date);
    }
  }
}
