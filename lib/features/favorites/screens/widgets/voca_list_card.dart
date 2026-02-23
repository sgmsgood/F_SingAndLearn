import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../domain/voca_status.dart';
import '../../providers/user_voca_provider.dart';

class VocaCard extends StatelessWidget {
  final UserVocaItem item;
  final VoidCallback onToggleStatus;
  final VoidCallback onDelete;

  const VocaCard({
    required this.item,
    required this.onToggleStatus,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return Container(
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            blurRadius: 14,
            offset: const Offset(0, 6),
            color: Colors.black.withOpacity(0.06),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // left
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        item.text,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w800),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Flexible(
                      child: Text(
                        item.pinyin,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: Colors.black54,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Text(
                  item.meaning,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14.sp, color: Colors.black87, height: 1.25),
                ),
              ],
            ),
          ),

          SizedBox(width: 10.w),

          // right: status toggle + delete
          Column(
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(999),
                onTap: onToggleStatus,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: primary.withOpacity(0.10),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    item.status.label,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: primary,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              IconButton(
                onPressed: onDelete,
                icon: const Icon(Icons.bookmark_remove_outlined),
                tooltip: '내 단어에서 제거',
              ),
            ],
          ),
        ],
      ),
    );
  }
}