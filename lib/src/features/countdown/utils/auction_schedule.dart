class AuctionSchedule {
  static const List<int> weekdays = [DateTime.wednesday, DateTime.saturday];
  static const int startHour = 19;
  static const int durationInMinutes = 60;

  static Duration get duration => Duration(minutes: durationInMinutes);

  static bool isAuctionDay(DateTime date) {
    return weekdays.contains(date.weekday);
  }

  static bool isAuctionActive(DateTime now) {
    if (!isAuctionDay(now)) return false;
    final start = DateTime(now.year, now.month, now.day, startHour);
    final end = start.add(duration);
    return now.isAfter(start) && now.isBefore(end);
  }

  static DateTime getNextAuctionTime(DateTime now) {
    for (int i = 0; i < 7; i++) {
      final candidate = now.add(Duration(days: i));
      final isToday = i == 0;

      if (isAuctionDay(candidate)) {
        final auctionTime = DateTime(
          candidate.year,
          candidate.month,
          candidate.day,
          startHour,
        );
        if (auctionTime.isAfter(now)) return auctionTime;
        if (isToday && now.isBefore(auctionTime)) return auctionTime;
      }
    }
    // fallback
    return now.add(Duration(days: 3));
  }
}
