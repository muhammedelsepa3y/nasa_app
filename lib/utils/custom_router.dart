import 'package:go_router/go_router.dart';
import 'package:nasa_app/UI/screens/news_screen.dart';
import 'package:nasa_app/utils/route_constants.dart';

import '../UI/screens/home.dart';
import '../UI/screens/settings_screen.dart';



class AppRouter {
  final GoRouter router = GoRouter(
    initialLocation: "/",
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (context, state) => const Home(),
      ),
      GoRoute(
        path: settingsRoute,
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: news,
        builder: (context, state) => const NewsScreen(),
      ),
    ],
    errorBuilder: (context, state) => const Home(),
  );
}