import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubePlayerSection extends StatelessWidget {
  final YoutubePlayerController controller;

  final bool visible;
  final VoidCallback onToggleVisible;

  final bool isLooping;
  final VoidCallback onToggleLoop;

  const YoutubePlayerSection({
    super.key,
    required this.controller,
    required this.visible,
    required this.onToggleVisible,
    required this.isLooping,
    required this.onToggleLoop,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onToggleVisible,
          child: AnimatedCrossFade(
            duration: const Duration(milliseconds: 200),
            crossFadeState:
            visible ? CrossFadeState.showFirst : CrossFadeState.showSecond,
            firstChild: YoutubePlayer(
              controller: controller,
              showVideoProgressIndicator: true,
              progressIndicatorColor: Colors.purple,
              progressColors: const ProgressBarColors(
                playedColor: Colors.purple,
                handleColor: Colors.purpleAccent,
              ),
            ),
            secondChild: const SizedBox.shrink(),
          ),
        ),
        if (visible) ...[
          SizedBox(height: 16.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [_buildLoopButton()],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildLoopButton() {
    return InkWell(
      onTap: onToggleLoop,
      borderRadius: BorderRadius.circular(20.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          border: Border.all(
            color: isLooping ? Colors.purple : Colors.grey,
            width: 1.r,
          ),
          borderRadius: BorderRadius.circular(20.r),
          color: isLooping ? Colors.purple.withOpacity(0.1) : Colors.transparent,
        ),
        child: Row(
          children: [
            Icon(
              Icons.loop,
              size: 20.sp,
              color: isLooping ? Colors.purple : Colors.grey,
            ),
            SizedBox(width: 6.w),
            Text(
              '1곡 반복',
              style: TextStyle(
                fontSize: 14.sp,
                color: isLooping ? Colors.purple : Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
