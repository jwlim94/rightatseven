import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rightatseven/src/features/auction/presentation/auction_screen.dart';
import 'package:rightatseven/src/features/authentication/data/auth_repository.dart';
import 'package:rightatseven/src/features/chat/presentation/chat_screen.dart';
import 'package:rightatseven/src/features/market/presentation/market_screen.dart';
import 'package:rightatseven/src/features/notification/presentation/notification_screen.dart';
import 'package:rightatseven/src/features/user/presentation/profile_screen.dart';
import 'package:rightatseven/src/routing/app_startup.dart';
import 'package:rightatseven/src/routing/providers/app_startup_state_provider.dart';
import 'package:rightatseven/src/routing/utils/extra_codec.dart';
import 'package:rightatseven/src/routing/utils/go_router_refresh_stream.dart';
import 'package:rightatseven/src/routing/utils/scaffold_with_nested_navigation.dart';
import 'package:rightatseven/src/shared/constants/enums.dart';
import 'package:rightatseven/src/shared/constants/keys.dart';
import 'package:rightatseven/src/shared/constants/strings.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'go_router_state_provider.g.dart';

@riverpod
GoRouter goRouterState(Ref ref) {
  final appStartupState = ref.watch(appStartupStateProvider);
  final authRepository = ref.watch(authRepositoryProvider);

  return GoRouter(
    initialLocation: Strings.auctionPath,
    extraCodec: const ExtraCodec(),
    debugLogDiagnostics: true,
    navigatorKey: Keys.rootNavigatorKey,
    redirect: (context, state) {
      // Show splash screen while the app is initializing
      if (appStartupState.isLoading || appStartupState.hasError) {
        return Strings.startupPath;
      }

      // Add silently signin and signout redirects here...

      return null;
    },
    refreshListenable: GoRouterRefreshStream(authRepository.authStateChanges()),
    routes: [
      GoRoute(
        path: Strings.startupPath,
        name: AppRoute.startup.name,
        pageBuilder:
            (context, state) => const NoTransitionPage(child: AppStartup()),
      ),
      // Add more routes here...
      StatefulShellRoute.indexedStack(
        parentNavigatorKey: Keys.rootNavigatorKey,
        pageBuilder:
            (context, state, navigationShell) => NoTransitionPage(
              child: ScaffoldWithNestedNavigation(
                navigationShell: navigationShell,
              ),
            ),
        branches: [
          StatefulShellBranch(
            navigatorKey: Keys.auctionNavigatorKey,
            routes: [
              GoRoute(
                path: Strings.auctionPath,
                name: AppRoute.auction.name,
                pageBuilder: (context, state) {
                  return const NoTransitionPage(child: AuctionScreen());
                },
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: Keys.marketNavigatorKey,
            routes: [
              GoRoute(
                path: Strings.marketPath,
                name: AppRoute.market.name,
                pageBuilder: (context, state) {
                  return const NoTransitionPage(child: MarketScreen());
                },
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: Keys.chatNavigatorKey,
            routes: [
              GoRoute(
                path: Strings.chatPath,
                name: AppRoute.chat.name,
                pageBuilder: (context, state) {
                  return const NoTransitionPage(child: ChatScreen());
                },
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: Keys.notificationNavigatorKey,
            routes: [
              GoRoute(
                path: Strings.notificationPath,
                name: AppRoute.notification.name,
                pageBuilder: (context, state) {
                  return const NoTransitionPage(child: NotificationScreen());
                },
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: Keys.profileNavigatorKey,
            routes: [
              GoRoute(
                path: Strings.profilePath,
                name: AppRoute.profile.name,
                pageBuilder: (context, state) {
                  return const NoTransitionPage(child: ProfileScreen());
                },
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
