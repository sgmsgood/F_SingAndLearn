import 'package:f_sing_and_learn/features/user/auth/screens/login_screen.dart';
import 'package:f_sing_and_learn/shared/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'features/home/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://wgawogfdkzpqrwauoqwk.supabase.co',
    anonKey: 'sb_publishable_xILU46K1NOVsdXCGg_TK2Q_ZTgzwtHf',
  );

  runApp(const ProviderScope(child: SingAndLearnApp()));
}

class SingAndLearnApp extends ConsumerWidget {
  const SingAndLearnApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = Supabase.instance.client.auth.onAuthStateChange;

    const Color lightPurple = Color(0xFFD1C4E9);
    const Color lightPink = Color(0xFFF1D6E4);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: lightPurple,
          brightness: Brightness.light, // 밝은 테마
        ).copyWith(secondary: lightPink, onSecondary: Colors.white),
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: lightPink, // 배경색을 연분홍으로 지정
          indicatorColor: lightPurple, // 선택된 아이템의 인디케이터 색상을 진한 분홍으로 지정
        ),
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}
