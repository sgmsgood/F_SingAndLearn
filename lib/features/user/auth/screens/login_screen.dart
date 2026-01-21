import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/auth_provider.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('로그인')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            ref.read(authProvider.notifier).signInWithGoogle(context);
          },
          child: const Text('Google로 로그인'),
        ),
      ),
    );
  }
}