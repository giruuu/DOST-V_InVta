import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../widgets/scaffold_with_navbar.dart';
import '../../features/home/screens/home_screen.dart';

// Navigator Keys for maintaining state across tabs
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorHomeKey = GlobalKey<NavigatorState>(debugLabel: 'homeTab');
final _shellNavigatorEventsKey = GlobalKey<NavigatorState>(debugLabel: 'eventsTab');
final _shellNavigatorAnnouncementsKey = GlobalKey<NavigatorState>(debugLabel: 'announcementsTab');
final _shellNavigatorMenuKey = GlobalKey<NavigatorState>(debugLabel: 'menuTab');

final appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/home',

  // TODO: Add redirect logic later for Laravel Sanctum/Token checks

  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return ScaffoldWithNavBar(navigationShell: navigationShell);
      },
      branches: [
        // BRANCH 1: HOME (Now using the actual HomeScreen widget)
        StatefulShellBranch(
          navigatorKey: _shellNavigatorHomeKey,
          routes: [
            GoRoute(
              path: '/home',
              builder: (context, state) => const HomeScreen(),
            ),
          ],
        ),

        // BRANCH 2: EVENTS
        StatefulShellBranch(
          navigatorKey: _shellNavigatorEventsKey,
          routes: [
            GoRoute(
              path: '/events',
              // Placeholder: Will be replaced by EventsScreen() soon
              builder: (context, state) => const Scaffold(body: Center(child: Text('Event List Screen'))),
            ),
          ],
        ),

        // BRANCH 3: ANNOUNCEMENTS
        StatefulShellBranch(
          navigatorKey: _shellNavigatorAnnouncementsKey,
          routes: [
            GoRoute(
              path: '/announcements',
              builder: (context, state) => const Scaffold(body: Center(child: Text('Announcements Feed'))),
            ),
          ],
        ),

        // BRANCH 4: MENU
        StatefulShellBranch(
          navigatorKey: _shellNavigatorMenuKey,
          routes: [
            GoRoute(
              path: '/menu',
              builder: (context, state) => const Scaffold(body: Center(child: Text('Menu & Points Screen'))),
            ),
          ],
        ),
      ],
    ),

    // FULL-SCREEN ROUTES (No Bottom Nav Bar here)
    GoRoute(
      path: '/login',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const Scaffold(body: Center(child: Text('Login Screen'))),
    ),

    // The QR Scanner will go here later with parentNavigatorKey: _rootNavigatorKey
  ],
);