// 이 위젯을 별도 파일로 만들거나 각 Screen 상단에 배치하세요.
import 'package:flutter/material.dart';

class CustomHeader extends StatelessWidget {
  final String title;
  const CustomHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              title,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Colors.deepPurple,
            ),
          ),
          // const SizedBox(height: 4),
          // Text(
          //   title,
          //   style: const TextStyle(
          //     fontSize: 28,
          //     fontWeight: FontWeight.bold,
          //     letterSpacing: -0.5,
          //   ),
          // ),
        ],
      ),
    );
  }
}