import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:techyspot_todo/core/router/route_names.dart';
import 'package:techyspot_todo/core/widgets/buttons/primary_button.dart';
import 'package:techyspot_todo/features/authentication/presentation/providers/auth_provider.dart';

class LogoutScreen extends ConsumerWidget {
  const LogoutScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            context.pop();
          },
          child: Icon(Icons.arrow_back),
        ),
      ),
      body: Center(
        child: PrimaryButton(
          text: 'Logout',
          onPressed: () async {
            await ref.read(authProvider.notifier).logout();
            context.go(RouteNames.login);
          },
        ),
      ),
    );
  }
}
