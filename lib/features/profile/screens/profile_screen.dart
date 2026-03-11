import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_flutter/qr_flutter.dart'; // Import the new package
import '../../../core/theme/app_theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy user data for the ID badge
    final String userName = "Gian Russell Villegas";
    final String userStatus = "REGISTERED";
    final String userIdString = "INVTA-USER-89234"; // This is what the QR code will store!

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5), // Light grey background to make the card pop
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: AppTheme.primaryBlue, size: 20.w),
          onPressed: () => context.pop(),
        ),
        title: Text(
          "My Digital ID",
          style: TextStyle(color: AppTheme.primaryBlue, fontSize: 18.sp, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // --- THE ID BADGE CARD ---
              Container(
                width: 300.w,
                padding: EdgeInsets.symmetric(vertical: 32.h, horizontal: 24.w),
                decoration: BoxDecoration(
                  // We'll use a gradient similar to your mockup, but refined
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppTheme.primaryBlue,
                      const Color(0xFF005b9f), // A slightly darker shade of your primary blue
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20.r),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.primaryBlue.withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    )
                  ],
                ),
                child: Column(
                  children: [
                    // User Avatar
                    Container(
                      padding: EdgeInsets.all(4.w),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: CircleAvatar(
                        radius: 40.r,
                        backgroundImage: const NetworkImage('https://i.pravatar.cc/150?img=11'),
                        backgroundColor: Colors.grey[200],
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // User Name
                    Text(
                      userName,
                      style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 24.h),

                    // The QR Code (Dynamically Generated!)
                    Container(
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: QrImageView(
                        data: userIdString, // The actual data embedded in the QR
                        version: QrVersions.auto,
                        size: 180.w,
                        backgroundColor: Colors.white,
                      ),
                    ),
                    SizedBox(height: 24.h),

                    // Status Text
                    Text(
                      userStatus,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 2.0, // Adds nice spacing for status labels
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 40.h),

              // Helper text underneath the card
              Text(
                "Present this QR code to marshals\nfor event check-ins and surveys.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey[600],
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}