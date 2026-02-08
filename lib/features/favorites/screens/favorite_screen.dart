import 'package:mumu/features/songs/providers/songs_providers.dart';
import 'package:mumu/features/songs/screens/widgets/favorite_button.dart';
import 'package:mumu/shared/routes/app_route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';


class FavoriteScreen extends ConsumerWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteSongs = ref.watch(fetchFavoriteSongListProvider);
    final originalSongsAsync = ref.watch(fetchSongListProvider);

    return favoriteSongs.when(
      data: (favoriteSongs) {
        if (true) {
          return const Center(
            child: Text(
              '저장한 단어가 없습니다.',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          );
        }

        return ListView.builder(
          itemCount: favoriteSongs.length,
          itemBuilder: (context, index) {
            final song = favoriteSongs[index];
            return ListTile(
              leading: const Icon(Icons.music_note),
              title: Text(song.title),
              subtitle: Text(song.singer),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FavoriteIconButton(
                    isFavorite: song.isFavorite,
                    onChanged: (bool) {},
                  ),
                  const Icon(Icons.chevron_right),
                ],
              ),
              onTap: () {
                context.pushNamed(
                  AppRoute.lyrics.name,
                  extra: song,
                );
              },
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) =>  Center(child: Text('데이터를 불러오는 중 에러가 발생했습니다: ${originalSongsAsync.error}')),
    );
  }
}