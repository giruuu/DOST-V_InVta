import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../core/theme/app_theme.dart';

class SubEventDetailsScreen extends StatelessWidget {
  final bool isExhibit;

  const SubEventDetailsScreen({super.key, required this.isExhibit});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // 1. BACKGROUND BANNER IMAGE
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

          // 2. BACK BUTTON
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

          // 3. OVERLAPPING WHITE SHEET
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
                  // Scrollable Content
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.all(24.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("EVENT NAME", style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold, color: AppTheme.primaryBlue)),
                          SizedBox(height: 16.h),

                          Row(
                            children: [
                              Icon(Icons.location_on_outlined, size: 18.w, color: Colors.grey[700]),
                              SizedBox(width: 8.w),
                              Text("DOST REGION V OFFICE", style: TextStyle(fontSize: 11.sp, color: Colors.grey[700])),
                            ],
                          ),
                          SizedBox(height: 8.h),

                          Row(
                            children: [
                              Icon(Icons.calendar_today_outlined, size: 16.w, color: Colors.grey[700]),
                              SizedBox(width: 8.w),
                              Text("Wed, Jan 21 2026", style: TextStyle(fontSize: 11.sp, color: Colors.grey[700])),
                              SizedBox(width: 24.w),
                              Text("06:16 PM", style: TextStyle(fontSize: 11.sp, color: Colors.grey[700], fontWeight: FontWeight.bold)),
                            ],
                          ),
                          SizedBox(height: 16.h),

                          // DYNAMIC BADGE (White pill with shadow)
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6.r),
                              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 4, offset: const Offset(0, 2))],
                            ),
                            child: Text(
                                isExhibit ? "EXHIBIT" : "SUB-EVENT",
                                style: TextStyle(color: AppTheme.primaryBlue, fontSize: 11.sp, fontWeight: FontWeight.bold)
                            ),
                          ),
                          SizedBox(height: 24.h),

                          Text("About this Event", style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: AppTheme.primaryBlue)),
                          SizedBox(height: 8.h),
                          Text(
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                            style: TextStyle(fontSize: 11.sp, color: Colors.grey[600], height: 1.5),
                          ),
                          SizedBox(height: 24.h),

                          // DYNAMIC LABEL (Company vs Organizers)
                          Text(
                              isExhibit ? "Company" : "Organizers",
                              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: AppTheme.primaryBlue)
                          ),
                          SizedBox(height: 12.h),

                          Row(
                            children: [
                              Image.asset('assets/images/DOST_Logo.png', width: 40.w, height: 40.w),
                              SizedBox(width: 12.w),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("DOST", style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold)),
                                  Text("DOST REGION V OFFICE", style: TextStyle(fontSize: 10.sp, color: Colors.grey[700])),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  // BOTTOM ACTION BUTTON
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                    decoration: const BoxDecoration(color: Colors.white),
                    child: SizedBox(
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
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}