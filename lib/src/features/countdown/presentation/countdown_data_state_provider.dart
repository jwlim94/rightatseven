import 'dart:async';

import 'package:rightatseven/src/features/countdown/domain/countdown_data.dart';
import 'package:rightatseven/src/features/countdown/utils/auction_schedule.dart';
import 'package:rightatseven/src/shared/constants/enums.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'countdown_data_state_provider.g.dart';

@Riverpod(keepAlive: true)
class CountdownDataState extends _$CountdownDataState {
  @override
  CountdownData build() {
    final now = DateTime.now();
    final initial = _calculateCountdown(now);
    _startCountdown();
    return initial;
  }

  Timer? _timer;

  void stopCountDown() {
    _timer?.cancel();
  }

  void _startCountdown() {
    if (_timer?.isActive ?? false) return;

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      final now = DateTime.now();
      state = _calculateCountdown(now);
    });
  }

  CountdownData _calculateCountdown(DateTime now) {
    if (AuctionSchedule.isAuctionActive(now)) {
      final end = DateTime(
        now.year,
        now.month,
        now.day,
        AuctionSchedule.startHour,
      ).add(AuctionSchedule.duration);

      return CountdownData(
        status: CountdownStatus.active,
        seconds: end.difference(now).inSeconds,
      );
    } else {
      final next = AuctionSchedule.getNextAuctionTime(now);
      return CountdownData(
        status: CountdownStatus.idle,
        seconds: next.difference(now).inSeconds,
      );
    }
  }
}
