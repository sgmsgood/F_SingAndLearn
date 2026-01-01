
import 'package:flutter/material.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        '즐겨찾기 화면\n\n찜해둔 노래들을 모아서 보여주는 곳 😊',
        textAlign: TextAlign.center,
      ),
    );
  }
}