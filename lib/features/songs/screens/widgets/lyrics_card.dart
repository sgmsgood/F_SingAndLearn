import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mumu/features/songs/screens/widgets/clickable_word_card.dart';
import '../../models/lyrics/lyrics_line.dart';

class LyricLineCard extends StatelessWidget {
  final LyricsLine line;
  final ValueChanged<int> onLineTap;
  final bool isActive;

  const LyricLineCard({
    super.key,
    required this.line,
    required this.onLineTap,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    final border = isActive
        ? Border.all(
      color: const Color(0xFF5E35B1).withOpacity(0.35),
      width: 1.6.r,
    )
        : Border.all(color: Colors.transparent, width: 1.6.r);

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        border: border,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isActive ? 0.07 : 0.04),
            blurRadius: (isActive ? 14 : 10).r,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(20.w, 24.h, 52.w, 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClickableWordCard(line: line),
                SizedBox(height: 12.h),
                Text(
                  line.pinyin,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: isActive ? Colors.black54 : Colors.black45,
                    fontStyle: FontStyle.italic,
                    letterSpacing: 0.5,
                  ),
                ),
                SizedBox(height: 8.h),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1D6E4).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    line.translation,
                    style: TextStyle(
                      fontSize: 15.sp,
                      color: const Color(0xFF5E35B1)
                          .withOpacity(isActive ? 0.85 : 0.7),
                      fontWeight:
                      isActive ? FontWeight.w600 : FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 10.h,
            right: 10.w,
            child: IconButton(
              icon: Icon(Icons.play_arrow_rounded, size: 24.sp),
              color: isActive
                  ? const Color(0xFF5E35B1).withOpacity(0.85)
                  : const Color(0xFFD1C4E9),
              onPressed: () => onLineTap(line.playTimestamp),
            ),
          ),
        ],
      ),
    );
  }
}
