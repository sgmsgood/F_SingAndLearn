import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // ✅ 추가

import '../../../shared/routes/app_route_names.dart';
import '../../user/auth/providers/auth_provider.dart';
import '../providers/songs_providers.dart';

class SongListScreen extends ConsumerStatefulWidget {
  const SongListScreen({super.key});

  @override
  ConsumerState<SongListScreen> createState() => _SongListScreenState();
}

class _SongListScreenState extends ConsumerState<SongListScreen> {
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_isSearching && _scrollController.offset > 20.h) { // ✅ 20 -> 20.h
      FocusManager.instance.primaryFocus?.unfocus();
      setState(() {
        _isSearching = false;
        _searchController.clear();
      });
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final songsAsync = ref.watch(fetchSongListProvider);
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final double searchBarHeight = 60.h; // ✅ 60.0 -> 60.h

    return Scaffold(
      backgroundColor: Colors.white,
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                pinned: true,
                floating: true,
                snap: true,
                elevation: 0,
                backgroundColor: const Color(0xFFF8EAF1),
                surfaceTintColor: Colors.transparent,
                expandedHeight: _isSearching
                    ? (kToolbarHeight + searchBarHeight)
                    : kToolbarHeight,
                centerTitle: false,
                title: Text(
                  "곡 목록",
                  style: TextStyle(
                    fontSize: 22.sp, // ✅ 22 -> 22.sp
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                actions: const [
                  // const SizedBox(width: 10.w),
                ],
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(_isSearching ? searchBarHeight : 0),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOutCubic,
                    height: _isSearching ? searchBarHeight : 0,
                    child: _isSearching
                        ? Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w, // ✅ 20 -> 20.w
                        vertical: 8.h,   // ✅ 8 -> 8.h
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.r), // ✅ 12 -> 12.r
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10.r, // ✅ 10 -> 10.r
                              offset: Offset(0, 4.h), // ✅ (0,4) -> (0,4.h)
                            ),
                          ],
                        ),
                        child: TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            hintText: "곡명, 가수 검색",
                            prefixIcon: Icon(
                              Icons.search,
                              size: 20.sp, // ✅ 20 -> 20.sp
                              color: Colors.grey,
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 10.h, // ✅ 10 -> 10.h
                            ),
                          ),
                          onChanged: (val) => setState(() {}),
                        ),
                      ),
                    )
                        : const SizedBox.shrink(),
                  ),
                ),
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: _SliverAppBarDelegate(
                  statusBarHeight: statusBarHeight,
                  tabBar: TabBar(
                    labelColor: Colors.purple,
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: Colors.purple,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorWeight: 3.r, // ✅ 3 -> 3.r
                    tabs: const [Tab(text: "전체 음악"), Tab(text: "즐겨찾기")],
                  ),
                ),
              ),
            ];
          },
          body: songsAsync.when(
            data: (songs) {
              final filteredSongs = songs
                  .where((s) =>
              s.title.contains(_searchController.text) ||
                  s.singer.contains(_searchController.text))
                  .toList();

              return TabBarView(
                children: [
                  _buildListView(filteredSongs),
                  _buildListView(filteredSongs.where((s) => s.isFavorite).toList()),
                ],
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text('에러: $e')),
          ),
        ),
      ),
    );
  }

  void showLoginAlert() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('로그인 필요'),
        content: const Text('즐겨찾기 기능을 사용하려면 로그인이 필요합니다.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              context.pushNamed(AppRoute.login.name);
            },
            child: const Text('로그인'),
          ),
        ],
      ),
    );
  }

  Widget _buildTitleBar() {
    return Text(
      "곡 목록",
      key: const ValueKey("title"),
      style: TextStyle(
        fontSize: 22.sp, // ✅ 22 -> 22.sp
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }

  Widget _buildSearchField() {
    return Container(
      key: const ValueKey("searchField"),
      height: 45.h, // ✅ 45 -> 45.h
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(12.r), // ✅ 12 -> 12.r
      ),
      child: TextField(
        controller: _searchController,
        autofocus: true,
        decoration: InputDecoration(
          hintText: "곡명, 가수 검색",
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 15.w, // ✅ 15 -> 15.w
            vertical: 10.h,   // ✅ 10 -> 10.h
          ),
        ),
        onChanged: (value) {
          setState(() {});
        },
      ),
    );
  }

  Widget _buildListView(List<dynamic> songs) {
    if (songs.isEmpty) return const Center(child: Text("곡이 없습니다."));
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: songs.length,
      itemBuilder: (context, index) {
        final song = songs[index];
        return ListTile(
          onTap: () {
            context.pushNamed(AppRoute.lyrics.name, extra: song);
          },
          contentPadding: EdgeInsets.symmetric(
            horizontal: 20.w, // ✅ 20 -> 20.w
            vertical: 5.h,    // ✅ 5 -> 5.h
          ),
          leading: CircleAvatar(
            backgroundColor: const Color(0xFFF1D6E4),
            child: Icon(
              Icons.music_note,
              color: Colors.white,
              size: 20.sp, // ✅ (기존 미지정) -> 20.sp로 고정
            ),
          ),
          title: Text(
            song.title,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp), // ✅ (기존 미지정) + 14.sp
          ),
          subtitle: Text(
            song.singer,
            style: TextStyle(fontSize: 12.sp), // ✅ (기존 미지정) + 12.sp
          ),
          trailing: IconButton(
            icon: Icon(
              song.isFavorite ? Icons.favorite : Icons.favorite_border,
              color: song.isFavorite ? Colors.red : Colors.grey,
              size: 22.sp, // ✅ (기존 미지정) -> 22.sp
            ),
            onPressed: () async {
              try {
                final auth = ref.read(authProvider.notifier);
                final user = auth.build();

                if (user == null) {
                  showLoginAlert();
                }

                await ref.read(favoriteTogglerProvider.notifier).toggleFavoriteStatus(
                  song.id,
                  song.isFavorite,
                );

                ref.invalidate(fetchSongListProvider);

                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        song.isFavorite ? '즐겨찾기에서 제거되었습니다.' : '즐겨찾기에 추가되었습니다.',
                        style: TextStyle(fontSize: 13.sp), // ✅ (선택) 스낵바 폰트
                      ),
                      duration: const Duration(seconds: 1),
                    ),
                  );
                }
              } catch (e) {
                if (context.mounted) {
                  // _showLoginAlert(context);
                }
              }
            },
          ),
        );
      },
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({required this.tabBar, required this.statusBarHeight});

  final TabBar tabBar;
  final double statusBarHeight;

  @override
  double get minExtent => tabBar.preferredSize.height + statusBarHeight;

  @override
  double get maxExtent => tabBar.preferredSize.height + statusBarHeight;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      padding: EdgeInsets.only(top: statusBarHeight),
      color: const Color(0xFFF8EAF1),
      child: tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) => false;
}
