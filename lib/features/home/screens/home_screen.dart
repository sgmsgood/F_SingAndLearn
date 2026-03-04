import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../favorites/screens/favorite_screen.dart';
import '../../songs/screens/song_list_screen.dart';
import '../../study/presentation/my_info_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _currentIndex = 0;
  DateTime? _lastBackPressed;

  final List<Widget> _pages = const [
    SongListScreen(),
    UserVocaScreen(),
    MyInfoPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) return;

        final now = DateTime.now();
        final isSecondPress = _lastBackPressed != null &&
            now.difference(_lastBackPressed!) <= const Duration(seconds: 2);

        if (isSecondPress) {
          SystemNavigator.pop(); // 앱 종료
          return;
        }

        _lastBackPressed = now;

        // 기존 스낵바 있으면 지우고 새로 표시
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            const SnackBar(
              content: Text('한 번 더 뒤로가기를 누르면 종료됩니다.'),
              duration: Duration(seconds: 2),
            ),
          );
      },
      child: Scaffold(
        body: SafeArea(
          bottom: false,
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
          items: [
            BottomNavigationBarItem(
              icon: Image.asset('assets/icons/tab/ic_listen.png', width: 24.sp, height: 24.sp, color: _currentIndex == 0 ? Colors.purple.shade700 : Colors.grey.shade600),
              label: '곡 목록',
            ),
            BottomNavigationBarItem(
              icon: Image.asset('assets/icons/tab/ic_study.png', width: 24.sp, height: 24.sp, color: _currentIndex == 1 ? Colors.purple.shade700 : Colors.grey.shade600),
              label: '공부하기',
            ),
            BottomNavigationBarItem(
              icon: Image.asset('assets/icons/tab/ic_profile.png', width: 24.sp, height: 24.sp, color: _currentIndex == 2 ? Colors.purple.shade700 : Colors.grey.shade600),
              label: '내 정보',
            ),
          ],
        ),
      ),
    );
  }
}
