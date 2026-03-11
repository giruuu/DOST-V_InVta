import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
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
            // 1. NEW: MY POINTS CARD
            _buildPointsCard(),

            SizedBox(height: 24.h),

            // 2. ONGOING EVENTS
            _buildSectionTitle("Ongoing Events"),
            EventCard(
              title: "Event Name",
              description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna.",
              date: "Wed, Jan 21 2026",
              time: "10:00 PM",
              onSeeMore: () => context.push('/event-details'),
            ),

            // 3. UPCOMING EVENTS
            _buildSectionTitle("Upcoming Events"),
            EventCard(
              title: "Event Name",
              description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna.",
              date: "Wed, Jan 21 2026",
              time: "10:00 PM",
              onSeeMore: () => context.push('/event-details'),
            ),

            // 4. MOVED: ANNOUNCEMENTS (Now at the bottom)
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
          ],
        ),
      ),
    );
  }

  // --- WIDGET BUILDERS ---

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Text(
        title,
        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: Colors.black87),
      ),
    );
  }

  // The new Points Card matching your mockup
  Widget _buildPointsCard() {
    return Container(
      width: double.infinity, // Stretches nicely across the screen
      height: 150.h, // FIX: Fixed height makes it a perfect wide rectangle!
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      // Using a Stack lets us pin items to corners without affecting the height
      child: Stack(
        children: [
          // TOP LEFT: Title & Year
          Positioned(
            top: 0,
            left: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "MY POINTS",
                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, color: Colors.black),
                ),
                Text(
                  "2026",
                  style: TextStyle(fontSize: 12.sp, color: Colors.grey[500]),
                ),
              ],
            ),
          ),

          // DEAD CENTER: The big number
          Align(
            alignment: Alignment.center,
            child: Text(
              "70",
              style: TextStyle(
                fontSize: 64.sp,
                fontWeight: FontWeight.w300,
                color: const Color(0xFF56B4E9),
              ),
            ),
          ),

          // BOTTOM RIGHT: View More Button
          Positioned(
            bottom: 0,
            right: 0,
            child: InkWell(
              onTap: () => print("View More Points tapped"),
              borderRadius: BorderRadius.circular(20.r),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF56B4E9),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  "VIEW MORE",
                  style: TextStyle(color: Colors.white, fontSize: 10.sp, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
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
}