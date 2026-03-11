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
  final String statusText;
  final VoidCallback? onSeeMore;

  const EventCard({
    super.key,
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    this.imageUrl, // Nullable
    this.statusText = "MAIN EVENT", // Default value
    this.onSeeMore, // Optional callback
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(12.w),
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
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Image Section (Asset fallback if imageUrl is null)
              ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: SizedBox(
                  width: 85.w,
                  height: 85.w,
                  child: imageUrl != null
                      ? CachedNetworkImage(
                    imageUrl: imageUrl!,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(color: Colors.grey[100]),
                    errorWidget: (context, url, error) => Image.asset('assets/images/DOST_Logo.png'),
                  )
                      : Image.asset('assets/images/DOST_Logo.png', fit: BoxFit.contain),
                ),
              ),
              SizedBox(width: 12.w),

              // 2. Content Section
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title.toUpperCase(),
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryBlue,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      description,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 11.sp, color: Colors.grey[600], height: 1.3),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      "$date   $time",
                      style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.bold, color: Colors.black87),
                    ),
                    SizedBox(height: 8.h),

                    // Status Badge
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryBlue,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Text(
                        statusText.toUpperCase(),
                        style: TextStyle(color: Colors.white, fontSize: 9.sp, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // 3. Action Button
          // 3. Action Button
          Align(
            alignment: Alignment.centerRight,
            child: OutlinedButton(
              // FIX: Just pass the 'onSeeMore' variable here!
              onPressed: onSeeMore,
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppTheme.primaryBlue),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                minimumSize: Size(100.w, 32.h),
                padding: EdgeInsets.symmetric(horizontal: 16.w),
              ),
              child: Text(
                "SEE MORE",
                style: TextStyle(fontSize: 11.sp, color: AppTheme.primaryBlue, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}