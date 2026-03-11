import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../widgets/scaffold_with_navbar.dart';
import '../../features/home/screens/home_screen.dart';
import '../../features/events/screens/events_screen.dart';
import '../../features/announcements/screens/announcements_screen.dart';
import '../../features/menu/screens/menu_screen.dart';
import '../../features/events/screens/event_details_screen.dart';
import '../../features/events/screens/sub_events_details_screen.dart';
import '../../features/profile/screens/profile_screen.dart';
import '../../features/auth/screens/login_screen.dart';


// Navigator Keys for maintaining state across tabs
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorHomeKey = GlobalKey<NavigatorState>(debugLabel: 'homeTab');
final _shellNavigatorEventsKey = GlobalKey<NavigatorState>(debugLabel: 'eventsTab');
final _shellNavigatorAnnouncementsKey = GlobalKey<NavigatorState>(debugLabel: 'announcementsTab');
final _shellNavigatorMenuKey = GlobalKey<NavigatorState>(debugLabel: 'menuTab');

final appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/login',

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
              builder: (context, state) => const EventsScreen(), // <--- Update this line
            ),
          ],
        ),

        // BRANCH 3: ANNOUNCEMENTS
        StatefulShellBranch(
          navigatorKey: _shellNavigatorAnnouncementsKey,
          routes: [
            GoRoute(
              path: '/announcements',
                builder: (context, state) => const AnnouncementsScreen(),
            ),
          ],
        ),

        // BRANCH 4: MENU
        StatefulShellBranch(
          navigatorKey: _shellNavigatorMenuKey,
          routes: [
            GoRoute(
              path: '/menu',
              builder: (context, state) => const MenuScreen(), // Updated!
            ),
          ],
        ),
      ],
    ),

    // FULL-SCREEN ROUTES (No Bottom Nav Bar here)
    // LOGIN SCREEN
    GoRoute(
      path: '/login',
      name: 'login', // Adding a name is good practice for navigation
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const LoginPage(),
    ),

    // PROFILE SCREEN
    GoRoute(
      path: '/profile',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const ProfileScreen(),
    ),

    // NEW DETAILS ROUTE (WITH SLIDE-UP ANIMATION)
    GoRoute(
      path: '/event-details',
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: const EventDetailsScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Start from the bottom (Offset Y: 1.0) and slide to the center (Offset Y: 0.0)
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            // A smooth curve makes it feel natural, not robotic
            const curve = Curves.easeOutCubic;

            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        );
      },
    ),

    // SUB-EVENT / EXHIBIT DETAILS ROUTE
    GoRoute(
      path: '/sub-event-details/:type', // The ':type' variable grabs the word from the URL
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (context, state) {
        // Check the URL parameter to see if it's an exhibit
        final bool isExhibit = state.pathParameters['type'] == 'exhibit';

        return CustomTransitionPage(
          key: state.pageKey,
          child: SubEventDetailsScreen(isExhibit: isExhibit), // Pass it to the screen
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            const curve = Curves.easeOutCubic;
            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            return SlideTransition(position: animation.drive(tween), child: child);
          },
        );
      },
    ),

    // The QR Scanner will go here later with parentNavigatorKey: _rootNavigatorKey
  ],
);