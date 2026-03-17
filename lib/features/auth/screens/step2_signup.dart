import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../services/auth_service.dart'; // 1. IMPORT YOUR SERVICE

class SignUpPasswordScreen extends StatefulWidget {
  final Map<String, dynamic> userData;

  const SignUpPasswordScreen({super.key, required this.userData});

  @override
  State<SignUpPasswordScreen> createState() => _SignUpPasswordScreenState();
}

class _SignUpPasswordScreenState extends State<SignUpPasswordScreen> {
  final AuthService _authService = AuthService(); // 2. INSTANTIATE SERVICE
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false; // 3. ADD LOADING STATE

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  // --- SUBMIT LOGIC ---
  Future<void> _handleNext() async {
    // 1. Validate
    if (_passwordController.text.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Password must be at least 6 characters'), backgroundColor: Colors.orange));
      return;
    }
    if (_passwordController.text != _confirmController.text) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Passwords do not match'), backgroundColor: Colors.red));
      return;
    }

    // 2. Start Loading
    setState(() => _isLoading = true);

    // 3. CALL LARAVEL TO SEND THE EMAIL!
    bool isSuccess = await _authService.sendOtp(widget.userData['email']);

    if (mounted) {
      setState(() => _isLoading = false);

      if (isSuccess) {
        // 4. If email sent successfully, combine data and go to Step 3
        Map<String, dynamic> combinedData = Map.from(widget.userData);
        combinedData['password'] = _passwordController.text;

        context.push('/signup-otc', extra: combinedData);
      } else {
        // 5. If Laravel blocked it (e.g., email already exists)
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to send code. Email might already be taken.'), backgroundColor: Colors.red)
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
              child: Row(
                children: [
                  IconButton(icon: Icon(Icons.arrow_back_ios_new_rounded, color: const Color(0xFF00B4ED), size: 24.r), onPressed: () => context.pop()),
                  Text('Sign Up', style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: const Color(0xFF00B4ED))),
                ],
              ),
            ),
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
                    Text('Please enter your password', style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: const Color(0xFF0079AD))),
                    SizedBox(height: 25.h),

                    _buildLabel('Enter password*'),
                    _buildPasswordField(
                      hint: 'Password',
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      onToggle: () => setState(() => _obscurePassword = !_obscurePassword),
                    ),
                    SizedBox(height: 16.h),

                    _buildLabel('Confirm password*'),
                    _buildPasswordField(
                      hint: 'Confirm Password',
                      controller: _confirmController,
                      obscureText: _obscureConfirmPassword,
                      onToggle: () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
                    ),

                    SizedBox(height: 80.h),

                    SizedBox(
                      width: double.infinity,
                      height: 48.h,
                      child: ElevatedButton(
                        // TRIGGER THE NEW LOGIC HERE
                        onPressed: _isLoading ? null : _handleNext,
                        style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00B4ED), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)), elevation: 0),
                        child: _isLoading
                            ? SizedBox(height: 20.h, width: 20.h, child: const CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5))
                            : Text('Next', style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.bold)),
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

  Widget _buildLabel(String text) => Padding(padding: EdgeInsets.only(bottom: 6.h), child: Text(text, style: TextStyle(fontSize: 13.sp, color: Colors.grey.shade700, fontWeight: FontWeight.w500)));

  Widget _buildPasswordField({required String hint, required TextEditingController controller, required bool obscureText, required VoidCallback onToggle}) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8.r)),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        style: TextStyle(fontSize: 14.sp),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey.shade400),
          contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          suffixIcon: IconButton(icon: Icon(obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined, color: Colors.grey, size: 20.r), onPressed: onToggle),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r), borderSide: BorderSide(color: Colors.grey.shade300)),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r), borderSide: BorderSide(color: Colors.grey.shade300)),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r), borderSide: const BorderSide(color: Color(0xFF00B4ED))),
        ),
      ),
    );
  }
}