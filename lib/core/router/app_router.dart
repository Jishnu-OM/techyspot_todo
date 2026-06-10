import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:techyspot_todo/core/router/route_names.dart';
import 'package:techyspot_todo/features/authentication/presentation/screens/login_screen.dart';
import 'package:techyspot_todo/features/home/presentation/screens/home_screen.dart';
import 'package:techyspot_todo/features/home/presentation/screens/logout_screen.dart';

class AppRouter {
  static final _router = GoRouter(
    initialLocation: RouteNames.login,
    redirect: (context, state) {
      final user = Supabase.instance.client.auth.currentUser;
      final isLoginRoute = state.matchedLocation == RouteNames.login;
      if (user == null) {
        return isLoginRoute ? null : RouteNames.login;
      }

      if (isLoginRoute) {
        return RouteNames.home;
      }

      return null;
    },
    routes: [
      GoRoute(
        path: RouteNames.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: RouteNames.home,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: RouteNames.logout,
        builder: (context, state) => const LogoutScreen(),
      ),
    ],
  );

  static GoRouter get router => _router;
}
