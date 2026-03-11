import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SignUpOTCPage extends StatefulWidget {
  const SignUpOTCPage({super.key});

  @override
  State<SignUpOTCPage> createState() => _SignUpOTCPageState();
}

class _SignUpOTCPageState extends State<SignUpOTCPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header Row: Back Button and Title
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios_new_rounded,
                        color: const Color(0xFF00B4ED), size: 24.r),
                    onPressed: () => context.pop(),
                  ),
                  Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF00B4ED),
                    ),
                  ),
                ],
              ),
            ),

            // Progress Indicators (Third bar is now active)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                children: [
                  Expanded(child: Container(height: 5.h, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(10.r)))),
                  SizedBox(width: 8.w),
                  Expanded(child: Container(height: 5.h, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(10.r)))),
                  SizedBox(width: 8.w),
                  Expanded(child: Container(height: 5.h, decoration: BoxDecoration(color: const Color(0xFF00B4ED), borderRadius: BorderRadius.circular(10.r)))),
                ],
              ),
            ),

            SizedBox(height: 30.h),

            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 25.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      'One-Time Code sent',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF0079AD), // Matches design image 7
                      ),
                    ),
                    SizedBox(height: 10.h),

                    // Subtitle Instructions
                    Text(
                      'Check your email inbox\nWe\'ve sent an email to sampleemail@gmail.com containing a 6-digit code',
                      style: TextStyle(fontSize: 13.sp, color: Colors.black87, height: 1.5),
                    ),
                    SizedBox(height: 25.h),

                    // Input Field Label
                    _buildLabel('Enter email code*'),
                    _buildInputField(hint: '6-digit code'),

                    SizedBox(height: 20.h),

                    // Resend Timer Placeholder
                    Center(
                      child: Text(
                        'Resend code in 02:59 seconds...',
                        style: TextStyle(fontSize: 13.sp, color: Colors.black54),
                      ),
                    ),

                    SizedBox(height: 20.h),

                    // Information Box (Blue Box from design)
                    Container(
                      padding: EdgeInsets.all(15.w),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE1F5FE).withOpacity(0.5),
                        border: Border.all(color: const Color(0xFF00B4ED).withOpacity(0.3)),
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.info_outline, color: const Color(0xFF00B4ED), size: 20.r),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                style: TextStyle(fontSize: 11.sp, color: const Color(0xFF00B4ED), height: 1.4),
                                children: const [
                                  TextSpan(text: 'Kindly wait for at least '),
                                  // FIXED: Wrapped FontWeight in TextStyle
                                  TextSpan(text: '3 minutes ', style: TextStyle(fontWeight: FontWeight.bold)),
                                  TextSpan(text: 'for your '),
                                  // FIXED: Wrapped FontWeight in TextStyle
                                  TextSpan(text: '6-digit code ', style: TextStyle(fontWeight: FontWeight.bold)),
                                  TextSpan(text: 'to arrive. Sometimes there may be delays when receiving it. Thank you for your patience!'),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 50.h),

                    // Next Button
                    SizedBox(
                      width: double.infinity,
                      height: 55.h,
                      child: ElevatedButton(
                        onPressed: () {
                          // Final submission logic
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF00B4ED),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                          elevation: 0,
                        ),
                        child: Text('Next',
                            style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.bold)),
                      ),
                    ),

                    SizedBox(height: 30.h),

                    // Footer Info
                    Center(
                      child: Column(
                        children: [
                          Text('Didn\'t receive the email?', style: TextStyle(fontSize: 12.sp, color: Colors.black54)),
                          Text('Try checking your junk or spam folders', style: TextStyle(fontSize: 12.sp, color: Colors.black54)),
                          SizedBox(height: 40.h),
                          RichText(
                            text: TextSpan(
                              style: TextStyle(fontSize: 13.sp, color: Colors.black),
                              children: [
                                const TextSpan(text: 'Not '),
                                TextSpan(text: 'email@gmail.com', style: TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                          TextButton(
                            onPressed: () => context.pop(),
                            child: Text('Edit email here', style: TextStyle(color: const Color(0xFF00B4ED), decoration: TextDecoration.underline)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper UI Methods
  Widget _buildLabel(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6.h),
      child: Text(text, style: TextStyle(fontSize: 13.sp, color: Colors.grey.shade700, fontWeight: FontWeight.w500)),
    );
  }

  Widget _buildInputField({required String hint}) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8.r)),
      child: TextField(
        keyboardType: TextInputType.number,
        style: TextStyle(fontSize: 15.sp),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey.shade400),
          contentPadding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r), borderSide: BorderSide(color: Colors.grey.shade300)),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r), borderSide: BorderSide(color: Colors.grey.shade300)),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r), borderSide: const BorderSide(color: Color(0xFF00B4ED))),
        ),
      ),
    );
  }
}