import 'package:go_router/go_router.dart';
import 'package:myplans_app/feature/auth/widget/auth_screen.dart';

import '../../feature/home/widget/home_screen.dart';

class AppRouter {
  final router = GoRouter(
    initialLocation: "/",
    routes: [
      GoRoute(
        path: "/",
        builder: (context, _) => const AuthScreen(),
      ),
      GoRoute(
        path: "/home",
        builder: (context, _) => const HomeScreen(),
      )
    ],
  );
}
