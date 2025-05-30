import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rightatseven/src/shared/constants/app_colors.dart';
import 'package:rightatseven/src/shared/constants/strings.dart';
import 'package:rightatseven/src/shared/constants/text_styles.dart';

class ScaffoldWithNestedNavigation extends StatelessWidget {
  const ScaffoldWithNestedNavigation({Key? key, required this.navigationShell})
    : super(key: key ?? const ValueKey('ScaffoldWithNestedNavigation'));

  final StatefulNavigationShell navigationShell;

  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      // A common pattern when using bottom navigation bars is to support
      // navigating to the initial location when tapping the item that is
      // already active. This example demonstrates how to support this behavior,
      // using the initialLocation parameter of goBranch.
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.flash_on_outlined),
              label: Strings.auctionTab,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.loop_rounded),
              label: Strings.marketTab,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.chat_outlined),
              label: Strings.chatTab,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.notifications_outlined),
              label: Strings.notificationTab,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.person_2_outlined),
              label: Strings.profileTab,
            ),
          ],
          currentIndex: navigationShell.currentIndex,
          enableFeedback: false,
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: TextStyles.bodyExtraSmall,
          unselectedLabelStyle: TextStyles.bodyExtraSmall,
          selectedItemColor: AppColors.appBlack,
          onTap: _goBranch,
        ),
      ),
    );
  }
}
