import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/app_theme.dart';

class BannerEventCard extends StatelessWidget {
  final String title;
  final String description;
  final String date;
  final String time;
  final String? imageUrl;
  final String statusText;
  final Color statusColor;
  final String primaryButtonText;
  final VoidCallback? onPrimaryAction;
  final VoidCallback? onSeeMore;

  const BannerEventCard({
    super.key,
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    this.imageUrl,
    required this.statusText,
    required this.statusColor,
    required this.primaryButtonText,
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
                    errorWidget: (context, url, error) => Container(color: Colors.grey[200]),
                  )
                      : Container(color: Colors.grey[300]),
                ),
              ),
              Positioned(
                top: 12.h,
                right: 12.w,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: const Color(0x4D000000), // 30% Opacity Black
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(color: statusColor, width: 1.w),
                  ),
                  child: Text(
                    statusText,
                    style: TextStyle(
                      color: statusColor,
                      fontSize: 11.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title.toUpperCase(),
                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: AppTheme.primaryBlue),
                ),
                SizedBox(height: 8.h),
                Text(
                  description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 11.sp, color: Colors.grey[600], height: 1.4),
                ),
                SizedBox(height: 12.h),
                Row(
                  children: [
                    Text(date, style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.bold, color: Colors.grey[800])),
                    SizedBox(width: 24.w),
                    Text(time, style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.bold, color: Colors.grey[800])),
                  ],
                ),
                SizedBox(height: 16.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // PRIMARY BUTTON - FIXED HEIGHT & PADDING
                    SizedBox(
                      height: 40.h,
                      width: 125.w,
                      child: ElevatedButton(
                        onPressed: onPrimaryAction,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primaryBlue,
                          disabledBackgroundColor: Colors.grey[300],
                          elevation: 0,
                          padding: EdgeInsets.zero, // Important to prevent clipping
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                        ),
                        child: Text(
                            primaryButtonText,
                            style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.bold, color: Colors.white)
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    // SEE MORE BUTTON - FIXED HEIGHT & PADDING
                    SizedBox(
                      height: 40.h,
                      width: 100.w,
                      child: OutlinedButton(
                        onPressed: onSeeMore,
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: AppTheme.primaryBlue),
                          padding: EdgeInsets.zero, // Important to prevent clipping
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                        ),
                        child: Text(
                            "SEE MORE",
                            style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.bold, color: AppTheme.primaryBlue)
                        ),
                      ),
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