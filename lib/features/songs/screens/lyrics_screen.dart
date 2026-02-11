import 'package:mumu/features/songs/models/lyrics/lyric_word.dart';
import 'package:mumu/features/songs/models/lyrics/lyrics_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mumu/features/songs/models/song.dart';
import 'package:mumu/features/songs/providers/lyric_lines_provider.dart';
import 'package:mumu/features/songs/screens/widgets/favorite_button.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

final RouteObserver<PageRoute<dynamic>> routeObserver =
RouteObserver<PageRoute<dynamic>>();

class LyricsScreen extends ConsumerStatefulWidget {
  final Song song;

  const LyricsScreen({super.key, required this.song});

  @override
  ConsumerState<LyricsScreen> createState() => _LyricsScreenState();
}

class _LyricsScreenState extends ConsumerState<LyricsScreen> with RouteAware {
  late YoutubePlayerController _controller;

  // ✅ 1곡 반복(자동 재생) 토글
  bool _isLooping = false;

  // ✅ 유튜브 화면 접기/펴기
  bool _showPlayer = true;

  // 플레이어 준비 여부 + seek pending
  bool _playerReady = false;
  int? _pendingSeek;

  // FAB 토글용 (컨트롤러 value에서 갱신)
  bool _isPlaying = false;

  // 영상 ID 고정
  late final String _videoId;

  late final Widget _player;

  // ✅ 가사 자동 스크롤
  final ScrollController _scrollController = ScrollController();
  List<LyricsLine> _cachedLines = const [];
  int? _activeLineIndex;
  DateTime _lastAutoScrollAt = DateTime.fromMillisecondsSinceEpoch(0);
  bool _autoScrollEnabled = true;

  @override
  void initState() {
    super.initState();

    final parsed = YoutubePlayer.convertUrlToId(widget.song.youtubeLink);
    _videoId = (parsed != null && parsed.isNotEmpty) ? parsed : 'mlS3sgzxA8I';

    _controller = YoutubePlayerController(
      initialVideoId: _videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: false, // ✅ 자동 재생 막기
        mute: false,
      ),
    );

    _controller.addListener(_onControllerChanged);
    _controller.addListener(_preventFullscreen); // ✅ 전체화면 차단

