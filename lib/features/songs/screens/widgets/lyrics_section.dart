import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../providers/lyric_lines_provider.dart';
import '../../models/lyrics/lyrics_line.dart';
import 'lyrics_card.dart';

class LyricsSection extends ConsumerStatefulWidget {
  final String songId;
  final YoutubePlayerController controller;
  final ValueChanged<int> onLineTap;

  const LyricsSection({
    super.key,
    required this.songId,
    required this.controller,
    required this.onLineTap,
  });

  @override
  ConsumerState<LyricsSection> createState() => _LyricsSectionState();
}

class _LyricsSectionState extends ConsumerState<LyricsSection> {
  final ScrollController _scrollController = ScrollController();

  List<LyricsLine> _cachedLines = const [];

  bool _autoScrollEnabled = true;
  bool _autoScrollTemporarilySuspended = false;
  Timer? _resumeTimer;
  static const Duration _suspendDuration = Duration(seconds: 4);

  bool _programmaticScrolling = false;

  int? _activeIndex;
  DateTime _lastAutoScrollAt = DateTime.fromMillisecondsSinceEpoch(0);

  final Map<int, GlobalKey> _lineKeys = {};

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onPlayerChanged);
    _scrollController.addListener(_onUserScroll);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onPlayerChanged);
    _scrollController.removeListener(_onUserScroll);
    _resumeTimer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  void _onPlayerChanged() {
    if (!_autoScrollEnabled) return;
    if (!mounted) return;

    final v = widget.controller.value;
    if (!v.isPlaying) return;

    _maybeAutoScrollByPosition(v.position);
  }

  void _onUserScroll() {
    if (!_autoScrollEnabled) return;
    if (!_scrollController.hasClients) return;
    if (_programmaticScrolling) return;

    final dir = _scrollController.position.userScrollDirection;
    if (dir == ScrollDirection.idle) return;

    _autoScrollTemporarilySuspended = true;

    _resumeTimer?.cancel();
    _resumeTimer = Timer(_suspendDuration, () {
      if (!mounted) return;
      _autoScrollTemporarilySuspended = false;

      _maybeAutoScrollByPosition(widget.controller.value.position, force: true);
    });
  }

  void _maybeAutoScrollByPosition(Duration position, {bool force = false}) {
    if (_autoScrollTemporarilySuspended && !force) return;
    if (!_scrollController.hasClients) return;
    if (_cachedLines.isEmpty) return;

    final now = DateTime.now();
    if (!force && now.difference(_lastAutoScrollAt).inMilliseconds < 350) return;

    final posSec = position.inSeconds;

    int idx = -1;
    for (int i = 0; i < _cachedLines.length; i++) {
      final ts = _cachedLines[i].playTimestamp;
      if (ts <= posSec) idx = i;
      if (ts > posSec) break;
    }
    if (idx < 0) return;

    final changed = _activeIndex != idx;
    _activeIndex = idx;
    _lastAutoScrollAt = now;

    if (changed && mounted) setState(() {});

    if (force || changed) {
      _scrollToIndexExact(idx);
    }
  }

  Future<void> _scrollToIndexExact(int index) async {
    final key = _lineKeys[index];
    final ctx = key?.currentContext;
    if (ctx == null) return;

    _programmaticScrolling = true;
    try {
      await Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 320),
        curve: Curves.easeOut,
        alignment: 0.25,
      );
    } finally {
      Future.delayed(const Duration(milliseconds: 80), () {
        _programmaticScrolling = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final lyricsAsync = ref.watch(lyricLinesProvider(widget.songId));

    return lyricsAsync.when(
      data: (lines) {
        _cachedLines = lines;

        final valid = <int>{};
        for (int i = 0; i < lines.length; i++) {
          valid.add(i);
          _lineKeys.putIfAbsent(i, () => GlobalKey());
        }
        _lineKeys.removeWhere((k, _) => !valid.contains(k));

        return ListView.separated(
          controller: _scrollController,
          padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 24.h),
          itemCount: lines.length,
          separatorBuilder: (context, index) => SizedBox(height: 8.h),
          itemBuilder: (context, index) {
            final isActive = _activeIndex == index;

            return Container(
              key: _lineKeys[index],
              child: LyricLineCard(
                line: lines[index],
                onLineTap: widget.onLineTap,
                isActive: isActive,
              ),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, _) => Center(child: Text('에러 발생: $err')),
    );
  }
}
