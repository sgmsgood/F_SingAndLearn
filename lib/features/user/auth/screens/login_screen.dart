import 'package:f_sing_and_learn/features/user/auth/login_state.dart';
import 'package:f_sing_and_learn/features/user/auth/login_view_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../home/screens/home_screen.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginState = ref.watch(loginViewModelProvider);
    final loginViewModel = ref.read(loginViewModelProvider.notifier);

    // ✅ 여기서 상태 변화를 listen
    ref.listen<LoginState>(
      loginViewModelProvider,
          (previous, next) {
        next.maybeWhen(
          success: () {
            // build 중 바로 네비게이션 하면 경고 뜰 수 있어서 프레임 끝나고 실행
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (_) => const HomeScreen(),
                ),
              );
              // go_router 쓰면:
              // context.go('/home');
            });
          },
          orElse: () {},
        );
      },
    );

    return Scaffold(
      body: Center(
        child: loginState.when(
          initial: () => _LoginButton(onTap: loginViewModel.loginWithGoogle),
          loading: () => const CircularProgressIndicator(),
          // ✅ success일 때는 곧바로 Home으로 넘어갈 거라 화면은 비워 둠
          success: () => const SizedBox.shrink(),
          error: (message) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Login Error',
                style: TextStyle(color: Colors.red),
              ),
              const SizedBox(height: 12),
              _LoginButton(onTap: loginViewModel.loginWithGoogle),
            ],
          ),
        ),
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  final VoidCallback onTap;

  const _LoginButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        backgroundColor: Colors.pinkAccent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: const Text(
        "구글로 로그인",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}
