
import 'package:f_sing_and_learn/features/user/auth/login_state.dart' show LoginState;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import 'auth_repository.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository();
});

final loginViewModelProvider =
StateNotifierProvider<LoginViewModel, LoginState>((ref) {
  return LoginViewModel(ref.read(authRepositoryProvider));
});

class LoginViewModel extends StateNotifier<LoginState> {
  final AuthRepository _repository;

  LoginViewModel(this._repository) : super(const LoginState.initial());

  Future<void> loginWithGoogle() async {
    state = const LoginState.loading();
    try {
      await _repository.loginWithGoogle();

      // 여기서 success 처리하지 않는다.
      //TODO:: 로그인 결과는 Supabase의 auth state listener가 처리해야 함.
      state = const LoginState.success();
    } catch (e) {
      state = LoginState.error(e.toString());
    }
  }
}
