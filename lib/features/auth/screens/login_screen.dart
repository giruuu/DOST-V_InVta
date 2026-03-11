import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Wrap everything in a Container with the gradient
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF00B4ED), // Bright Sky Blue
            Color(0xFFFFFFFF), // White
          ],
          stops: [0.0, 0.7],
        ),
      ),
      child: Scaffold(
        // 2. Make the Scaffold transparent so the background shows through
        backgroundColor: Colors.transparent,
        // Allows the content to scroll when the keyboard is open
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: Column(
              children: [
                SizedBox(height: 80.h),

                // Logo
                Image.asset(
                  'assets/images/DOST_logo_white.png',
                  height: 120.h,
                ),

                SizedBox(height: 40.h),

                // Header Text
                Text(
                  'SIGN IN',
                  style: TextStyle(
                    fontSize: 32.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF0079AD),
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Please enter your details below',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: const Color(0xFF0079AD),
                  ),
                ),

                SizedBox(height: 50.h),

                // Email Input
                _buildInputField(
                  hint: 'Enter your Email',
                  keyboardType: TextInputType.emailAddress,
                ),

                SizedBox(height: 16.h),

                // Password Input
                _buildInputField(
                  hint: 'Enter Password',
                  isPassword: true,
                  suffixIcon: Icons.visibility_off_outlined,
                ),

                // Forgot Password
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      'Forgot password?',
                      style: TextStyle(
                        color: const Color(0xFF00B4ED),
                        fontWeight: FontWeight.bold,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 20.h),

                // Sign In Button
                SizedBox(
                  width: double.infinity,
                  height: 55.h,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00B4ED),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Sign In',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 16.h),

                // Create New Account Button
                SizedBox(
                  width: double.infinity,
                  height: 55.h,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE1F5FE),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Create New Account',
                      style: TextStyle(
                        color: const Color(0xFF00B4ED),
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 40.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper method for Responsive Input Fields
  Widget _buildInputField({
    required String hint,
    bool isPassword = false,
    IconData? suffixIcon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15.r,
            offset: Offset(0, 5.h),
          ),
        ],
      ),
      child: TextField(
        obscureText: isPassword,
        keyboardType: keyboardType,
        style: TextStyle(fontSize: 16.sp, color: Colors.black87),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 16.sp),
          suffixIcon: suffixIcon != null
              ? Icon(suffixIcon, color: Colors.black45, size: 22.r)
              : null,
          contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
          border: InputBorder.none,
        ),
      ),
    );
  }
}