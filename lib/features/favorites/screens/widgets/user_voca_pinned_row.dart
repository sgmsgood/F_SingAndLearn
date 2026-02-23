import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'user_voca_filter_sheet.dart'; // VocaStatusFilter

class UserVocaPinnedRow extends StatelessWidget {
  final int total;
  final int unknown;
  final int known;

  final bool showSearch;
  final VocaStatusFilter filter;

  final VoidCallback onToggleSearch;
  final VoidCallback onOpenFilter;

  const UserVocaPinnedRow({
    super.key,
    required this.total,
    required this.unknown,
    required this.known,
    required this.showSearch,
    required this.filter,
    required this.onToggleSearch,
    required this.onOpenFilter,
  });

  String _filterLabel(VocaStatusFilter f) {
    switch (f) {
      case VocaStatusFilter.all:
        return '전체';
      case VocaStatusFilter.unknown:
        return '모름';
      case VocaStatusFilter.known:
        return '외움';
    }
  }

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return Row(
      children: [
        // ✅ summary
        Expanded(
          child: Row(
            children: [
              Flexible(
                child: Text(
                  '총 $total · 모름 $unknown · 외움 $known',
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: Colors.black54,
                    fontWeight: FontWeight.w700,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              // ✅ 현재 필터가 all이 아닐 때만 작은 pill 표시
              if (filter != VocaStatusFilter.all)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: primary.withOpacity(0.10),
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(color: primary.withOpacity(0.18)),
                  ),
                  child: Text(
                    _filterLabel(filter),
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w800,
                      color: primary,
                    ),
                  ),
                ),
            ],
          ),
        ),

        // ✅ search toggle
        IconButton(
          onPressed: onToggleSearch,
          tooltip: showSearch ? '검색 닫기' : '검색',
          icon: Icon(showSearch ? Icons.close : Icons.search),
        ),

        // ✅ filter bottomsheet
        IconButton(
          onPressed: onOpenFilter,
          tooltip: '필터',
          icon: const Icon(Icons.tune),
        ),
      ],
    );
  }
}