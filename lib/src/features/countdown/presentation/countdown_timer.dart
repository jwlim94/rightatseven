import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:rightatseven/src/features/countdown/presentation/countdown_data_state_provider.dart';
import 'package:rightatseven/src/features/countdown/utils/countdown_duration_format.dart';
import 'package:rightatseven/src/shared/constants/enums.dart';

class CountdownTimer extends ConsumerWidget {
  const CountdownTimer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final countdown = ref.watch(countdownDataStateProvider);

    final remaining = CountdownDurationFormat.format(
      Duration(seconds: countdown.seconds),
    );
    final isActive = countdown.status == CountdownStatus.active;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isActive ? Colors.red[100] : Colors.blue[100],
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isActive ? Icons.flash_on : Icons.access_time,
            color: isActive ? Colors.red : Colors.blue,
          ),
          const SizedBox(width: 8),
          Text(
            isActive
                ? 'Auction ends in $remaining'
                : 'Next auction in $remaining',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: isActive ? Colors.red[800] : Colors.blue[800],
            ),
          ),
        ],
      ),
    );
  }
}
