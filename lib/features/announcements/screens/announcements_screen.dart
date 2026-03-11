import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';

class AnnouncementsScreen extends StatelessWidget {
  const AnnouncementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC), // Brighter, modern grey
      body: SafeArea(
        child: Column(
          children: [
            // --- HEADER ---
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: GestureDetector(
                onTap: () => context.go('/home'),
                child: Row(
                  children: [
                    Icon(Icons.arrow_back_ios, color: AppTheme.primaryBlue, size: 20.w),
                    SizedBox(width: 4.w),
                    Text(
                      "Announcements",
                      style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryBlue,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // --- LIST ---
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                children: [
                  _buildDateHeader("Today"),
                  _buildAnnouncementItem(
                    title: "System Maintenance",
                    message: "The InVta platform will undergo a brief maintenance period tonight to improve performance. Thank you for your patience.",
                    time: "Just Now",
                    isUrgent: true,
                    isNew: true,
                  ),
                  _buildAnnouncementItem(
                    title: "Event Venue Change",
                    message: "The 'Tech Summit 2026' has been moved from Hall A to the Grand Ballroom. Please check your digital ID for the updated QR info.",
                    time: "20mins ago",
                    isUrgent: false,
                    isNew: true,
                  ),

                  _buildDateHeader("Yesterday"),
                  _buildAnnouncementItem(
                    title: "Registration Reminder",
                    message: "Early bird registration for the Summer Workshop ends this Friday. Don't forget to claim your points!",
                    time: "8:30 PM",
                    isUrgent: false,
                    isNew: false,
                  ),

                  _buildDateHeader("March 4, 2026"),
                  _buildAnnouncementItem(
                    title: "Welcome to InVta!",
                    message: "Welcome Gian Russell! We're glad to have you here. Explore your dashboard to see upcoming events in Bicol University.",
                    time: "10:15 AM",
                    isUrgent: false,
                    isNew: false,
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateHeader(String text) {
    return Padding(
      padding: EdgeInsets.only(top: 24.h, bottom: 12.h),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 13.sp,
          fontWeight: FontWeight.w600,
          color: Colors.grey[500],
        ),
      ),
    );
  }

  Widget _buildAnnouncementItem({
    required String title,
    required String message,
    required String time,
    bool isUrgent = false,
    bool isNew = false,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: isUrgent ? Colors.red.withOpacity(0.3) : Colors.grey.shade200,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Theme(
        data: ThemeData().copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
          leading: Icon(
            isUrgent ? Icons.error_outline : Icons.notifications_none_rounded,
            color: isUrgent ? Colors.red : AppTheme.primaryBlue,
            size: 24.w,
          ),
          title: Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
              if (isNew)
                Container(
                  width: 8.w,
                  height: 8.w,
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                ),
            ],
          ),
          subtitle: Text(
            time,
            style: TextStyle(fontSize: 11.sp, color: Colors.grey[600]),
          ),
          children: [
            Padding(
              padding: EdgeInsets.only(left: 56.w, right: 16.w, bottom: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(color: Colors.grey.shade100, height: 1.h),
                  SizedBox(height: 12.h),
                  Text(
                    message,
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: Colors.grey[700],
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}