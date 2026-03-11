import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // 1. Track the selected avatar (Default to the first one: index 0)
  int _selectedAvatarIndex = 0;

  // 2. A list of preselected avatar images (Using Pravatar for random faces)
  final List<String> _avatarOptions = [
    'https://i.pravatar.cc/150?img=11',
    'https://i.pravatar.cc/150?img=12',
    'https://i.pravatar.cc/150?img=33',
    'https://i.pravatar.cc/150?img=14',
    'https://i.pravatar.cc/150?img=15',
    'https://i.pravatar.cc/150?img=68',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: AppTheme.primaryBlue, size: 20.w),
          onTap: () => context.pop(),
        ),
        title: Text(
          "My Profile",
          style: TextStyle(color: AppTheme.primaryBlue, fontSize: 18.sp, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- AVATAR SELECTION SECTION ---
            Center(
              child: Text(
                "Choose your Avatar",
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
            ),
            SizedBox(height: 16.h),

            // Horizontal list of avatars
            SizedBox(
              height: 90.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _avatarOptions.length,
                itemBuilder: (context, index) {
                  bool isSelected = _selectedAvatarIndex == index;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedAvatarIndex = index; // Update selected avatar
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: EdgeInsets.only(right: 16.w),
                      padding: EdgeInsets.all(isSelected ? 4.w : 0), // Padding creates the border gap
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isSelected ? AppTheme.primaryBlue : Colors.transparent,
                          width: 3.w,
                        ),
                      ),
                      child: CircleAvatar(
                        radius: 35.r,
                        backgroundImage: NetworkImage(_avatarOptions[index]),
                      ),
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: 40.h),

            // --- USER INFO FORM ---
            Text(
              "Personal Information",
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: AppTheme.primaryBlue),
            ),
            SizedBox(height: 20.h),

            _buildTextField("Full Name", "Gian Russell D. Villegas"),
            SizedBox(height: 16.h),
            _buildTextField("Email Address", "villegasgianrussell@gmail.com"),
            SizedBox(height: 16.h),
            _buildTextField("Location", "Tabaco City, Albay"),
            SizedBox(height: 16.h),
            _buildTextField("University / Organization", "Bicol University"),

            SizedBox(height: 40.h),

            // --- SAVE BUTTON ---
            SizedBox(
              width: double.infinity,
              height: 50.h,
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Connect to Dio to update backend
                  print("Saved Avatar Index: $_selectedAvatarIndex");
                  context.pop(); // Go back after saving
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryBlue,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                ),
                child: Text("SAVE CHANGES", style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  // Helper widget for clean form fields
  Widget _buildTextField(String label, String initialValue) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold, color: Colors.grey[600]),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          initialValue: initialValue,
          style: TextStyle(fontSize: 14.sp, color: Colors.black87),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            filled: true,
            fillColor: Colors.grey.shade50,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(color: AppTheme.primaryBlue),
            ),
          ),
        ),
      ],
    );
  }
}