    _player = AspectRatio(
      aspectRatio: 16 / 9,
      child: YoutubePlayer(
        key: const PageStorageKey('yt-player'),
        controller: _controller,
        showVideoProgressIndicator: true,
        onReady: () {
          _playerReady = true;
          if (_pendingSeek != null) {
            _jumpTo(_pendingSeek);
            _pendingSeek = null;
          }
        },
      ),
    );
  }

  void _preventFullscreen() {
    final v = _controller.value;
    if (v.isFullScreen) {
      _controller.toggleFullScreenMode();
    }
  }

  void _onControllerChanged() {
    final v = _controller.value;

    // ✅ 재생/일시정지 아이콘 동기화
    if (_isPlaying != v.isPlaying && mounted) {
      setState(() => _isPlaying = v.isPlaying);
    }

    // ✅ 1곡 반복(자동 재생): 영상 끝났을 때 다시 0초로
    if (_isLooping && v.playerState == PlayerState.ended) {
      _controller.seekTo(const Duration(seconds: 0), allowSeekAhead: true);
      _controller.play();
    }

    // ✅ 재생 위치 기반 자동 스크롤
    _maybeAutoScrollByPosition(v.position);
  }

  void _maybeAutoScrollByPosition(Duration position) {
    if (!_autoScrollEnabled) return;
    if (_cachedLines.isEmpty) return;
    if (!_scrollController.hasClients) return;
    if (!_controller.value.isPlaying) return; // 재생 중에만 따라가게

    final now = DateTime.now();
    if (now.difference(_lastAutoScrollAt).inMilliseconds < 500) return;

    final posSec = position.inSeconds;

    // timestamp 오름차순이라고 했으니 "posSec 이하인 가장 마지막 라인" 선택
    int idx = -1;
    for (int i = 0; i < _cachedLines.length; i++) {
      final ts = _cachedLines[i].playTimestamp;
      if (ts == null) continue;
      if (ts <= posSec) idx = i;
      if (ts != null && ts > posSec) break; // 오름차순 최적화
    }

    if (idx < 0) return;
    if (_activeLineIndex == idx) return;

    _activeLineIndex = idx;
    _lastAutoScrollAt = now;

    // UI 변경 없이 안전하게: 아이템 높이 대략치로 스크롤
    const double approxItemExtent = 150; // 필요시 130~180 사이로 미세 조정
    final targetOffset = (idx * approxItemExtent).clamp(
      0.0,
      _scrollController.position.maxScrollExtent,
    );

    _scrollController.animateTo(
      targetOffset,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    _controller.removeListener(_onControllerChanged);
    _controller.removeListener(_preventFullscreen);
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  // ✅ 특정 초로 이동 (지금은 load 유지)
  void _jumpTo(int? sec) {
    if (sec == null) return;
    if (sec < 0) sec = 0;

    if (!_playerReady) {
      _pendingSeek = sec;
      return;
    }

    _controller.load(_videoId, startAt: sec);
  }

  // ✅ FAB 재생/일시정지 토글
  void _togglePlayPause() {
    if (!_playerReady) return;

    if (_controller.value.isPlaying) {
      _controller.pause();
    } else {
      _controller.play();
    }
  }

  // ✅ 1곡 반복 토글
  void _toggleLooping() {
    setState(() => _isLooping = !_isLooping);
  }

  // ✅ 유튜브 화면 접기/펴기
  void _togglePlayerVisibility() {
    setState(() => _showPlayer = !_showPlayer);
  }

  // 단어 상세 모달 (그대로)
  void _showWordDetail(BuildContext context, LyricsWord word) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        ),
        padding: const EdgeInsets.fromLTRB(28, 12, 28, 40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 45,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  word.text,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -1,
                    color: Color(0xFF4A4A4A),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  "[ ${word.pinyin} ]",
                  style: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).colorScheme.primary,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFF8F0F5),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "뜻",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.7),
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    word.meaning,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black87,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final lyricsAsync = ref.watch(lyricLinesProvider(widget.song.id));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          widget.song.title,
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
        ),
        actions: [
          IconButton(
            onPressed: _toggleLooping,
            icon: Icon(
              _isLooping ? Icons.repeat_one_rounded : Icons.repeat_one_outlined,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: FavoriteIconButton(
              isFavorite: widget.song.isFavorite,
              onChanged: (val) {},
            ),
          ),
        ],
      ),

      // ✅ FAB 2개: 위(유튜브 숨김/표시), 아래(재생/일시정지)
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
            ),
          ),
          const SizedBox(height: 12),
          FloatingActionButton(
            heroTag: 'fab_play_pause',
            onPressed: _togglePlayPause,
            child: Icon(
              _isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
            ),
          ),
        ],
      ),

      body: Column(
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: _togglePlayerVisibility,
            child: AnimatedCrossFade(
              duration: const Duration(milliseconds: 200),
              crossFadeState: _showPlayer
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              firstChild: _player,
              secondChild: const SizedBox.shrink(),
            ),
          ),
          Expanded(
            child: lyricsAsync.when(
              data: (lines) {
                _cachedLines = lines; // ✅ 자동 스크롤용 캐시

                return ListView.builder(
                  controller: _scrollController, // ✅ 자동 스크롤 대상
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                  itemCount: lines.length,
                  itemBuilder: (context, index) {
                    final line = lines[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 24, 52, 24),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildClickableLine(context, line),
                                const SizedBox(height: 12),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 4,
                                  ),
                                  child: Text(
                                    line.pinyin,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.black45,
                                      fontStyle: FontStyle.italic,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF1D6E4)
                                        .withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    line.translation,
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: const Color(0xFF5E35B1)
                                          .withOpacity(0.7),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            top: 12,
                            right: 12,
                            child: IconButton(
                              icon: const Icon(Icons.play_arrow_outlined),
                              color: const Color(0xFFD1C4E9),
                              onPressed: () {
                                _jumpTo(line.playTimestamp);
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, _) => Center(child: Text('에러 발생: $err')),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClickableLine(BuildContext context, LyricsLine line) {
    final String fullText = line.lineLyrics;
    final List<LyricsWord> words = line.words;
    final sortedWords = [...words]
      ..sort((a, b) => a.startSpan.compareTo(b.startSpan));

    List<InlineSpan> spans = [];
    int lastIndex = 0;

    for (final word in sortedWords) {
      if (word.startSpan > lastIndex) {
        spans.add(TextSpan(text: fullText.substring(lastIndex, word.startSpan)));
      }

      spans.add(
        WidgetSpan(
          alignment: PlaceholderAlignment.middle,
          child: GestureDetector(
            onTap: () => _showWordDetail(context, word),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 4),
              margin: const EdgeInsets.symmetric(horizontal: 1, vertical: 3),
              decoration: BoxDecoration(
                color: word.isImportant
                    ? const Color(0xFFD1C4E9).withOpacity(0.5)
                    : const Color(0xFFF1D6E4).withOpacity(0.4),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                fullText.substring(word.startSpan, word.endSpan),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  height: 1.0,
                  color: word.isImportant
                      ? const Color(0xFF5E35B1)
                      : Colors.black87,
                ),
              ),
            ),
          ),
        ),
      );

      lastIndex = word.endSpan;
    }

    if (lastIndex < fullText.length) {
      spans.add(TextSpan(text: fullText.substring(lastIndex)));
    }

    return RichText(
      text: TextSpan(
        style: const TextStyle(
          fontSize: 18,
          color: Colors.black87,
          height: 1.8,
        ),
        children: spans,
      ),
    );
  }
}
