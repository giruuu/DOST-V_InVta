import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';

class ChangePasswordVerifyScreen extends StatefulWidget {
  final String email; // Pass the email here so it shows in the text

  const ChangePasswordVerifyScreen({super.key, required this.email});

  @override
  State<ChangePasswordVerifyScreen> createState() => _ChangePasswordVerifyScreenState();
}

class _ChangePasswordVerifyScreenState extends State<ChangePasswordVerifyScreen> {
  final TextEditingController _otpController = TextEditingController();

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Matching the blue from your design
    const primaryBlue = Color(0xFF53A8E6);

    final defaultPinTheme = PinTheme(
      width: 50.w,
      height: 55.h,
      textStyle: TextStyle(fontSize: 20.sp, color: Colors.black, fontWeight: FontWeight.bold),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFBBE1FA)), // Light blue border
        borderRadius: BorderRadius.circular(8.r),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.h),
              // Back Button & Title
              GestureDetector(
                onTap: () => context.pop(),
                child: Row(
                  children: [
                    Icon(Icons.arrow_back_ios_new_rounded, color: primaryBlue, size: 18.r),
                    SizedBox(width: 5.w),
                    Text('Change Password', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: primaryBlue)),
                  ],
                ),
              ),
              SizedBox(height: 40.h),

              // Header Text
              Text('Verification Code', style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold, color: Colors.black)),
              SizedBox(height: 20.h),

              Text(
                  'We sent a verification code to your email address\n${widget.email}',
                  style: TextStyle(fontSize: 13.sp, color: Colors.black87, height: 1.5)
              ),
              SizedBox(height: 30.h),

              // Pinput OTP Fields
              Center(
                child: Pinput(
                  length: 6,
                  controller: _otpController,
                  defaultPinTheme: defaultPinTheme,
                  focusedPinTheme: defaultPinTheme.copyDecorationWith(
                    border: Border.all(color: primaryBlue, width: 2),
                  ),
                ),
              ),
              SizedBox(height: 15.h),

              // Timer Text
              Text('Resend code in 4m 59s', style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade600)),
              SizedBox(height: 30.h),

              // Confirm Button
              SizedBox(
                width: double.infinity,
                height: 50.h,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to the New Password screen
                    context.push('/change-password-new');
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: primaryBlue,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                      elevation: 0
                  ),
                  child: Text('Confirm', style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.bold)),
                ),
              ),
              SizedBox(height: 15.h),

              // Footer Text
              Center(
                child: Text('Call our hotline or email us for assistance', style: TextStyle(fontSize: 11.sp, color: Colors.black87)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}