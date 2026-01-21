// features/auth/providers/auth_provider.dart

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_provider.g.dart';

@riverpod
class Auth extends _$Auth {
  final _supabase = Supabase.instance.client;

  @override
  User? build() {
    // Supabase의 로그인 상태 변경을 감지하여 상태를 업데이트합니다.
    _supabase.auth.onAuthStateChange.listen((data) {
      state = data.session?.user;
    });
    // 초기 상태는 현재 로그인된 사용자 정보입니다.
    return _supabase.auth.currentUser;
  }

  /// 현재 로그인된 사용자가 있는지 확인합니다.
  bool isLoggedIn() {
    return state != null;
  }

  /// 구글로 로그인
  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      await _supabase.auth.signInWithOAuth(
        OAuthProvider.google,
        // context: context,
      );
    } catch (e) {
      // 에러 처리 (예: 스낵바 표시)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('로그인 중 에러가 발생했습니다: $e')),
      );
    }
  }

  /// 로그아웃
  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }
}