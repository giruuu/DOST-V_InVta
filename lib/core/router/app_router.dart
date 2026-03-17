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
import '../../features/auth/screens/signup_page.dart';
import '../../features/auth/screens/step2_signup.dart';
import '../../features/auth/screens/step3_code_sent.dart';

// --- NEW IMPORTS FOR CHANGE PASSWORD FLOW ---
import '../../features/menu/screens/change_password_verify.dart';
import '../../features/menu/screens/change_password_new.dart';
import '../../features/menu/screens/change_password_success.dart';

// Navigator Keys for maintaining state across tabs
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorHomeKey = GlobalKey<NavigatorState>(debugLabel: 'homeTab');
final _shellNavigatorEventsKey = GlobalKey<NavigatorState>(debugLabel: 'eventsTab');
final _shellNavigatorAnnouncementsKey = GlobalKey<NavigatorState>(debugLabel: 'announcementsTab');
final _shellNavigatorMenuKey = GlobalKey<NavigatorState>(debugLabel: 'menuTab');

final appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/login',


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
              builder: (context, state) => const EventsScreen(),
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
              builder: (context, state) => const MenuScreen(),
            ),
          ],
        ),
      ],
    ),

    // ==========================================================
    // FULL-SCREEN ROUTES (No Bottom Nav Bar here)
    // ==========================================================

    // LOGIN SCREEN
    GoRoute(
      path: '/login',
      name: 'login',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const LoginPage(),
    ),

    // SIGN UP - STEP 1
    GoRoute(
      path: '/signup',
      name: 'signup',
      parentNavigatorKey: _rootNavigatorKey, // Keep it full-screen
      builder: (context, state) => const SignUpScreen(),
    ),

    // PROFILE SCREEN
    GoRoute(
      path: '/profile',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) {
        // Extract the image path, or default to profile_1 if something goes wrong
        final imagePath = state.extra as String? ?? 'assets/profiles/profile_1.jpg';
        return ProfileScreen(profileImagePath: imagePath);
      },
    ),

    // SIGN UP - STEP 2
    GoRoute(
      path: '/signup-password',
      name: 'signup-password',
      parentNavigatorKey: _rootNavigatorKey, // Ensures it covers the whole screen
      builder: (context, state) {
        // Safely extract the data passed via 'extra'
        final userData = state.extra as Map<String, dynamic>? ?? {};
        return SignUpPasswordScreen(userData: userData);
      },
    ),

    // SIGN UP - STEP 3
    GoRoute(
      path: '/signup-otc',
      name: 'signup-otc',
      parentNavigatorKey: _rootNavigatorKey, // Ensures it covers the whole screen
      builder: (context, state) {
        // Extract the combined data
        final userData = state.extra as Map<String, dynamic>? ?? {};
        return SignUpOTCPage(userData: userData);
      },
    ),

    // ----------------------------------------------------------
    // CHANGE PASSWORD FLOW
    // ----------------------------------------------------------
    GoRoute(
      path: '/change-password-verify',
      name: 'change-password-verify',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) {
        final email = state.extra as String? ?? 'your_email@gmail.com';
        return ChangePasswordVerifyScreen(email: email);
      },
    ),
    GoRoute(
      path: '/change-password-new',
      name: 'change-password-new',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const ChangePasswordNewScreen(),
    ),
    GoRoute(
      path: '/change-password-success',
      name: 'change-password-success',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const ChangePasswordSuccessScreen(),
    ),
    // ----------------------------------------------------------

    // NEW DETAILS ROUTE
    GoRoute(
      path: '/event-details',
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: const EventDetailsScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
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
      path: '/sub-event-details/:type',
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (context, state) {
        final bool isExhibit = state.pathParameters['type'] == 'exhibit';

        return CustomTransitionPage(
          key: state.pageKey,
          child: SubEventDetailsScreen(isExhibit: isExhibit),
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
  ],
);