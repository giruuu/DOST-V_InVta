import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart'; // 1. Added GoRouter import!
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/event_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Image.asset(
          'assets/images/InVta_Logo.png',
          height: 35.h,
          fit: BoxFit.contain,
        ),
        centerTitle: false,
        actions: [
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.notifications_none, color: AppTheme.primaryBlue, size: 28.w),
                onPressed: () => print("Notifications Tapped"),
              ),
              Positioned(
                top: 10.h,
                right: 10.w,
                child: Container(
                  padding: EdgeInsets.all(4.w),
                  decoration: const BoxDecoration(
                    color: AppTheme.alertRed,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '3',
                    style: TextStyle(color: Colors.white, fontSize: 8.sp, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: 12.w),
        ],
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle("Announcements"),
            SizedBox(
              height: 110.h,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildAnnouncementCard(),
                  _buildAnnouncementCard(),
                ],
              ),
            ),

            SizedBox(height: 20.h),

            _buildSectionTitle("Ongoing Events"),
            // 2. Removed 'const' here and added the onSeeMore routing logic
            EventCard(
              title: "Event Name",
              description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna.",
              date: "Wed, Jan 21 2025",
              time: "10:00 PM",
              onSeeMore: () => context.push('/event-details'),
            ),

            _buildSectionTitle("Upcoming Events"),
            // 3. Removed 'const' here and added the onSeeMore routing logic
            EventCard(
              title: "Event Name",
              description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna.",
              date: "Wed, Jan 21 2025",
              time: "10:00 PM",
              onSeeMore: () => context.push('/event-details'),
            ),

            _buildSectionTitle("Surveys"),
            _buildSurveyItem(),
            _buildSurveyItem(),
            _buildSurveyItem(),

            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Text(
        title,
        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: Colors.black87),
      ),
    );
  }

  Widget _buildAnnouncementCard() {
    return Container(
      width: 250.w,
      margin: EdgeInsets.only(right: 12.w),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 5)],
      ),
      child: Row(
        children: [
          Icon(Icons.campaign, color: AppTheme.primaryBlue, size: 40.w),
          SizedBox(width: 8.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("ANNOUNCEMENT", style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold, color: AppTheme.primaryBlue)),
                Text("This event has been cancelled", style: TextStyle(fontSize: 10.sp, color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSurveyItem() {
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        children: [
          Icon(Icons.assignment, color: AppTheme.primaryBlue, size: 24.w),
          SizedBox(width: 12.w),
          Expanded(child: Text("Survey Available for this Event", style: TextStyle(fontSize: 10.sp))),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryBlue,
              minimumSize: Size(80.w, 25.h),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.r)),
            ),
            child: Text("Go to Survey", style: TextStyle(fontSize: 9.sp)),
          )
        ],
      ),
    );
  }
}