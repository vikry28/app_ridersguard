import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:app_riderguard/core/utils/extensions.dart';

class AppDateUtils {
  static String formatDate(DateTime date,
      {String pattern = 'dd MMM yyyy', String? locale}) {
    return DateFormat(pattern, locale).format(date);
  }

  static String formatDateTime(
    DateTime date, {
    String datePattern = 'dd MMM yyyy',
    String timePattern = 'HH:mm',
    String? locale,
  }) {
    final dateStr = DateFormat(datePattern, locale).format(date);
    final timeStr = DateFormat(timePattern, locale).format(date);
    return '$dateStr, $timeStr';
  }

  static String timeAgo(BuildContext context, DateTime date,
      {DateTime? reference}) {
    final now = reference ?? DateTime.now();
    final diff = now.difference(date);
    final lang = Localizations.localeOf(context).languageCode;

    if (lang == 'id') {
      if (diff.inSeconds < 60) return context.tr('just_now');
      if (diff.inMinutes < 60) {
        return '${diff.inMinutes} ${context.tr("minute_ago")}';
      }
      if (diff.inHours < 24) return '${diff.inHours} ${context.tr("hour_ago")}';
      if (diff.inDays < 7) return '${diff.inDays} ${context.tr("day_ago")}';
      if (diff.inDays < 30) {
        return '${(diff.inDays / 7).floor()} ${context.tr("week_ago")}';
      }
      if (diff.inDays < 365) {
        return '${(diff.inDays / 30).floor()} ${context.tr("month_ago")}';
      }
      return '${(diff.inDays / 365).floor()} ${context.tr("year_ago")}';
    } else {
      if (diff.inSeconds < 60) return context.tr('just_now');
      if (diff.inMinutes < 60) {
        return '${diff.inMinutes} ${context.tr("minute_ago")}';
      }
      if (diff.inHours < 24) return '${diff.inHours} ${context.tr("hour_ago")}';
      if (diff.inDays < 7) return '${diff.inDays} ${context.tr("day_ago")}';
      if (diff.inDays < 30) {
        return '${(diff.inDays / 7).floor()} ${context.tr("week_ago")}';
      }
      if (diff.inDays < 365) {
        return '${(diff.inDays / 30).floor()} ${context.tr("month_ago")}';
      }
      return '${(diff.inDays / 365).floor()} ${context.tr("year_ago")}';
    }
  }

  static String joinedAgo(BuildContext context, DateTime date) {
    return timeAgo(context, date);
  }

  static bool isToday(DateTime date) {
    final now = DateTime.now();
    return now.year == date.year &&
        now.month == date.month &&
        now.day == date.day;
  }

  static bool isYesterday(DateTime date) {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return date.year == yesterday.year &&
        date.month == yesterday.month &&
        date.day == yesterday.day;
  }
}
