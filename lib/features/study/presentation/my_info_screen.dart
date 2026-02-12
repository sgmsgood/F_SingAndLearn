import 'package:mumu/shared/routes/app_route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        title: Text(
          '내 정보',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.r),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                _buildProfileCard(context, user),
                SizedBox(height: 30.h),
                _buildMenuSection(context, ref, user),
                SizedBox(height: 40.h),
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
                        fontSize: 13.sp,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                ],
              ),
            Text(
              '버전 1.0.0',
              style: TextStyle(color: Colors.grey.shade500, fontSize: 12.sp),
            ),
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
      padding: EdgeInsets.all(24.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: lightPurple, width: 1.5.r),
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 40.r,
            backgroundColor: lightPurple,
            backgroundImage: avatarUrl != null ? NetworkImage(avatarUrl) : null,
            child: avatarUrl == null
                ? Icon(Icons.person, size: 50.sp, color: Colors.white)
                : null,
          ),
          SizedBox(height: 16.h),
          Text(
            nickname,
            style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4.h),
          Text(
            email,
            style: TextStyle(color: Colors.black54, fontSize: 14.sp),
          ),
          SizedBox(height: 16.h),
          OutlinedButton(
            onPressed: () => context.pushNamed(AppRoute.editProfile.name),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.purple,
              side: const BorderSide(color: lightPurple),
              shape: const StadiumBorder(),
            ),
            child: Text('프로필 수정', style: TextStyle(fontSize: 14.sp)),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuSection(BuildContext context, WidgetRef ref, User? user) {
    final bool isLoggedIn = user != null;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10.r,
            offset: Offset(0, 5.h),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildMenuItem(
            icon: Icons.privacy_tip_outlined,
            title: '개인정보 처리방침',
            onTap: () => launchUrl(Uri.parse(
              'https://elen19900219.notion.site/MuMu-2fc17494a91680c39107ccf31087da09?source=copy_link',
            )),
          ),
          Divider(
            height: 1.h,
            color: Colors.grey.shade100,
            indent: 20.w,
            endIndent: 20.w,
          ),
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
      leading: Icon(icon, color: lightPurple, size: 24.sp),
      title: Text(
        title,
        style: TextStyle(color: textColor, fontWeight: FontWeight.w500, fontSize: 15.sp),
      ),
      trailing: Icon(Icons.chevron_right, color: Colors.grey, size: 22.sp),
      onTap: onTap,
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 2.h),
    );
  }

  void _showLogoutDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('로그아웃', style: TextStyle(fontSize: 16.sp)),
        content: Text('정말 로그아웃 하시겠습니까?', style: TextStyle(fontSize: 14.sp)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('취소', style: TextStyle(fontSize: 14.sp)),
          ),
          TextButton(
            onPressed: () async {
              await ref.read(authProvider.notifier).signOut();
              if (context.mounted) {
                Navigator.pop(context);
                context.goNamed(AppRoute.home.name);
              }
            },
            child: Text('확인', style: TextStyle(color: Colors.red, fontSize: 14.sp)),
          ),
        ],
      ),
    );
  }

  void _showDeleteAccountDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('회원탈퇴', style: TextStyle(fontSize: 16.sp)),
        content: Text(
          '정말 탈퇴하시겠습니까? 모든 정보가 삭제되며, 복구할 수 없습니다.',
          style: TextStyle(fontSize: 14.sp),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('취소', style: TextStyle(fontSize: 14.sp)),
          ),
          TextButton(
            onPressed: () async {
              await ref.read(authProvider.notifier).deleteAccount();
              if (context.mounted) {
                Navigator.pop(context);
                context.goNamed(AppRoute.home.name);
              }
            },
            child: Text('탈퇴', style: TextStyle(color: Colors.red, fontSize: 14.sp)),
          ),
        ],
      ),
    );
  }
}
