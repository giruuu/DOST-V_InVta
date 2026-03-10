import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/event_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),

              // 1. Welcome Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome back,",
                        style: TextStyle(fontSize: 14.sp, color: AppTheme.textLightGray),
                      ),
                      Text(
                        "Gian Villegas", // This will eventually come from Laravel
                        style: TextStyle(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.primaryBlue
                        ),
                      ),
                    ],
                  ),
                  CircleAvatar(
                    radius: 24.r,
                    backgroundColor: AppTheme.primaryBlue.withOpacity(0.1),
                    child: Icon(Icons.person, color: AppTheme.primaryBlue, size: 28.w),
                  ),
                ],
              ),

              SizedBox(height: 20.h),

              // 2. Search Bar
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search events...",
                    hintStyle: TextStyle(fontSize: 14.sp, color: AppTheme.textLightGray),
                    border: InputBorder.none,
                    icon: Icon(Icons.search, color: AppTheme.primaryBlue, size: 20.w),
                  ),
                ),
              ),

              SizedBox(height: 25.h),

              // 3. Section Title: Ongoing Events
              Text(
                "Ongoing Events",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12.h),

              // 4. Dummy Event Cards (To test the UI)
              EventCard(
                title: "InVta Tech Summit 2026",
                description: "Join us for the biggest tech gathering in Bicol University. Explore new trends in AI and Cloud.",
                date: "March 15, 2026",
                time: "08:00 AM",
                imageUrl: "https://picsum.photos/800/400", // Temporary dummy image
                statusText: "Ongoing",
                actionButtonText: "REGISTER",
                onAction: () => print("Register Tapped"),
                onSeeMore: () => print("See More Tapped"),
              ),

              EventCard(
                title: "Artistry Exhibit: Albay",
                description: "A showcase of local artists from Tabaco City and Legazpi. Support our local creators!",
                date: "March 18, 2026",
                time: "01:00 PM",
                imageUrl: "https://picsum.photos/801/400",
                statusText: "Upcoming",
                actionButtonText: "REGISTER",
                onAction: () => print("Register Tapped"),
                onSeeMore: () => print("See More Tapped"),
              ),

              SizedBox(height: 20.h), // Bottom padding for scrolling
            ],
          ),
        ),
      ),
    );
  }
}