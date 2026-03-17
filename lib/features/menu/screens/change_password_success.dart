import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ChangePasswordSuccessScreen extends StatelessWidget {
  const ChangePasswordSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryBlue = Color(0xFF53A8E6);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),

              // Success Text
              Text(
                'Password successfully\nChanged',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                  color: primaryBlue,
                  height: 1.3,
                ),
              ),

              SizedBox(height: 60.h),

              // Sign in Button
              SizedBox(
                width: double.infinity,
                height: 50.h,
                child: ElevatedButton(
                  onPressed: () {
                    // Send them back to the login screen!
                    context.go('/login');
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: primaryBlue,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                      elevation: 0
                  ),
                  child: Text('Sign in', style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.bold)),
                ),
              ),
              SizedBox(height: 15.h),

              // Footer text
              Text(
                "You'll be sign out to your account pls login again\nThank you.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 11.sp, color: Colors.black87, height: 1.5),
              ),

              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}