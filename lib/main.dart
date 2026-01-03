
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



    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pinkAccent),
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}



