import 'package:f_sing_and_learn/features/songs/screens/widgets/favorite_button.dart';
import 'package:f_sing_and_learn/shared/widgets/common_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../shared/routes/app_route_names.dart';
import '../../songs/providers/songs_providers.dart';
import '../../user/auth/providers/auth_provider.dart';

class SongListScreen extends ConsumerWidget {
  const SongListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final songsAsync = ref.watch(fetchSongListProvider);

    void showLoginAlert() {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('로그인 필요'),
          content: const Text('즐겨찾기 기능을 사용하려면 로그인이 필요합니다.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('취소'),
            ),
            TextButton(
              onPressed: () {
                // 로그인 화면으로 이동 (라우터 이름은 'login'으로 가정)
                Navigator.of(context).pop();
                context.pushNamed(AppRoute.login.name);
              },
              child: const Text('로그인'),
            ),
          ],
        ),
      );
    }

    return songsAsync.when(
      data: (songs) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomHeader(title: '곡 목록'),
          Expanded(
            child: ListView.builder(
              itemCount: songs.length,
              itemBuilder: (_, index) {
                final song = songs[index];
                return ListTile(
                  leading: const Icon(Icons.music_note),
                  title: Text(song.title),
                  subtitle: Text(song.singer),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FavoriteIconButton(
                        isFavorite: song.isFavorite,
                        onChanged: (isFavorite) async {
                          final authNotifier = ref.read(authProvider.notifier);
                          // 1. 로그인 여부 확인
                          if (!authNotifier.isLoggedIn()) {
                            showLoginAlert(); // 2. 로그인 안되어 있으면 Alert 창 표시
                            return;
                          }
                          try {
                            await ref
                                .read(favoriteTogglerProvider.notifier)
                                .toggleFavoriteStatus(song.id, song.isFavorite);
                          } catch (e) {
                            // 에러 발생 시 스낵바 표시
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('오류: ${e.toString()}')),
                            );
                          }
                        },
                      ),
                      const Icon(Icons.chevron_right),
                    ],
                  ),
                  onTap: () {
                    context.pushNamed(AppRoute.lyrics.name, extra: song);
                  },
                );
              },
            ),
          ),
        ],
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('에러: $e')),
    );
  }
}
