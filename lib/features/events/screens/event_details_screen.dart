import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../core/theme/app_theme.dart';

// Import your new separate files!
import '../widgets/main_event_tab.dart';
import '../widgets/other_events_tab.dart';
import '../widgets/rewards_tab.dart';

class EventDetailsScreen extends StatefulWidget {
  const EventDetailsScreen({super.key});

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // BACKGROUND BANNER IMAGE
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 320.h,
            child: CachedNetworkImage(
              imageUrl: 'https://picsum.photos/800/600',
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(color: Colors.grey[200]),
              errorWidget: (context, url, error) => Container(color: Colors.grey[300]),
            ),
          ),

          // BACK BUTTON
          Positioned(
            top: 50.h,
            left: 20.w,
            child: InkWell(
              onTap: () => context.pop(),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 16.r,
                child: Icon(Icons.arrow_back_ios_new, color: AppTheme.primaryBlue, size: 16.w),
              ),
            ),
          ),

          // OVERLAPPING WHITE SHEET
          Positioned(
            top: 280.h,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -5))
                ],
              ),
              child: Column(
                children: [
                  // PAGEVIEW (Using the new external widgets!)
                  Expanded(
                    child: PageView(
                      controller: _pageController,
                      onPageChanged: (index) {
                        setState(() {
                          _currentPage = index;
                        });
                      },
                      children: const [
                        MainEventTab(),
                        OtherEventsTab(),
                        RewardsTab(),
                      ],
                    ),
                  ),

                  // DYNAMIC BOTTOM BAR
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                    decoration: const BoxDecoration(color: Colors.white),
                    child: Column(
                      children: [
                        if (_currentPage == 0) ...[
                          SizedBox(
                            width: double.infinity,
                            height: 45.h,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppTheme.primaryBlue,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                              ),
                              child: Text("ANSWER SURVEY", style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: Colors.white)),
                            ),
                          ),
                          SizedBox(height: 16.h),
                        ],

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildDot(0),
                            SizedBox(width: 6.w),
                            _buildDot(1),
                            SizedBox(width: 6.w),
                            _buildDot(2),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDot(int index) {
    bool isActive = _currentPage == index;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: isActive ? 24.w : 8.w,
      height: 4.h,
      decoration: BoxDecoration(
        color: isActive ? AppTheme.primaryBlue : Colors.grey[300],
        borderRadius: BorderRadius.circular(2.r),
      ),
    );
  }
}