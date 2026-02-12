import 'package:flutter/material.dart';
import 'package:mumu/features/home/screens/edit_profile_screen.dart';
import 'package:mumu/features/user/auth/screens/login_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:mumu/features/home/screens/home_screen.dart';
import 'package:mumu/features/songs/models/song.dart';
import 'package:mumu/features/songs/screens/lyrics_screen.dart';
import 'app_route_names.dart';

// RouteObserver를 여기서 정의합니다.
final RouteObserver<PageRoute<dynamic>> routeObserver = RouteObserver<PageRoute<dynamic>>();

final router = GoRouter(
  // 앱 켜면 바로 /home
  initialLocation: '/',
  observers: [routeObserver], // 이제 routeObserver를 정상적으로 찾을 수 있습니다.
  routes: [
    GoRoute(
      path: '/',
      name: AppRoute.home.name,
      builder: (context, state) => const HomeScreen(),
      redirect: (context, state) {
        // login-callback으로 시작하면 홈으로
        if (state.uri.path.startsWith('/login-callback')) {
          return '/';
        }
        return null;
      },
      // /home 아래에 lyrics 붙이기 → /home/lyrics
      routes: [
        GoRoute(
          path: 'lyrics', // 맨 앞에 /를 제거하여 상대 경로로 만듭니다.
          name: AppRoute.lyrics.name,
          builder: (context, state) {
            final song = state.extra as Song;
            return LyricsScreen(song: song);
          },
        ),
        GoRoute(
          path: 'login-callback',
          redirect: (context, state) {
            // OAuth 콜백은 Supabase가 자동 처리하므로
            // 그냥 홈으로 리다이렉트
            return '/';
          },
        ),
        GoRoute(
          path: 'login',
          name: AppRoute.login.name,
          builder: (context, state) {
            return const LoginScreen();
          },
        ),
        GoRoute(
          path: 'editProfile',
          name: AppRoute.editProfile.name,
          builder: (context, state) {
            return const EditProfileScreen();
          },
        ),
      ],
    ),
  ],
);
