import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// 사용자 환경에 맞는 import 경로 유지
// import '../../user/auth/providers/auth_provider.dart';
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
  // 1. 스크롤 컨트롤러 추가
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // 2. 스크롤 리스너 등록
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_isSearching && _scrollController.offset > 20) {
      // 키보드부터 닫기
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
    _scrollController.removeListener(_scrollListener); // 리스너 제거
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final songsAsync = ref.watch(fetchSongListProvider);
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    const double searchBarHeight = 60.0;

    return Scaffold(
      backgroundColor: Colors.white,
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          // 3. 컨트롤러 연결
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
                expandedHeight: _isSearching ? (kToolbarHeight + searchBarHeight) : kToolbarHeight,
                centerTitle: false,
                title: const Text(
                  "곡 목록",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                actions: [
                  // IconButton(
                  //   icon: Icon(_isSearching ? Icons.close : Icons.search, color: Colors.black),
                  //   onPressed: () {
                  //     setState(() {
                  //       _isSearching = !_isSearching;
                  //       if (!_isSearching) {
                  //         _searchController.clear();
                  //         FocusScope.of(context).unfocus();
                  //       }
                  //     });
                  //   },
                  // ),
                  // const SizedBox(width: 10),
                ],
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(_isSearching ? searchBarHeight : 0),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOutCubic,
                    height: _isSearching ? searchBarHeight : 0,
                    child: _isSearching
                        ? Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: TextField(
                          controller: _searchController,
                          decoration: const InputDecoration(
                            hintText: "곡명, 가수 검색",
                            prefixIcon: Icon(Icons.search, size: 20, color: Colors.grey),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(vertical: 10),
                          ),
                          onChanged: (val) => setState(() {}),
                        ),
                      ),
                    )
                        : const SizedBox.shrink(), // 닫힐 때는 완전히 비우기
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
                    indicatorWeight: 3,
                    tabs: const [Tab(text: "전체 음악"), Tab(text: "즐겨찾기")],
                  ),
                ),
              ),
            ];
          },
          body: songsAsync.when(
            data: (songs) {
              final filteredSongs = songs.where((s) =>
              s.title.contains(_searchController.text) ||
                  s.singer.contains(_searchController.text)).toList();

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
              // 로그인 화면으로 이동 (라우터 이름은 'login'으로 가정)
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
    return const Text(
      "곡 목록",
      key: ValueKey("title"),
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }

  Widget _buildSearchField() {
    return Container(
      key: const ValueKey("searchField"),
      height: 45,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: _searchController,
        autofocus: true,
        decoration: const InputDecoration(
          hintText: "곡명, 가수 검색",
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        ),
        onChanged: (value) {
          setState(() {}); // 검색어 입력 시 목록 갱신
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
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          leading: const CircleAvatar(
            backgroundColor: Color(0xFFF1D6E4),
            child: Icon(Icons.music_note, color: Colors.white),
          ),
          title: Text(song.title, style: const TextStyle(fontWeight: FontWeight.w500)),
          subtitle: Text(song.singer),
          trailing: IconButton(
            icon: Icon(
              song.isFavorite ? Icons.favorite : Icons.favorite_border,
              color: song.isFavorite ? Colors.red : Colors.grey,
            ),
            onPressed: () async {
              try {
                final auth = ref.read(authProvider.notifier);
                final user = auth.build();

                if(user == null) {
                  showLoginAlert();
                }

                await ref.read(favoriteTogglerProvider.notifier).toggleFavoriteStatus(
                  song.id,
                  song.isFavorite,
                );

                ref.invalidate(fetchSongListProvider);

                // 성공 시 스낵바 알림 (선택 사항)
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(song.isFavorite ? '즐겨찾기에서 제거되었습니다.' : '즐겨찾기에 추가되었습니다.'),
                      duration: const Duration(seconds: 1),
                    ),
                  );
                }
              } catch (e) {
                // 에러 발생 시(예: 미로그인) 알림 표시
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

// 에러가 났던 Delegate 수정 버전
class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({required this.tabBar, required this.statusBarHeight});

  final TabBar tabBar;
  final double statusBarHeight; // 외부에서 주입받음

  @override
  double get minExtent => tabBar.preferredSize.height + statusBarHeight;

  @override
  double get maxExtent => tabBar.preferredSize.height + statusBarHeight;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      // build 내부에서 MediaQuery를 쓰지 않고 미리 받은 값을 사용
      padding: EdgeInsets.only(top: statusBarHeight),
      color: const Color(0xFFF8EAF1),
      child: tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
