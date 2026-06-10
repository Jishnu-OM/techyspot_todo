import 'package:go_router/go_router.dart';
import 'package:techyspot_todo/core/router/route_names.dart';
import 'package:techyspot_todo/features/authentication/presentation/screens/login_screen.dart';
import 'package:techyspot_todo/features/home/presentation/screens/home_screen.dart';

class AppRouter {
  static final _router = GoRouter(
    initialLocation: RouteNames.login,
    routes: [
      GoRoute(
        path: RouteNames.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: RouteNames.home,
        builder: (context, state) => const HomeScreen(),
      ),
    ],
  );

  static GoRouter get router => _router;
}
