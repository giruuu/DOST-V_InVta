import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_theme.dart';

class AnnouncementsScreen extends StatelessWidget {
  const AnnouncementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Header
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: Row(
                children: [
                  Icon(Icons.arrow_back_ios, color: AppTheme.primaryBlue, size: 20.w),
                  Text(
                    "Announcements",
                    style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: AppTheme.primaryBlue),
                  ),
                ],
              ),
            ),

            // 2. Expandable List
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                children: [
                  _buildDateHeader("Today"),
                  const AnnouncementTile(
                    title: "Announcement Title",
                    body: "Announcement message here: ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullam",
                    timestamp: "Just Now",
                    isInitiallyExpanded: true, // Matches your Figma showing the top one open
                  ),
                  const AnnouncementTile(
                    title: "Announcement Title",
                    body: "Short update regarding the recent system maintenance.",
                    timestamp: "20mins ago",
                  ),

                  SizedBox(height: 16.h),
                  _buildDateHeader("Yesterday"),
                  const AnnouncementTile(
                    title: "Announcement Title",
                    body: "Please ensure your profiles are fully updated by Friday.",
                    timestamp: "8:30 PM",
                  ),
                  const AnnouncementTile(
                    title: "Announcement Title",
                    body: "The upcoming DOST seminar has a new venue.",
                    timestamp: "8:30 PM",
                  ),

                  SizedBox(height: 16.h),
                  _buildDateHeader("March 4, 2026"),
                  const AnnouncementTile(
                    title: "Announcement Title",
                    body: "Welcome to the InVta platform! Explore your dashboard.",
                    timestamp: "8:30 PM",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper for the gray date text
  Widget _buildDateHeader(String date) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Text(
        date,
        style: TextStyle(fontSize: 12.sp, color: Colors.grey[500], fontWeight: FontWeight.w500),
      ),
    );
  }
}

// =========================================================================
// CUSTOM EXPANDABLE TILE
// =========================================================================
class AnnouncementTile extends StatefulWidget {
  final String title;
  final String body;
  final String timestamp;
  final bool isInitiallyExpanded;

  const AnnouncementTile({
    super.key,
    required this.title,
    required this.body,
    required this.timestamp,
    this.isInitiallyExpanded = false,
  });

  @override
  State<AnnouncementTile> createState() => _AnnouncementTileState();
}

class _AnnouncementTileState extends State<AnnouncementTile> {
  late bool _isExpanded;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.isInitiallyExpanded;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: EdgeInsets.only(bottom: 8.h),
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6.r),
          // Light blue border matching Figma
          border: Border.all(color: AppTheme.primaryBlue.withOpacity(0.5)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TOP ROW
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold, color: Colors.black87),
                ),
                Row(
                  children: [
                    // Only show time here if COLLAPSED
                    if (!_isExpanded)
                      Text(
                        widget.timestamp,
                        style: TextStyle(fontSize: 10.sp, color: Colors.grey[600], fontWeight: FontWeight.bold),
                      ),
                    SizedBox(width: 8.w),
                    Icon(
                      _isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                      color: AppTheme.primaryBlue,
                      size: 20.w,
                    ),
                  ],
                ),
              ],
            ),

            // EXPANDED BODY
            if (_isExpanded) ...[
              SizedBox(height: 12.h),
              Text(
                widget.body,
                style: TextStyle(fontSize: 12.sp, color: Colors.grey[800], height: 1.4),
              ),
              SizedBox(height: 12.h),
              // Show time here if EXPANDED
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  widget.timestamp,
                  style: TextStyle(fontSize: 10.sp, color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}