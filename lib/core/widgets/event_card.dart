import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/app_theme.dart';

class EventCard extends StatelessWidget {
  final String title;
  final String description;
  final String date;
  final String time;
  final String? imageUrl;

  // Status Variables
  final String statusText;
  final Color statusTextColor;

  // Action Variables
  final String primaryButtonText;
  final VoidCallback? onPrimaryAction;
  final VoidCallback? onSeeMore;

  const EventCard({
    super.key,
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    this.imageUrl,
    this.statusText = "Incoming",
    this.statusTextColor = const Color(0xFFFFBF00),
    this.primaryButtonText = "REGISTER",
    this.onPrimaryAction,
    this.onSeeMore,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 24.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- 1. TOP SECTION: IMAGE & BADGE STACK ---
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
                child: SizedBox(
                  width: double.infinity,
                  height: 140.h,
                  child: imageUrl != null
                      ? CachedNetworkImage(
                    imageUrl: imageUrl!,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(color: Colors.grey[100]),
                    errorWidget: (context, url, error) => Image.asset('assets/images/DOST_Logo.png', fit: BoxFit.contain),
                  )
                      : Image.network('https://picsum.photos/800/400', fit: BoxFit.cover),
                ),
              ),

              // NEW: Dynamic Status Badge with Stroke and 30% Black Background
              Positioned(
                top: 12.h,
                right: 12.w,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: const Color(0x4D000000), // 4D in hex = 30% opacity, 000000 = Black
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(
                      color: statusTextColor, // The stroke uses your dynamic text color!
                      width: 1.w, // Stroke thickness
                    ),
                  ),
                  child: Text(
                    statusText,
                    style: TextStyle(
                      color: statusTextColor,
                      fontSize: 11.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),

          // --- 2. BOTTOM SECTION: TEXT & BUTTONS ---
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  title.toUpperCase(),
                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: AppTheme.primaryBlue),
                ),
                SizedBox(height: 8.h),

                // Description
                Text(
                  description,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 11.sp, color: Colors.grey[600], height: 1.5),
                ),
                SizedBox(height: 12.h),

                // Date and Time
                Row(
                  children: [
                    Text(date, style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.bold, color: Colors.grey[800])),
                    SizedBox(width: 24.w),
                    Text(time, style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.bold, color: Colors.grey[800])),
                  ],
                ),
                SizedBox(height: 16.h),

                // Action Buttons
                Align(
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // PRIMARY BUTTON
                      SizedBox(
                        height: 32.h,
                        width: 110.w,
                        child: ElevatedButton(
                          onPressed: onPrimaryAction ?? () => print("$primaryButtonText Tapped"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.primaryBlue,
                            elevation: 0,
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.r)),
                          ),
                          child: Text(primaryButtonText, style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.bold, color: Colors.white)),
                        ),
                      ),
                      SizedBox(width: 8.w),

                      // SEE MORE BUTTON
                      SizedBox(
                        height: 32.h,
                        width: 90.w,
                        child: OutlinedButton(
                          onPressed: onSeeMore,
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: AppTheme.primaryBlue),
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.r)),
                          ),
                          child: Text("SEE MORE", style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.bold, color: AppTheme.primaryBlue)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}