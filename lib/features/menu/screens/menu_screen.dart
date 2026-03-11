import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_theme.dart';
import 'package:go_router/go_router.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 40.h),

            // --- PROFILE SECTION ---
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50.r, // Slightly larger for full-screen
                    backgroundImage: const NetworkImage('https://picsum.photos/200'), // Placeholder
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    "Gian Russell Villegas",
                    style: TextStyle(
                      fontSize: 20.sp, // Scaled up slightly
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    "Registered",
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 40.h),
            Divider(color: Colors.grey.shade200, height: 1, thickness: 1),
            SizedBox(height: 10.h),

            // --- MENU ITEMS ---
            _buildMenuItem(
              icon: Icons.person_outline,
              title: "Profile",
              onTap: () => context.push('/profile'),
            ),
            _buildMenuItem(
              icon: Icons.vpn_key_outlined,
              title: "Change Password",
              onTap: () => print("Change Password Tapped"),
            ),

            // Pushes the Sign Out button to the very bottom
            const Spacer(),

            // --- SIGN OUT BUTTON ---
            _buildMenuItem(
              icon: Icons.logout,
              title: "Sign Out",
              onTap: () => print("Sign Out Tapped"),
              showChevron: false, // No arrow for sign out
            ),
            SizedBox(height: 20.h), // Bottom padding
          ],
        ),
      ),
    );
  }

  // Helper widget for full-screen menu items
  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool showChevron = true,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 18.h),
        child: Row(
          children: [
            Icon(icon, size: 28.w, color: Colors.black87),
            SizedBox(width: 16.w),
            Text(
              title,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const Spacer(),
            // Added a chevron arrow to make it look like a native settings menu
            if (showChevron)
              Icon(Icons.chevron_right, color: Colors.grey[400], size: 24.w),
          ],
        ),
      ),
    );
  }
}