import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 즐겨찾기 토글 버튼 (상태에 따라 색/아이콘 변경)
class FavoriteIconButton extends StatelessWidget {
  const FavoriteIconButton({
    super.key,
    required this.isFavorite,
    required this.onChanged,
    this.size = 24,
    this.activeColor = Colors.red,
    this.inactiveColor = Colors.grey,
    this.splashRadius = 32,
    this.tooltip = '즐겨찾기',
  });

  final bool isFavorite;
  final ValueChanged<bool> onChanged;

  final double size;
  final Color activeColor;
  final Color inactiveColor;
  final double splashRadius;
  final String tooltip;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: tooltip,
      splashRadius: splashRadius.r,
      onPressed: () => onChanged(!isFavorite),
      icon: AnimatedSwitcher(
        duration: const Duration(milliseconds: 160),
        switchInCurve: Curves.easeOut,
        switchOutCurve: Curves.easeIn,
        transitionBuilder: (child, anim) =>
            ScaleTransition(scale: anim, child: child),
        child: Icon(
          isFavorite ? Icons.favorite : Icons.favorite_border,
          key: ValueKey(isFavorite),
          size: size.sp,
          color: isFavorite ? activeColor : inactiveColor,
        ),
      ),
    );
  }
}
