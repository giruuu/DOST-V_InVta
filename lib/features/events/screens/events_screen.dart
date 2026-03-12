import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/banner_event_card.dart';
import '../../../core/utils/registration_sheet.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  int _selectedTabIndex = 0;

  // NEW: State variable to track which events are registered (using index for demo)
  final Set<int> _registeredEvents = {};

  @override
  Widget build(BuildContext context) {
    bool isAvailableTab = _selectedTabIndex == 0;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          children: [
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

            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                itemCount: 4,
                itemBuilder: (context, index) {
                  String statusText;
                  Color statusColor;
                  String primaryButtonText;
                  VoidCallback? onPrimaryAction;

                  String currentEventName = "Event Name ${index + 1}";

                  // Check if this specific event index is in our "registered" set
                  bool hasRegistered = _registeredEvents.contains(index);

                  if (isAvailableTab) {
                    statusText = "Incoming";
                    statusColor = const Color(0xFFFFD700);

                    // Logic: If registered, change text and disable button
                    if (hasRegistered) {
                      primaryButtonText = "REGISTERED";
                      onPrimaryAction = null; // Passing null makes the button grey!
                    } else {
                      primaryButtonText = "REGISTER";
                      onPrimaryAction = () {
                        RegistrationSheet.show(
                          context,
                          eventName: currentEventName,
                          type: primaryButtonText,
                          onSuccess: () {
                            setState(() {
                              _registeredEvents.add(index); // Mark as registered
                            });
                          },
                        );
                      };
                    }
                  } else {
                    bool isEnded = index % 2 == 0;
                    statusText = isEnded ? "Ended" : "Ongoing";
                    statusColor = isEnded ? Colors.redAccent : Colors.greenAccent.shade400;

                    if (hasRegistered && !isEnded) {
                      primaryButtonText = "JOINED";
                      onPrimaryAction = null;
                    } else {
                      primaryButtonText = isEnded ? "ANSWER SURVEY" : "WALK IN";
                      onPrimaryAction = () {
                        if (!isEnded) {
                          RegistrationSheet.show(
                            context,
                            eventName: currentEventName,
                            type: primaryButtonText,
                            onSuccess: () => setState(() => _registeredEvents.add(index)),
                          );
                        }
                      };
                    }
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
                    onPrimaryAction: onPrimaryAction, // Passes null if registered
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