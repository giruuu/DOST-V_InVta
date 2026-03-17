import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ChangePasswordNewScreen extends StatefulWidget {
  const ChangePasswordNewScreen({super.key});

  @override
  State<ChangePasswordNewScreen> createState() => _ChangePasswordNewScreenState();
}

class _ChangePasswordNewScreenState extends State<ChangePasswordNewScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirm = true;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const primaryBlue = Color(0xFF53A8E6);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.h),
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

              Text('Enter New Password', style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold, color: Colors.black)),
              SizedBox(height: 25.h),

              _buildLabel('Enter password'),
              _buildPasswordField(
                hint: 'Password',
                controller: _passwordController,
                obscureText: _obscurePassword,
                onToggle: () => setState(() => _obscurePassword = !_obscurePassword),
              ),
              SizedBox(height: 20.h),

              _buildLabel('Confirm password'),
              _buildPasswordField(
                hint: 'Confirm Password',
                controller: _confirmController,
                obscureText: _obscureConfirm,
                onToggle: () => setState(() => _obscureConfirm = !_obscureConfirm),
              ),
              SizedBox(height: 40.h),

              SizedBox(
                width: double.infinity,
                height: 50.h,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to Success screen
                    context.push('/change-password-success');
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

              Center(
                child: Text('Call our hotline or email us for assistance', style: TextStyle(fontSize: 11.sp, color: Colors.black87)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Text(text, style: TextStyle(fontSize: 12.sp, color: Colors.black87)),
    );
  }

  Widget _buildPasswordField({required String hint, required TextEditingController controller, required bool obscureText, required VoidCallback onToggle}) {
    return SizedBox(
      height: 48.h,
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        style: TextStyle(fontSize: 14.sp),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13.sp),
          contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
          suffixIcon: IconButton(
            icon: Icon(obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined, color: Colors.grey.shade400, size: 20.r),
            onPressed: onToggle,
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r), borderSide: BorderSide(color: Colors.grey.shade300)),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r), borderSide: BorderSide(color: Colors.grey.shade300)),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r), borderSide: const BorderSide(color: Color(0xFF53A8E6))),
        ),
      ),
    );
  }
}