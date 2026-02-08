import 'package:mumu/shared/routes/app_route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../user/auth/providers/auth_provider.dart';

class MyInfoPage extends ConsumerWidget {
  const MyInfoPage({super.key});

  static const Color lightPurple = Color(0xFFD1C4E9);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('내 정보', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                _buildProfileCard(context, user),
                const SizedBox(height: 30),
                _buildMenuSection(context, ref, user),
                const SizedBox(height: 40),
              ],
            ),
            if (user != null)
              Column(
                children: [
                  TextButton(
                    onPressed: () => _showDeleteAccountDialog(context, ref),
                    child: Text(
                      '회원탈퇴',
                      style: TextStyle(
                        color: Colors.grey.shade400,
                        fontSize: 13,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            Text('버전 1.0.0', style: TextStyle(color: Colors.grey.shade500, fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileCard(BuildContext context, User? user) {
    final String nickname = user?.userMetadata?['full_name'] ?? '손님';
    final String email = user?.email ?? '로그인이 필요합니다.';
    final String? avatarUrl = user?.userMetadata?['avatar_url'];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: lightPurple, width: 1.5),
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: lightPurple,
            backgroundImage: avatarUrl != null ? NetworkImage(avatarUrl) : null,
            child: avatarUrl == null ? const Icon(Icons.person, size: 50, color: Colors.white) : null,
          ),
          const SizedBox(height: 16),
          Text(nickname, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(
            email,
            style: const TextStyle(color: Colors.black54, fontSize: 14),
          ),
          const SizedBox(height: 16),
          // OutlinedButton(
          //   onPressed: () => context.pushNamed(AppRoute.editProfile.name),
          //   style: OutlinedButton.styleFrom(
          //     foregroundColor: Colors.purple,
          //     side: const BorderSide(color: lightPink),
          //     shape: const StadiumBorder(),
          //   ),
          //   child: const Text('프로필 수정'),
          // ),
        ],
      ),
    );
  }

  Widget _buildMenuSection(BuildContext context, WidgetRef ref, User? user) {
    final bool isLoggedIn = user != null;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5)),
        ],
      ),
      child: Column(
        children: [
          _buildMenuItem(
            icon: Icons.privacy_tip_outlined,
            title: '개인정보 처리방침',
            onTap: () => launchUrl(Uri.parse('https://elen19900219.notion.site/MuMu-2fc17494a91680c39107ccf31087da09?source=copy_link')),
          ),
          Divider(height: 1, color: Colors.grey.shade100, indent: 20, endIndent: 20),
          if (isLoggedIn)
            _buildMenuItem(
              icon: Icons.logout,
              title: '로그아웃',
              textColor: Colors.redAccent,
              onTap: () => _showLogoutDialog(context, ref),
            )
          else
            _buildMenuItem(
              icon: Icons.login,
              title: '로그인',
              textColor: Theme.of(context).primaryColor,
              onTap: () => context.goNamed(AppRoute.login.name),
            ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color textColor = Colors.black87,
  }) {
    return ListTile(
      leading: Icon(icon, color: lightPurple),
      title: Text(title, style: TextStyle(color: textColor, fontWeight: FontWeight.w500)),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
      onTap: onTap,
    );
  }

  void _showLogoutDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('로그아웃'),
        content: const Text('정말 로그아웃 하시겠습니까?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('취소')),
          TextButton(
            onPressed: () async {
              await ref.read(authProvider.notifier).signOut();
              if (context.mounted) {
                Navigator.pop(context);
                context.goNamed(AppRoute.home.name);
              }
            },
            child: const Text('확인', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _showDeleteAccountDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('회원탈퇴'),
        content: const Text('정말 탈퇴하시겠습니까? 모든 정보가 삭제되며, 복구할 수 없습니다.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('취소')),
          TextButton(
            onPressed: () async {
              await ref.read(authProvider.notifier).deleteAccount();
              if (context.mounted) {
                Navigator.pop(context);
                context.goNamed(AppRoute.home.name);
              }
            },
            child: const Text('탈퇴', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
