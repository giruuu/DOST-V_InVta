import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SignUpPasswordScreen extends StatefulWidget {
  const SignUpPasswordScreen({super.key});

  @override
  State<SignUpPasswordScreen> createState() => _SignUpPasswordScreenState();
}

class _SignUpPasswordScreenState extends State<SignUpPasswordScreen> {
  // State for toggling password visibility
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
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

            // Progress Indicators (Second bar is now active)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                children: [
                  Expanded(child: Container(height: 5.h, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(10.r)))),
                  SizedBox(width: 8.w),
                  Expanded(child: Container(height: 5.h, decoration: BoxDecoration(color: const Color(0xFF00B4ED), borderRadius: BorderRadius.circular(10.r)))),
                  SizedBox(width: 8.w),
                  Expanded(child: Container(height: 5.h, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(10.r)))),
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
                    // Page Title
                    Text(
                      'Please enter your password',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF0079AD), // Matches design image 7
                      ),
                    ),
                    SizedBox(height: 25.h),

                    // Password Field
                    _buildLabel('Enter password*'),
                    _buildPasswordField(
                      hint: 'Password',
                      obscureText: _obscurePassword,
                      onToggle: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                    SizedBox(height: 20.h),

                    // Confirm Password Field
                    _buildLabel('Confirm password*'),
                    _buildPasswordField(
                      hint: 'Confirm Password',
                      obscureText: _obscureConfirmPassword,
                      onToggle: () {
                        setState(() {
                          _obscureConfirmPassword = !_obscureConfirmPassword;
                        });
                      },
                    ),

                    SizedBox(height: 150.h), // Spacing to push button down like the design

                    // Next Button
                    // Inside SignUpPasswordScreen
                    SizedBox(
                      width: double.infinity,
                      height: 55.h,
                      child: ElevatedButton(
                        onPressed: () {
                          // Navigates to the Step 3 (OTC) page
                          context.push('/signup-otc');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF00B4ED),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          'Next',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
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

  // Helper for Labels
  Widget _buildLabel(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6.h),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 13.sp,
          color: Colors.grey.shade700,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  // Helper for Password Fields with Visibility Toggle
  Widget _buildPasswordField({
    required String hint,
    required bool obscureText,
    required VoidCallback onToggle,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: TextField(
        obscureText: obscureText,
        style: TextStyle(fontSize: 15.sp),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey.shade400),
          contentPadding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
          suffixIcon: IconButton(
            icon: Icon(
              obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
              color: Colors.grey,
            ),
            onPressed: onToggle,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: const BorderSide(color: Color(0xFF00B4ED)),
          ),
        ),
      ),
    );
  }
}