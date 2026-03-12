import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/app_theme.dart';

class PointsSheet {
  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.6, // Takes up 60% of the screen
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle Bar
            Center(
              child: Container(
                width: 40.w, height: 4.h,
                decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(10.r)),
              ),
            ),
            SizedBox(height: 24.h),

            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Points History", style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: AppTheme.primaryBlue)),
                Text("70 pts", style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: const Color(0xFF56B4E9))),
              ],
            ),
            SizedBox(height: 8.h),
            Text("Here is how you earned your points this year.", style: TextStyle(fontSize: 12.sp, color: Colors.grey[500])),
            SizedBox(height: 20.h),
            Divider(color: Colors.grey.shade200),

            // History List
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  _buildHistoryItem("Tech Summit 2026", "Event Attendance", "+20"),
                  _buildHistoryItem("Post-Event Survey", "Survey Completed", "+10"),
                  _buildHistoryItem("Workshop: Flutter Basics", "Walk-in Attendance", "+15"),
                  _buildHistoryItem("Early Bird Registration", "Bonus Points", "+25"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper widget for the list items
  static Widget _buildHistoryItem(String title, String subtitle, String points) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(color: const Color(0xFF56B4E9).withOpacity(0.1), shape: BoxShape.circle),
            child: Icon(Icons.star_rounded, color: const Color(0xFF56B4E9), size: 24.w),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: Colors.black87)),
                SizedBox(height: 4.h),
                Text(subtitle, style: TextStyle(fontSize: 11.sp, color: Colors.grey[500])),
              ],
            ),
          ),
          Text(points, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: Colors.green)),
        ],
      ),
    );
  }
}