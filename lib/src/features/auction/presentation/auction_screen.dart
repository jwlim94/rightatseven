import 'package:flutter/material.dart';
import 'package:rightatseven/src/features/countdown/presentation/countdown_timer.dart';

class AuctionScreen extends StatelessWidget {
  const AuctionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: SafeArea(child: Column(children: [CountdownTimer()])));
  }
}
