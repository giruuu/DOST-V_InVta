import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/app_theme.dart';

class EventCard extends StatelessWidget {
  final String title;
  final String description;
  final String date;
  final String time;
  final String imageUrl;
  final String statusText;
  final VoidCallback onSeeMore;
  final VoidCallback? onAction;
  final String? actionButtonText;

  const EventCard({
    super.key,
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    required this.imageUrl,
    required this.statusText,
    required this.onSeeMore,
    this.onAction,
    this.actionButtonText,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 16.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Responsive Image
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              height: 160.h, // Scaled height
              width: double.infinity,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(color: Colors.grey[200]),
              errorWidget: (context, url, error) => const Icon(Icons.broken_image),
            ),
          ),

          Padding(
            padding: EdgeInsets.all(12.w), // Scaled padding
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 2. Title with .sp
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontSize: 18.sp,
                  ),
                ),
                SizedBox(height: 4.h),

                // 3. Description
                Text(
                  description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 13.sp,
                  ),
                ),
                SizedBox(height: 12.h),

                // 4. Icons & Text Row
                Row(
                  children: [
                    Icon(Icons.calendar_today, size: 14.w, color: AppTheme.textLightGray),
                    SizedBox(width: 4.w),
                    Text(date, style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600)),
                    SizedBox(width: 16.w),
                    Icon(Icons.access_time, size: 14.w, color: AppTheme.textLightGray),
                    SizedBox(width: 4.w),
                    Text(time, style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600)),
                  ],
                ),
                SizedBox(height: 16.h),

                // 5. Status & Actions
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      statusText.toUpperCase(),
                      style: TextStyle(
                        color: AppTheme.alertRed,
                        fontWeight: FontWeight.bold,
                        fontSize: 12.sp,
                      ),
                    ),
                    Row(
                      children: [
                        if (onAction != null)
                          SizedBox(
                            height: 36.h,
                            child: ElevatedButton(
                              onPressed: onAction,
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(horizontal: 12.w),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                              ),
                              child: Text(actionButtonText ?? 'Action', style: TextStyle(fontSize: 12.sp)),
                            ),
                          ),
                        SizedBox(width: 8.w),
                        SizedBox(
                          height: 36.h,
                          child: OutlinedButton(
                            onPressed: onSeeMore,
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: AppTheme.primaryBlue),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                              padding: EdgeInsets.symmetric(horizontal: 12.w),
                            ),
                            child: Text('SEE MORE', style: TextStyle(color: AppTheme.primaryBlue, fontSize: 12.sp)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}