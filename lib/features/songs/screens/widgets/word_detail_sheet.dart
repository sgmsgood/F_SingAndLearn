import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../models/lyrics/lyric_word.dart';
import '../../providers/save_voca_providers.dart';

class WordDetailSheet extends ConsumerStatefulWidget {
  final LyricsWord word;

  const WordDetailSheet({required this.word, super.key});

  @override
  ConsumerState<WordDetailSheet> createState() => _WordDetailSheetState();
}

class _WordDetailSheetState extends ConsumerState<WordDetailSheet> {
  final _supabase = Supabase.instance.client;
  bool _isBusy = false;

  Future<void> _toggleFavorite(bool isCurrentlySaved) async {
    final user = _supabase.auth.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('즐겨찾기는 로그인 후 사용할 수 있어요.')),
      );
      return;
    }

    if (_isBusy) return;

    setState(() => _isBusy = true);

    try {
      // ✅ Riverpod provider를 통해 상태 변경 (Optimistic Update 지원됨)
      await ref.read(savedVocaProvider.notifier).toggle(widget.word.wordId);
      
      if (mounted) {
        final message = isCurrentlySaved ? '내 단어에서 제거했어요.' : '내 단어에 추가했어요.';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message), duration: const Duration(seconds: 1)),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('처리 실패: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isBusy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    // ✅ 전역 상태(savedVocaProvider)를 구독
    final savedAsync = ref.watch(savedVocaProvider);
    final isSaved = savedAsync.value?.contains(widget.word.wordId) ?? false;
    final isLoading = savedAsync.isLoading && !savedAsync.hasValue;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32.r)),
      ),
      padding: EdgeInsets.fromLTRB(28.w, 12.h, 28.w, 40.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 45.w,
              height: 5.h,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
          ),
          SizedBox(height: 30.h),
          if (isLoading)
            const Center(child: CircularProgressIndicator())
          else
            _buildContent(isSaved),
        ],
      ),
    );
  }

  Widget _buildContent(bool isSaved) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      widget.word.text,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -1,
                        color: const Color(0xFF4A4A4A),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Flexible(
                    child: Text(
                      "[ ${widget.word.pinyin} ]",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 18.sp,
                        color: Theme.of(context).colorScheme.primary,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: _isBusy ? null : () => _toggleFavorite(isSaved),
              tooltip: isSaved ? '내 단어에서 제거' : '내 단어에 추가',
              icon: _isBusy
                  ? SizedBox(
                      width: 20.w,
                      height: 20.w,
                      child: const CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Icon(isSaved ? Icons.bookmark : Icons.bookmark_border),
              color: isSaved ? Theme.of(context).colorScheme.primary : Colors.black54,
            ),
          ],
        ),
        SizedBox(height: 20.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(20.r),
          decoration: BoxDecoration(
            color: const Color(0xFFF8F0F5),
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "뜻",
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.7),
                  letterSpacing: 1.2,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                widget.word.meaning,
                style: TextStyle(
                  fontSize: 20.sp,
                  color: Colors.black87,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
