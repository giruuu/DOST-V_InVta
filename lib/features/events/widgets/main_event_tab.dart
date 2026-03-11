import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_theme.dart';

class MainEventTab extends StatelessWidget {
  const MainEventTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
            decoration: BoxDecoration(color: AppTheme.primaryBlue, borderRadius: BorderRadius.circular(6.r)),
            child: Text("Main Event", style: TextStyle(color: Colors.white, fontSize: 11.sp, fontWeight: FontWeight.bold)),
          ),
          SizedBox(height: 24.h),
          Text("About this Event", style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: AppTheme.primaryBlue)),
          SizedBox(height: 8.h),
          Text(
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
            style: TextStyle(fontSize: 11.sp, color: Colors.grey[600], height: 1.5),
          ),
          SizedBox(height: 24.h),
          Text("Organizers", style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: AppTheme.primaryBlue)),
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
    );
  }
}