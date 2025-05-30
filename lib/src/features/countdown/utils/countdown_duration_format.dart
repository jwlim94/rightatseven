class CountdownDurationFormat {
  /// Formats a Duration to:
  /// - `1d 03h 45m` if ≥ 1 day
  /// - `03:45:12` if < 1 day
  static String format(Duration duration) {
    final days = duration.inDays;
    final hours = duration.inHours.remainder(24);
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);

    if (days > 0) {
      return '${days}d ${_twoDigits(hours)}h ${_twoDigits(minutes)}m';
    } else {
      return '${_twoDigits(hours)}:${_twoDigits(minutes)}:${_twoDigits(seconds)}';
    }
  }

  static String _twoDigits(int n) => n.toString().padLeft(2, '0');
}
