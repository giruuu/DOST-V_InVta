import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../services/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final AuthService _authService = AuthService();
  bool _isLoading = false;

  Future<void> _handleLogin() async {
    if (_emailController.text.trim().isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter both email and password.'), backgroundColor: Colors.orange),
      );
      return;
    }

    setState(() => _isLoading = true);

    bool isSuccess = await _authService.login(
      _emailController.text.trim(),
      _passwordController.text,
    );

    if (mounted) {
      setState(() => _isLoading = false);

      if (isSuccess) {
        context.go('/home');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Invalid credentials or server error.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF00B4ED), Color(0xFFFFFFFF)],
          stops: [0.0, 0.7],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: Column(
              children: [
                // Pulled the top spacing up
                SizedBox(height: 50.h),

                // Slightly reduced logo size
                Image.asset('assets/images/DOST_logo_white.png', height: 100.h),

                SizedBox(height: 30.h),

                // Tightened the header text
                Text('SIGN IN', style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.bold, color: const Color(0xFF0079AD))),
                SizedBox(height: 4.h),
                Text('Please enter your details below', style: TextStyle(fontSize: 14.sp, color: const Color(0xFF0079AD))),

                SizedBox(height: 40.h),

                _buildInputField(
                  hint: 'Enter your Email',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 16.h),
                _buildInputField(
                  hint: 'Enter Password',
                  controller: _passwordController,
                  isPassword: true,
                  suffixIcon: Icons.visibility_off_outlined,
                ),

                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: Text('Forgot password?', style: TextStyle(color: const Color(0xFF00B4ED), fontWeight: FontWeight.bold, fontSize: 13.sp)),
                  ),
                ),
                SizedBox(height: 10.h),

                // Slimmer, standard 48.h buttons
                SizedBox(
                  width: double.infinity,
                  height: 48.h,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _handleLogin,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00B4ED),
                      disabledBackgroundColor: const Color(0xFF00B4ED).withValues(alpha: 0.6),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                      elevation: 0,
                    ),
                    child: _isLoading
                        ? SizedBox(height: 20.h, width: 20.h, child: const CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5))
                        : Text('Sign In', style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.bold)),
                  ),
                ),
                SizedBox(height: 16.h),

                SizedBox(
                  width: double.infinity,
                  height: 48.h,
                  child: ElevatedButton(
                    onPressed: () => context.push('/signup'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE1F5FE),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                      elevation: 0,
                    ),
                    child: Text('Create New Account', style: TextStyle(color: const Color(0xFF00B4ED), fontSize: 15.sp, fontWeight: FontWeight.bold)),
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

  Widget _buildInputField({
    required String hint,
    required TextEditingController controller,
    bool isPassword = false,
    IconData? suffixIcon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10.r, offset: Offset(0, 4.h))],
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        keyboardType: keyboardType,
        style: TextStyle(fontSize: 15.sp, color: Colors.black87),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14.sp),
          suffixIcon: suffixIcon != null ? Icon(suffixIcon, color: Colors.black45, size: 20.r) : null,
          // Reduced vertical padding to make the text field slimmer
          contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
          border: InputBorder.none,
        ),
      ),
    );
  }
}