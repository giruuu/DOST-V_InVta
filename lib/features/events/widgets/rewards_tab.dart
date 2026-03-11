import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_theme.dart';

class RewardsTab extends StatelessWidget {
  const RewardsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("REWARDS", style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: AppTheme.primaryBlue)),
          SizedBox(height: 12.h),
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(color: Colors.blue.withOpacity(0.05), borderRadius: BorderRadius.circular(8.r)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.info_outline, color: AppTheme.primaryBlue, size: 16.w),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    "These are the possible rewards you can claim if you participate in various events, sub-events and exhibition booths.",
                    style: TextStyle(fontSize: 11.sp, color: Colors.grey[700]),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24.h),

          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 16.h,
            crossAxisSpacing: 16.w,
            children: List.generate(4, (index) {
              return Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade200),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.card_giftcard, size: 50.w, color: Colors.grey[400]),
                    SizedBox(height: 8.h),
                    Text("Item ${index + 1}", style: TextStyle(fontSize: 12.sp, color: AppTheme.primaryBlue, fontWeight: FontWeight.bold)),
                  ],
                ),
              );
            }),
          )
        ],
      ),
    );
  }
}