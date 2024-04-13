import 'package:derbymatch/features/auth/screens/login_screen.dart';
import 'package:derbymatch/features/court/screens/court_detail_screen.dart';
import 'package:derbymatch/features/court/screens/court_list_screen.dart';
import 'package:derbymatch/features/match/screens/create_match_screen.dart';
import 'package:derbymatch/features/onboarding/screens/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

import '../../../features/main/screens/main_screen.dart';
import '../../../features/player/screens/player_detail_screen.dart';
import '../../../features/profile/screens/create_user_profile_screen.dart';
import '../../../features/splashscreen/screens/splash_screen.dart';
import '../../../features/team/screens/create_team_onboarding_screen.dart';
import '../../../features/team/screens/create_team_screen.dart';
import '../../../features/team/screens/team_detail_screen.dart';

final loadingRoute = RouteMap(routes: {
  '/': (_) => MaterialPage(child: SplashScreen()),
});
final loggedOutRoute = RouteMap(
  onUnknownRoute: (routeData) => Redirect('/'),
  routes: {
    '/': (_) => MaterialPage(child: OnboardingScreen()),
    '/login': (_) => MaterialPage(child: LoginScreen()),
  },
);
//
final loggedInRoute = RouteMap(
  onUnknownRoute: (routeData) => Redirect('/'),
  routes: {
    '/': (_) => MaterialPage(
          child: MainScreen(),
        ),
    '/createUserProfile': (_) => MaterialPage(
          child: CreateUserProfileScreen(),
        ),
    '/player/:user_id': (_) => MaterialPage(
          child: PlayerDetailScreen(),
        ),
    '/createTeamOnboarding': (_) => MaterialPage(
          child: CreateTeamOnboardingScreen(),
        ),
    '/createTeam': (_) => MaterialPage(
          child: CreateTeamScreen(),
        ),
    '/team/:team_id': (_) => MaterialPage(
          child: TeamDetailScreen(),
        ),
    '/court/search': (_) => MaterialPage(
          child: CourtListScreen(),
        ),
    '/court/:court_id': (_) => MaterialPage(
          child: CourtDetailScreen(),
        ),
    '/createMatch': (_) => MaterialPage(
          child: CreateMatchScreen(),
        ),
    //   '/create-community': (_) =>
    //       const MaterialPage(child: CreateCommunityScreen()),
    //   '/r/:name': (route) => MaterialPage(
    //         child: CommunityScreen(
    //           name: route.pathParameters['name']!,
    //         ),
    //       ),
    //   '/mod-tools/:name': (routeData) => MaterialPage(
    //         child: ModToolsScreen(
    //           name: routeData.pathParameters['name']!,
    //         ),
    //       ),
    //   '/edit-community/:name': (routeData) => MaterialPage(
    //         child: EditCommunityScreen(
    //           name: routeData.pathParameters['name']!,
    //         ),
    //       ),
    //   '/add-mods/:name': (routeData) => MaterialPage(
    //         child: AddModsScreen(
    //           name: routeData.pathParameters['name']!,
    //         ),
    //       ),
    //   '/u/:uid': (routeData) => MaterialPage(
    //         child: UserProfileScreen(
    //           uid: routeData.pathParameters['uid']!,
    //         ),
    //       ),
    //   '/edit-profile/:uid': (routeData) => MaterialPage(
    //         child: EditProfileScreen(
    //           uid: routeData.pathParameters['uid']!,
    //         ),
    //       ),
    //   '/add-post/:type': (routeData) => MaterialPage(
    //         child: AddPostTypeScreen(
    //           type: routeData.pathParameters['type']!,
    //         ),
    //       ),
    //   '/post/:postId/comments': (route) => MaterialPage(
    //         child: CommentsScreen(
    //           postId: route.pathParameters['postId']!,
    //         ),
    //       ),
    //   '/add-post': (routeData) => const MaterialPage(
    //         child: AddPostScreen(),
    //       ),
  },
);
