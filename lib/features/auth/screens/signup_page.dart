import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // Options for Dropdowns
  final List<String> suffixOptions = ['', 'Jr.', 'Sr.', 'II', 'III', 'IV', 'V'];
  String? selectedSuffix;

  final List<String> sexOptions = ['Male', 'Female'];
  String? selectedSex;

  final List<String> sectorOptions = [
    'MIS',
    'Scholarship',
    'ORD Office',
    'HR',
    'Accounting',
    'Other'
  ];
  String? selectedSector;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Solid white background as requested
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          children: [
            // Header: Back button and Title side-by-side
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

            // Progress Bars
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                children: [
                  Expanded(child: Container(height: 5.h, decoration: BoxDecoration(color: const Color(0xFF00B4ED), borderRadius: BorderRadius.circular(10.r)))),
                  SizedBox(width: 8.w),
                  Expanded(child: Container(height: 5.h, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(10.r)))),
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
                    // Section Title with Underline
                    Text(
                      'Please enter your details',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF0079AD),
                      ),
                    ),
                    SizedBox(height: 20.h),

                    _buildLabel('Enter first name*'),
                    _buildInputField(hint: 'First Name'),
                    SizedBox(height: 15.h),

                    // Middle Initial and Suffix Row
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildLabel('Enter middle initial*'),
                              _buildInputField(hint: 'Middle Initial'),
                            ],
                          ),
                        ),
                        SizedBox(width: 15.w),
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildLabel('Select Suffix'),
                              _buildDropdownField(
                                hint: 'Suffix',
                                value: selectedSuffix,
                                items: suffixOptions,
                                onChanged: (val) => setState(() => selectedSuffix = val),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15.h),

                    _buildLabel('Enter last name*'),
                    _buildInputField(hint: 'Last Name'),
                    SizedBox(height: 15.h),

                    _buildLabel('Enter email address*'),
                    _buildInputField(hint: 'Email Address', keyboardType: TextInputType.emailAddress),
                    SizedBox(height: 15.h),

                    // Sector and Sex Row
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildLabel('Select sector*'),
                              _buildDropdownField(
                                hint: 'Sector',
                                value: selectedSector,
                                items: sectorOptions,
                                onChanged: (val) => setState(() => selectedSector = val),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 15.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildLabel('Select sex*'),
                              _buildDropdownField(
                                hint: 'Sex',
                                value: selectedSex,
                                items: sexOptions,
                                onChanged: (val) => setState(() => selectedSex = val),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 50.h),

                    // Terms and Conditions
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Text(
                        'By tapping Next, you agree with the Terms and Conditions and Privacy Notice',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade600, height: 1.4),
                      ),
                    ),
                    SizedBox(height: 25.h),

                    // Create Account Button
                    SizedBox(
                      width: double.infinity,
                      height: 55.h,
                      child: ElevatedButton(
                        onPressed: () {
                          // This matches the path name you defined in your app_router.dart
                          context.push('/signup-password');
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

                    SizedBox(height: 20.h),
                    Row(
                      children: [
                        const Expanded(child: Divider(thickness: 1)),
                        Padding(padding: EdgeInsets.symmetric(horizontal: 10.w), child: Text("OR", style: TextStyle(color: Colors.grey, fontSize: 12.sp))),
                        const Expanded(child: Divider(thickness: 1)),
                      ],
                    ),
                    SizedBox(height: 20.h),

                    // Sign In Button
                    SizedBox(
                      width: double.infinity,
                      height: 55.h,
                      child: ElevatedButton(
                        onPressed: () => context.pop(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFE1F5FE),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                          elevation: 0,
                        ),
                        child: Text('Sign In',
                            style: TextStyle(color: const Color(0xFF00B4ED), fontSize: 16.sp, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    SizedBox(height: 40.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Helper Widgets ---

  Widget _buildLabel(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6.h),
      child: Text(text, style: TextStyle(fontSize: 13.sp, color: Colors.grey.shade700, fontWeight: FontWeight.w500)),
    );
  }

  Widget _buildInputField({required String hint, TextInputType keyboardType = TextInputType.text}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: TextField(
        keyboardType: keyboardType,
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

  // FIXED: Added isExpanded and set horizontal padding to 10.w to prevent Right Overflow
  Widget _buildDropdownField({required String hint, required String? value, required List<String> items, required Function(String?) onChanged}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: DropdownButtonFormField<String>(
        value: value,
        isExpanded: true, // Crucial for preventing overflow
        items: items.map((e) => DropdownMenuItem(
            value: e,
            child: Text(e, style: TextStyle(fontSize: 14.sp), overflow: TextOverflow.ellipsis)
        )).toList(),
        onChanged: onChanged,
        icon: Icon(Icons.keyboard_arrow_down_rounded, color: const Color(0xFF00B4ED)),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13.sp),
          contentPadding: EdgeInsets.symmetric(horizontal: 10.w), // Slightly reduced padding
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r), borderSide: BorderSide(color: Colors.grey.shade300)),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r), borderSide: BorderSide(color: Colors.grey.shade300)),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r), borderSide: const BorderSide(color: Color(0xFF00B4ED))),
        ),
      ),
    );
  }
}