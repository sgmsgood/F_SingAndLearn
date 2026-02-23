import 'package:flutter/material.dart';

class FoldablePinnedHeader extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;

  /// childBuilder receives t (0 펼침 ~ 1 접힘)
  final Widget Function(BuildContext context, double t) builder;

  FoldablePinnedHeader({
    required this.minHeight,
    required this.maxHeight,
    required this.builder,
  });

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final bg = Theme.of(context).scaffoldBackgroundColor;
    final range = (maxExtent - minExtent);
    final t = range <= 0 ? 1.0 : (shrinkOffset / range).clamp(0.0, 1.0);

    return Material(
      color: bg,
      elevation: overlapsContent ? 4 : 0,
      shadowColor: Colors.black.withOpacity(0.08),
      child: builder(context, t),
    );
  }

  @override
  bool shouldRebuild(covariant FoldablePinnedHeader old) {
    return old.minHeight != minHeight || old.maxHeight != maxHeight;
  }
}