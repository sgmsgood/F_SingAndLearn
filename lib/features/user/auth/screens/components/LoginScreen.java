import 'package:mumu/shared/routes/app_route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';

import '../providers/auth_provider.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

    @override
    Widget build(BuildContext context, WidgetRef ref) {
        return Scaffold(
                appBar: AppBar(title: const Text('로그인')),
        body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
        SupaSocialsAuth(
                socialProviders: [
        OAuthProvider.google,
            ],
        colored: true,
                redirectUrl: 'sal://login-callback',
                onSuccess: (Session response) {
            print("@!!-->> response:: $response");
            context.pushNamed(AppRoute.home.name);
        },
        onError: (error) {},
          ),
        ],
      ),
    );
    }
}
