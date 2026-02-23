import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mumu/features/favorites/screens/widgets/user_voca_pinned_row.dart';

import '../domain/voca_status.dart';
import '../providers/user_voca_provider.dart';

// 분리된 위젯/유틸
import 'widgets/pinned_bar_delegate.dart';      // FoldablePinnedHeader
import 'widgets/user_voca_filter_sheet.dart';   // openVocaFilterSheet, VocaStatusFilter // UserVocaPinnedRow
import 'widgets/voca_list_card.dart';           // VocaCard (너 프로젝트에 맞게)

enum VocaSort { recent, oldest }

class UserVocaScreen extends ConsumerStatefulWidget {
  const UserVocaScreen({super.key});

  @override
  ConsumerState<UserVocaScreen> createState() => _UserVocaScreenState();
}

class _UserVocaScreenState extends ConsumerState<UserVocaScreen> {
  final _searchController = TextEditingController();

  bool showSearch = false;
  VocaStatusFilter filter = VocaStatusFilter.all;
  VocaSort sort = VocaSort.recent;
  String query = '';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() => query = _searchController.text.trim());
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _toggleSearch() {
    setState(() {
      showSearch = !showSearch;
      if (!showSearch) {
        _searchController.clear();
        query = '';
      }
    });
  }

  Future<void> _openFilter(BuildContext context) async {
    final picked = await openVocaFilterSheet(
      context,
      current: filter,
    );
    if (picked != null) setState(() => filter = picked);
  }

  @override
  Widget build(BuildContext context) {
    final vocaAsync = ref.watch(fetchUserVocaListProvider);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('내 단어'),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(text: '리스트'),
              Tab(text: '테스트'),
            ],
          ),
          actions: [
            PopupMenuButton<VocaSort>(
              icon: const Icon(Icons.sort),
              onSelected: (v) => setState(() => sort = v),
              itemBuilder: (_) => const [
                PopupMenuItem(value: VocaSort.recent, child: Text('최근 추가 순')),
                PopupMenuItem(value: VocaSort.oldest, child: Text('오래된 순')),
              ],
            ),
          ],
        ),
        body: TabBarView(
          children: [
            // ======================
            // ✅ 리스트 탭
            // ======================
            vocaAsync.when(
              data: (items) {
                if (items.isEmpty) {
                  return _EmptyState(
                    onRefresh: () => ref.invalidate(fetchUserVocaListProvider),
                  );
                }

                final counts = _count(items);
                final filtered = _apply(items);

                // ✅ 헤더 높이는 "검색 여부"에 따라만 결정
                final minH = 60.h;
                final maxH = showSearch ? 116.h : 60.h;

                return RefreshIndicator(
                  onRefresh: () async => ref.invalidate(fetchUserVocaListProvider),
                  child: CustomScrollView(
                    slivers: [
                      // ✅ Foldable pinned header (방법 A)
                      SliverPersistentHeader(
                        pinned: true,
                        delegate: FoldablePinnedHeader(
                          minHeight: minH,
                          maxHeight: maxH,
                          builder: (context, t) {
                            // t: 0(펼침) ~ 1(완전 접힘)
                            final searchVisible = showSearch && t < 0.98;

                            return Container(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // ✅ 요약 + 아이콘들 (Row만)
                                  SizedBox(
                                    height: 44.h,
                                    child: UserVocaPinnedRow(
                                      total: items.length,
                                      unknown: counts.unknown,
                                      known: counts.known,
                                      showSearch: showSearch,
                                      filter: filter,
                                      onToggleSearch: _toggleSearch,
                                      onOpenFilter: () => _openFilter(context),
                                    ),
                                  ),

                                  // ✅ 검색바: screen에서만 렌더 + fold/clip
                                  ClipRect(
                                    child: Align(
                                      alignment: Alignment.topCenter,
                                      heightFactor: searchVisible
                                          ? (1.0 - t).clamp(0.0, 1.0)
                                          : 0.0,
                                      child: Padding(
                                        padding: EdgeInsets.only(top: 8.h),
                                        child: _SearchPill(controller: _searchController),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),

                      // ✅ 리스트 영역
                      if (filtered.isEmpty)
                        SliverFillRemaining(
                          hasScrollBody: false,
                          child: Center(
                            child: Text(
                              '조건에 맞는 단어가 없어요.',
                              style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                            ),
                          ),
                        )
                      else
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                                (context, index) {
                              final item = filtered[index];

                              return Padding(
                                padding: EdgeInsets.fromLTRB(
                                  16.w,
                                  index == 0 ? 10.h : 6.h,
                                  16.w,
                                  6.h,
                                ),
                                child: VocaCard(
                                  item: item,
                                  onToggleStatus: () async {
                                    await ref.read(userVocaActionsProvider).toggleStatus(item);

                                    if (!context.mounted) return;
                                    final nextLabel = item.status.toggle().label;
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('상태를 "$nextLabel"로 변경했어요.')),
                                    );
                                  },
                                  onDelete: () async {
                                    final ok = await _confirmDelete(context);
                                    if (!ok) return;

                                    await ref.read(userVocaActionsProvider).remove(item.wordId);

                                    if (!context.mounted) return;
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('내 단어에서 제거했어요.')),
                                    );
                                  },
                                ),
                              );
                            },
                            childCount: filtered.length,
                          ),
                        ),

                      SliverToBoxAdapter(child: SizedBox(height: 18.h)),
                    ],
                  ),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text('내 단어를 불러오지 못했어요: $e'),
                ),
              ),
            ),

            // ======================
            // ✅ 테스트 탭 (placeholder)
            // ======================
            const Center(
              child: Text(
                '단어 테스트 준비중 🙂',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _Counts _count(List<UserVocaItem> items) {
    int u = 0, k = 0;
    for (final it in items) {
      if (it.status == VocaStatus.unknown) u++;
      if (it.status == VocaStatus.known) k++;
    }
    return _Counts(unknown: u, known: k);
  }

  List<UserVocaItem> _apply(List<UserVocaItem> items) {
    Iterable<UserVocaItem> list = items;

    // filter
    if (filter != VocaStatusFilter.all) {
      list = list.where((e) {
        if (filter == VocaStatusFilter.unknown) return e.status == VocaStatus.unknown;
        if (filter == VocaStatusFilter.known) return e.status == VocaStatus.known;
        return true;
      });
    }

    // search
    if (query.isNotEmpty) {
      final q = query.toLowerCase();
      list = list.where((e) =>
      e.text.toLowerCase().contains(q) ||
          e.pinyin.toLowerCase().contains(q) ||
          e.meaning.toLowerCase().contains(q));
    }

    // sort
    final result = list.toList();
    result.sort((a, b) {
      return switch (sort) {
        VocaSort.recent => b.createdAt.compareTo(a.createdAt),
        VocaSort.oldest => a.createdAt.compareTo(b.createdAt),
      };
    });

    return result;
  }
}

class _Counts {
  final int unknown;
  final int known;
  _Counts({required this.unknown, required this.known});
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

class _EmptyState extends StatelessWidget {
  final VoidCallback onRefresh;
  const _EmptyState({required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        SizedBox(height: 120.h),
        const Center(
          child: Text(
            '저장한 단어가 없습니다.',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ),
        SizedBox(height: 12.h),
        Center(
          child: Text(
            '가사에서 단어를 눌러 “내 단어”에 추가해보세요.',
            style: TextStyle(fontSize: 13.sp, color: Colors.grey),
          ),
        ),
        SizedBox(height: 30.h),
        Center(
          child: TextButton(
            onPressed: onRefresh,
            child: const Text('새로고침'),
          ),
        ),
      ],
    );
  }
}

Future<bool> _confirmDelete(BuildContext context) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('삭제할까요?'),
      content: const Text('내 단어에서 제거됩니다.'),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('취소')),
        TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('삭제')),
      ],
    ),
  );
  return result ?? false;
}