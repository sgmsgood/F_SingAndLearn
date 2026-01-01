import 'package:go_router/go_router.dart';
import 'package:f_sing_and_learn/features/home/screens/home_screen.dart';
import 'package:f_sing_and_learn/features/songs/models/song.dart';
import 'package:f_sing_and_learn/features/songs/screens/lyrics_screen.dart';
import 'app_route_names.dart';

final router = GoRouter(
  // 앱 켜면 바로 /home
  initialLocation: '/home',
  observers: [routeObserver],
  routes: [
    GoRoute(
      path: '/home',
      name: AppRoute.home.name,
      builder: (context, state) => const HomeScreen(),

      // /home 아래에 lyrics 붙이기 → /home/lyrics
      routes: [
        GoRoute(
          path: 'lyrics',
          name: AppRoute.lyrics.name,
          builder: (context, state) {
            final song = state.extra as Song;
            return LyricsScreen(song: song);
          },
        ),
      ],
    ),
  ],
);
