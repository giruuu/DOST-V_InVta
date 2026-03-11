import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/banner_event_card.dart';
import '../../../core/utils/registration_sheet.dart'; // 1. Import the new utility

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  int _selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    bool isAvailableTab = _selectedTabIndex == 0;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          children: [
            // Header with Back Button and Title in one row
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: GestureDetector(
                onTap: () => context.go('/home'),
                child: Row(
                  children: [
                    Icon(Icons.arrow_back_ios, color: AppTheme.primaryBlue, size: 20.w),
                    SizedBox(width: 4.w),
                    Text(
                        "Events",
                        style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: AppTheme.primaryBlue)
                    ),
                  ],
                ),
              ),
            ),

            // Toggle Tab
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              height: 48.h,
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12.r)),
              child: Row(
                children: [
                  _buildToggleTab("Available", 0),
                  _buildToggleTab("My Events", 1),
                ],
              ),
            ),

            SizedBox(height: 20.h),

            // Events List
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                itemCount: 4,
                itemBuilder: (context, index) {
                  String statusText;
                  Color statusColor;
                  String primaryButtonText;

                  // Temporary name for the demo
                  String currentEventName = "Event Name ${index + 1}";

                  if (isAvailableTab) {
                    statusText = "Incoming";
                    statusColor = const Color(0xFFFFD700); // Gold
                    primaryButtonText = "REGISTER";
                  } else {
                    bool isEnded = index % 2 == 0;
                    statusText = isEnded ? "Ended" : "Ongoing";
                    statusColor = isEnded ? Colors.redAccent : Colors.greenAccent.shade400;
                    primaryButtonText = isEnded ? "ANSWER SURVEY" : "WALK IN";
                  }

                  return BannerEventCard(
                    title: currentEventName.toUpperCase(),
                    description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                    date: "Wed, Jan 21 2026",
                    time: "06:16 PM",
                    imageUrl: "https://picsum.photos/800/400?random=$index",
                    statusText: statusText,
                    statusColor: statusColor,
                    primaryButtonText: primaryButtonText,
                    onPrimaryAction: () {
                      // 2. Implementation: Trigger the Registration Sheet
                      // We only show the sheet for REGISTER and WALK IN
                      if (primaryButtonText == "REGISTER" || primaryButtonText == "WALK IN") {
                        RegistrationSheet.show(
                          context,
                          eventName: currentEventName,
                          type: primaryButtonText,
                        );
                      } else if (primaryButtonText == "ANSWER SURVEY") {
                        print("Navigating to Survey...");
                        // context.push('/survey');
                      }
                    },
                    onSeeMore: () => context.push('/event-details'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleTab(String title, int index) {
    bool isActive = _selectedTabIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedTabIndex = index),
        child: Container(
          decoration: BoxDecoration(
            color: isActive ? AppTheme.primaryBlue : Colors.transparent,
            borderRadius: BorderRadius.circular(8.r),
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                color: isActive ? Colors.white : Colors.grey[500]
            ),
          ),
        ),
      ),
    );
  }
}