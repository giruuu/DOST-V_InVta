import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_theme.dart';
import 'package:go_router/go_router.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  // State variable to hold the currently selected profile picture
  String _currentProfilePic = 'assets/profiles/profile_1.jpg';

  // A sleek dark blue color for the text of the menu items
  final Color _darkBlueText = const Color(0xFF003366);

  // The exact file names from your assets folder
  final List<String> _availableProfiles = [
    'assets/profiles/profile_1.jpg',
    'assets/profiles/profile_2.jpeg',
    'assets/profiles/profile_3.jpeg',
    'assets/profiles/profile_4.jpeg',
    'assets/profiles/profile_5.jpeg',
    'assets/profiles/profile_6.jpeg',
    'assets/profiles/profile_7.jpeg',
    'assets/profiles/profile_8.jpeg',
  ];

  // Function to show the Bottom Sheet selector
  void _showProfilePictureSelector() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (BuildContext context) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Choose Profile Picture",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: _darkBlueText,
                  ),
                ),
                SizedBox(height: 20.h),

                // Grid of options
                Flexible(
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 10.w,
                      mainAxisSpacing: 10.h,
                    ),
                    itemCount: _availableProfiles.length,
                    itemBuilder: (context, index) {
                      final imagePath = _availableProfiles[index];
                      final isSelected = _currentProfilePic == imagePath;

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _currentProfilePic = imagePath;
                          });
                          Navigator.pop(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isSelected ? AppTheme.primaryBlue : Colors.transparent,
                              width: 3.w,
                            ),
                          ),
                          child: CircleAvatar(
                            backgroundImage: AssetImage(imagePath),
                            backgroundColor: Colors.grey[200],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            // padding.top pushes the content down below the iPhone notch/status bar
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 20.h,
                bottom: 30.h
            ),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppTheme.primaryBlue,
                    const Color(0xFF005b9f), // Darker vibrant blue
                  ],
                ),
                // Gives the bottom of the header a nice smooth curve
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30.r),
                  bottomRight: Radius.circular(30.r),
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.primaryBlue.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  )
                ]
            ),
            child: Column(
              children: [
                // --- INTERACTIVE AVATAR ---
                GestureDetector(
                  onTap: _showProfilePictureSelector,
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Container(
                        padding: EdgeInsets.all(4.w), // Creates a white border effect
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: CircleAvatar(
                          radius: 46.r,
                          backgroundImage: AssetImage(_currentProfilePic),
                          backgroundColor: Colors.grey[200],
                        ),
                      ),
                      // Edit badge icon
                      Container(
                        padding: EdgeInsets.all(6.w),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.15),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              )
                            ]
                        ),
                        child: Icon(Icons.edit, size: 16.w, color: AppTheme.primaryBlue),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 16.h),
                Text(
                  "Gian Russell Villegas",
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Changed to White
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  "Registered",
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.white.withOpacity(0.85), // Soft white
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 10.h), // Replaced the divider with simple spacing

          // --- MENU ITEMS ---
          Expanded(
            child: Column(
              children: [
                _buildMenuItem(
                  icon: Icons.qr_code_2_outlined,
                  title: "Digital ID",
                  onTap: () {
                    context.push('/profile', extra: _currentProfilePic);
                  },
                ),

                _buildMenuItem(
                  icon: Icons.vpn_key_outlined,
                  title: "Change Password",
                  onTap: () {
                    String userEmail = "villegasgianrussell@gmail.com";
                    context.push('/change-password-verify', extra: userEmail);
                  },
                ),

                const Spacer(),

                // --- SIGN OUT BUTTON ---
                _buildMenuItem(
                  icon: Icons.logout,
                  title: "Sign Out",
                  onTap: () => print("Sign Out Tapped"),
                  showChevron: false,
                  isSignOut: true,
                ),
                // Ensure the bottom accounts for the home indicator
                SizedBox(height: MediaQuery.of(context).padding.bottom + 20.h),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper widget for full-screen menu items
  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool showChevron = true,
    bool isSignOut = false,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 18.h),
        child: Row(
          children: [
            Icon(icon, size: 28.w, color: isSignOut ? Colors.redAccent : AppTheme.primaryBlue),
            SizedBox(width: 16.w),
            Text(
              title,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: isSignOut ? Colors.redAccent : _darkBlueText,
              ),
            ),
            const Spacer(),
            if (showChevron)
              Icon(Icons.chevron_right, color: AppTheme.primaryBlue.withOpacity(0.4), size: 24.w),
          ],
        ),
      ),
    );
  }
}