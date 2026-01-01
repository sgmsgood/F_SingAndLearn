import 'package:f_sing_and_learn/features/favorites/screens//favorite_screen.dart';
import 'package:f_sing_and_learn/features/songs/screens/song_list_screen.dart';
import 'package:f_sing_and_learn/features/study/presentation/study_screen.dart' ;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _currentIndex = 0;

  // 각 탭에 보여줄 페이지 리스트
  final List<Widget> _pages = const [
    SongListScreen(),
    FavoritesScreen(),
    StudyScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'SingAndLearn 🎵',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: IndexedStack(
          index: _currentIndex,
          children: _pages,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.queue_music),
              label: '플레이리스트',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: '즐겨찾기',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.school),
              label: '공부하기',
            ),
          ],
        ),
      ),
    );
  }
}
