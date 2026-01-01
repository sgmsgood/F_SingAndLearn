
import 'package:flutter/material.dart';

class StudyScreen extends StatelessWidget {
  const StudyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        '공부하기 화면\n\n가사 보면서 단어, 표현 공부하는 기능이 들어갈 자리 😊',
        textAlign: TextAlign.center,
      ),
    );
  }
}