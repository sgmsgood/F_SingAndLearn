// features/auth/providers/auth_provider.dart

import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../songs/providers/songs_providers.dart';

part 'auth_provider.g.dart';

@riverpod
class Auth extends _$Auth {
  final _supabase = Supabase.instance.client;

  @override
  User? build() {
    // 1. 상태 변화를 감시하는 전용 스트림 구독
    final subscription = Supabase.instance.client.auth.onAuthStateChange.listen(
      (data) {
        final User? user = data.session?.user;

        if (data.event == AuthChangeEvent.signedIn ||
            data.event == AuthChangeEvent.signedOut) {
          // 즐겨찾기 스트림과 곡 목록을 초기화하여 새로 읽어오게 함
          ref.invalidate(favoriteIdsStreamProvider);

          print("🔄 Auth Event (${data.event}): Data Providers Invalidated");
        }

        if (state?.id != user?.id) {
          state = user;
        }
        // 로그인이 감지되면 즉시 state 업데이트
      },
    );

    ref.onDispose(() => subscription.cancel());
    return Supabase.instance.client.auth.currentUser;
  }

  Future<void> signInWithGoogle() async {
    try {
      await _supabase.auth.signInWithOAuth(
        OAuthProvider.google,
        redirectTo: 'sal://login-callback',
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }

  Future<void> deleteAccount() async {
    try {
      final session = _supabase.auth.currentSession;
      if (session == null) {
        throw Exception('로그인되지 않은 상태입니다.');
      }

      print('User ID: ${session.user.id}');
      print('Access Token exists: ${session.accessToken.isNotEmpty}');

      // 명시적으로 body에 빈 객체라도 전달
      final response = await _supabase.functions.invoke(
        'delete-user-account',
        method: HttpMethod.post,
        headers: {
          'Authorization': 'Bearer ${session.accessToken}',
        },
        body: {}, // 빈 body 추가
      );

      print('Response status: ${response.status}');
      print('Response data: ${response.data}');

      if (response.status == 200) {
        await signOut();
      } else {
        throw Exception('Failed: ${response.data}');
      }
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }
}
