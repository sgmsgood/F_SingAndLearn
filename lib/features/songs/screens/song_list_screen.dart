
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../shared/routes/app_route_names.dart';
import '../../songs/providers/songs_providers.dart';

class SongListScreen extends ConsumerWidget {
  const SongListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final songsAsync = ref.watch(songListProvider);

    return songsAsync.when(
      data: (songs) => ListView.builder(
        itemCount: songs.length,
        itemBuilder: (_, index) {
          final song = songs[index];
          return ListTile(
            leading: const Icon(Icons.music_note),
            title: Text(song.title),
            subtitle: Text(song.name),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              context.pushNamed(
                AppRoute.lyrics.name,
                extra: song,
              );
            },
          );
        },
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('에러: $e')),
    );
  }
}
