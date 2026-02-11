import 'package:flutter/services.dart';
import 'package:mumu/shared/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await Supabase.initialize(
    url: 'https://wgawogfdkzpqrwauoqwk.supabase.co',
    anonKey: 'sb_publishable_xILU46K1NOVsdXCGg_TK2Q_ZTgzwtHf',
    authOptions: const FlutterAuthClientOptions(
      authFlowType: AuthFlowType.pkce,
    ),
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
        scaffoldBackgroundColor: Color.lerp(
          const Color(0xFFF1D6E4), // 원래 연분홍
          Colors.white,           // 흰색
          0.4,                    // 50% 비율로 섞음 (숫자가 커질수록 흰색에 가까워짐)
        ),
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
