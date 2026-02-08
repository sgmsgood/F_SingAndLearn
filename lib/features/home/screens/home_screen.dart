import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../favorites/screens/favorite_screen.dart';
import '../../songs/screens/song_list_screen.dart';
import '../../study/presentation/my_info_screen.dart';
// 아래 임포트 경로는 사용자님의 프로젝트 구조에 맞게 유지하세요.
// import 'package:mumu/features/favorites/screens/favorite_screen.dart';
// import 'package:mumu/features/songs/screens/song_list_screen.dart';
// import 'package:mumu/features/study/presentation/my_info_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _currentIndex = 0;

  // 탭별 페이지 리스트 (각 스크린에 헤더가 포함됨)
  final List<Widget> _pages = const [
    SongListScreen(),
    FavoriteScreen(),
    MyInfoPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        // backgroundColor: Colors.white,
        body: SafeArea(
          bottom: false, // 하단 바와의 간격을 위해 아래쪽은 false
          child: IndexedStack(
            index: _currentIndex,
            children: _pages,
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          backgroundColor: const Color(0xFFF1D6E4),
          selectedItemColor: Colors.purple.shade700,
          unselectedItemColor: Colors.grey.shade600,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.queue_music), label: '곡 목록'),
            BottomNavigationBarItem(icon: Icon(Icons.school), label: '공부하기'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: '내 정보'),
          ],
        ),
      ),
    );
  }
}