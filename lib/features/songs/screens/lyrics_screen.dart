import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mumu/features/songs/screens/widgets/favorite_button.dart';
import 'package:mumu/features/songs/screens/widgets/lyrics_section.dart';
import 'package:mumu/features/songs/screens/widgets/youtube_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../models/song.dart';

class LyricsScreen extends ConsumerStatefulWidget {
  final Song song;

  const LyricsScreen({super.key, required this.song});

  @override
  ConsumerState<LyricsScreen> createState() => _LyricsScreenState();
}

class _LyricsScreenState extends ConsumerState<LyricsScreen> {
  late YoutubePlayerController _controller;

  bool _isLooping = false;
  bool _showPlayer = true;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();

    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.song.youtubeLink) ?? '',
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );

    _controller.addListener(_onControllerChanged);
  }

  void _onControllerChanged() {
    final v = _controller.value;

    if (_isPlaying != v.isPlaying && mounted) {
      setState(() => _isPlaying = v.isPlaying);
    }

    if (_isLooping && v.playerState == PlayerState.ended) {
      _controller.seekTo(const Duration(seconds: 0), allowSeekAhead: true);
      _controller.play();
    }

    if (v.isFullScreen) {
      _controller.toggleFullScreenMode();
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_onControllerChanged);
    _controller.dispose();
    super.dispose();
  }

  void _toggleLooping() {
    setState(() => _isLooping = !_isLooping);
  }

  void _seekToTimestamp(int timestamp) {
    _controller.seekTo(Duration(seconds: timestamp), allowSeekAhead: true);
  }

  void _togglePlayerVisibility() {
    setState(() => _showPlayer = !_showPlayer);
  }

  void _togglePlayPause() {
    if (_controller.value.isPlaying) {
      _controller.pause();
    } else {
      _controller.play();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          widget.song.title,
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.sp),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 8.w),
            child: FavoriteIconButton(
              isFavorite: widget.song.isFavorite,
              onChanged: (val) {},
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            heroTag: 'fab_toggle_player',
            onPressed: _togglePlayerVisibility,
            child: Icon(
              _showPlayer
                  ? Icons.visibility_off_rounded
                  : Icons.visibility_rounded,
              size: 24.sp,
            ),
          ),
          SizedBox(height: 12.h),
          FloatingActionButton(
            heroTag: 'fab_play_pause',
            onPressed: _togglePlayPause,
            child: Icon(
              _isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
              size: 24.sp,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          YoutubePlayerSection(
            controller: _controller,
            visible: _showPlayer,
            onToggleVisible: _togglePlayerVisibility,
            isLooping: _isLooping,
            onToggleLoop: _toggleLooping,
          ),
          Expanded(
            child: LyricsSection(
              songId: widget.song.id,
              controller: _controller,
              onLineTap: _seekToTimestamp,
            ),
          ),
        ],
      ),
    );
  }
}
