import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepository {
  final supabase = Supabase.instance.client;

  Future<void> loginWithGoogle() async {
    await supabase.auth.signInWithOAuth(OAuthProvider.google);
  }

  Future<void> logout() async {
    await supabase.auth.signOut();
  }
}