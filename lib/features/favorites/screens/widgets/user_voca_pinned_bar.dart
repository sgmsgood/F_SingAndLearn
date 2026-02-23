import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserVocaPinnedBar extends StatelessWidget {
  final int total;
  final int unknown;
  final int known;

  final bool showSearch;
  final TextEditingController searchController;

  final VoidCallback onToggleSearch;
  final VoidCallback onOpenFilter;

  const UserVocaPinnedBar({
    super.key,
    required this.total,
    required this.unknown,
    required this.known,
    required this.showSearch,
    required this.searchController,
    required this.onToggleSearch,
    required this.onOpenFilter,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
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
            IconButton(
              onPressed: onToggleSearch,
              tooltip: showSearch ? '검색 닫기' : '검색',
              icon: Icon(showSearch ? Icons.close : Icons.search),
            ),
            IconButton(
              onPressed: onOpenFilter,
              tooltip: '필터',
              icon: const Icon(Icons.tune),
            ),
          ],
        ),
        // Search 영역은 delegate가 fold시킴 (여기선 그냥 항상 렌더 가능)
        Padding(
          padding: EdgeInsets.only(top: 8.h),
          child: _SearchPill(controller: searchController),
        ),
      ],
    );
  }
}

class _SearchPill extends StatelessWidget {
  final TextEditingController controller;
  const _SearchPill({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF6F6F6),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.black.withOpacity(0.06)),
      ),
      child: TextField(
        controller: controller,
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search),
          suffixIcon: controller.text.isEmpty
              ? null
              : IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => controller.clear(),
          ),
          hintText: '단어 / 병음 / 뜻 검색',
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        ),
      ),
    );
  }
}