import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_theme.dart';

class OtherEventsTab extends StatelessWidget {
  const OtherEventsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 1. ADDED THE MISSING TITLE HERE
        SizedBox(height: 24.h),
        Text(
          "OTHER EVENTS",
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: AppTheme.primaryBlue,
          ),
        ),
        SizedBox(height: 16.h),

        // 2. Wrapped the ListView in an Expanded so it takes the remaining space
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 24.w), // Adjusted padding
            itemCount: 4,
            itemBuilder: (context, index) {
              bool isExhibit = index % 2 != 0;
              return Container(
                margin: EdgeInsets.only(bottom: 16.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: Colors.grey.shade200),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 4, offset: const Offset(0, 2))],
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(12.w),
                      child: Image.asset('assets/images/DOST_Logo.png', width: 40.w, height: 40.w),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("PHIVOLCS", style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: AppTheme.primaryBlue)),
                            SizedBox(height: 4.h),
                            Text("Lorem ipsum dolor sit amet...", style: TextStyle(fontSize: 10.sp, color: Colors.grey[600])),
                            SizedBox(height: 8.h),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                              decoration: BoxDecoration(
                                color: isExhibit ? Colors.orange : AppTheme.primaryBlue,
                                borderRadius: BorderRadius.circular(4.r),
                              ),
                              child: Text(isExhibit ? "EXHIBIT" : "SUB-EVENT", style: TextStyle(color: Colors.white, fontSize: 9.sp, fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: 30.w,
                      height: 100.h,
                      decoration: BoxDecoration(
                        color: AppTheme.primaryBlue,
                        borderRadius: BorderRadius.only(topRight: Radius.circular(12.r), bottomRight: Radius.circular(12.r)),
                      ),
                      child: const Icon(Icons.chevron_right, color: Colors.white),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}