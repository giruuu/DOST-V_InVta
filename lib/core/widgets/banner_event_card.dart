import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/app_theme.dart';

class BannerEventCard extends StatelessWidget {
  final String title;
  final String description;
  final String date;
  final String time;
  final String statusText;
  final Color statusColor; // Added for dynamic status colors
  final String primaryActionText; // Added for dynamic button text
  final VoidCallback? onPrimaryAction; // Nullable to allow disabled state
  final VoidCallback onSeeMore;
  final String? imageUrl;

  const BannerEventCard({
    super.key,
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    required this.statusText,
    required this.statusColor,
    required this.primaryActionText,
    this.onPrimaryAction,
    required this.onSeeMore,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350.h,
      margin: EdgeInsets.only(bottom: 20.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ==========================================================
          // PART 1: TOP IMAGE (40%)
          // ==========================================================
          Expanded(
            flex: 4,
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
              child: SizedBox(
                width: double.infinity,
                child: imageUrl != null
                    ? CachedNetworkImage(
                  imageUrl: imageUrl!,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(color: Colors.grey[200]),
                  errorWidget: (context, url, error) => _buildPlaceholder(),
                )
                    : _buildPlaceholder(),
              ),
            ),
          ),

          // ==========================================================
          // PART 2: INFO FIELD (60%)
          // ==========================================================
          Expanded(
            flex: 6,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title.toUpperCase(),
                    style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: AppTheme.primaryBlue),
                  ),
                  SizedBox(height: 8.h),
                  Expanded(
                    child: Text(
                      description,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 12.sp, color: Colors.grey[600], height: 1.45),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    children: [
                      Text(date, style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold)),
                      SizedBox(width: 24.w),
                      Text(time, style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  SizedBox(height: 16.h),

                  // Status and Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // Dynamic Status Text Color
                      Text(
                        statusText,
                        style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold, color: statusColor),
                      ),

                      Column(
                        children: [
                          SizedBox(
                            width: 120.w,
                            height: 32.h,
                            child: ElevatedButton(
                              onPressed: onPrimaryAction, // If null, button disables automatically
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppTheme.primaryBlue,
                                disabledBackgroundColor: Colors.grey[400], // The grey color from your design
                                disabledForegroundColor: Colors.white,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.r)),
                                padding: EdgeInsets.zero,
                              ),
                              child: Text(primaryActionText, style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.bold)),
                            ),
                          ),
                          SizedBox(height: 8.h),
                          SizedBox(
                            width: 120.w,
                            height: 32.h,
                            child: OutlinedButton(
                              onPressed: onSeeMore,
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: AppTheme.primaryBlue),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.r)),
                                padding: EdgeInsets.zero,
                              ),
                              child: Text("SEE MORE", style: TextStyle(fontSize: 10.sp, color: AppTheme.primaryBlue)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      color: Colors.grey[200],
      child: Center(child: Image.asset('assets/images/DOST_Logo.png', width: 80.w, fit: BoxFit.contain)),
    );
  }
}