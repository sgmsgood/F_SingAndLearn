import 'package:flutter/material.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('프로필 수정'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(vertical: 32, horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const TextField(decoration: InputDecoration(labelText: '닉네임')),
                const Divider(),
              ],
            ),

            // const SizedBox(height: 400),
            // ListTile(
            //   contentPadding: EdgeInsets.zero,
            //   title: const Text(
            //     '회원 탈퇴',
            //     style: TextStyle(color: Colors.redAccent, fontSize: 14),
            //   ),
            //   trailing: const Icon(Icons.chevron_right, size: 20),
            //   onTap: () => _showDeleteAccountDialog(context),
            // ),
          ],
        ),
      ),
    );
  }

  // 탈퇴 확인 다이얼로그 (중요!)
  void _showDeleteAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('정말 떠나시나요?'),
        content: const Text(
          '회원 탈퇴 시 지금까지 학습한 중국어 노래 데이터와 단어장 정보가 모두 사라지며 복구할 수 없습니다.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () {
              // TODO: Supabase 계정 삭제 로직 연결
              Navigator.pop(context);
            },
            child: const Text('탈퇴하기', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
