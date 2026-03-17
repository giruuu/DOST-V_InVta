import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../services/auth_service.dart';

class SignUpOTCPage extends StatefulWidget {
  final Map<String, dynamic> userData;

  const SignUpOTCPage({super.key, required this.userData});

  @override
  State<SignUpOTCPage> createState() => _SignUpOTCPageState();
}

class _SignUpOTCPageState extends State<SignUpOTCPage> {
  final AuthService _authService = AuthService();
  final TextEditingController _otpController = TextEditingController();

  bool _isLoading = false;

  // --- TIMER STATE VARIABLES ---
  Timer? _timer;
  int _secondsRemaining = 180;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel(); // Prevent memory leaks
    _otpController.dispose();
    super.dispose();
  }

  // --- TIMER LOGIC ---
  void _startTimer() {
    setState(() {
      _secondsRemaining = 180;
      _canResend = false;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        setState(() {
          _canResend = true;
        });
        _timer?.cancel();
      }
    });
  }

  String get _formattedTime {
    int minutes = _secondsRemaining ~/ 60;
    int seconds = _secondsRemaining % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  // --- RESEND OTP LOGIC ---
  Future<void> _resendCode() async {
    setState(() => _isLoading = true);

    bool otpSent = await _authService.sendOtp(widget.userData['email']);

    if (mounted) {
      setState(() => _isLoading = false);
      if (otpSent) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('A new code has been sent!'), backgroundColor: Colors.green)
        );
        _startTimer(); // Restart the 3-minute countdown
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to resend code. Please try again later.'), backgroundColor: Colors.red)
        );
      }
    }
  }

  // --- SUBMIT REGISTRATION LOGIC ---
  Future<void> _submitRegistration() async {
    // Validate they entered 6 digits
    if (_otpController.text.trim().length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please enter the 6-digit code.'), backgroundColor: Colors.orange)
      );
      return;
    }

    setState(() => _isLoading = true);

    // Add the typed OTP to the user payload
    Map<String, dynamic> finalPayload = Map.from(widget.userData);
    finalPayload['otp'] = _otpController.text.trim();

    bool isSuccess = await _authService.register(finalPayload);

    if (mounted) {
      setState(() => _isLoading = false);
      if (isSuccess) {
        context.go('/home');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Invalid code or expired.'), backgroundColor: Colors.red)
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    String userEmail = widget.userData['email'] ?? 'your email';

    return Scaffold(
      backgroundColor: Colors.white,
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
                  Expanded(child: Container(height: 5.h, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(10.r)))),
                  SizedBox(width: 8.w),
                  Expanded(child: Container(height: 5.h, decoration: BoxDecoration(color: const Color(0xFF00B4ED), borderRadius: BorderRadius.circular(10.r)))),
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
                    Text('One-Time Code sent', style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: const Color(0xFF0079AD))),
                    SizedBox(height: 10.h),

                    Text('Check your email inbox\nWe\'ve sent an email to $userEmail containing a 6-digit code', style: TextStyle(fontSize: 13.sp, color: Colors.black87, height: 1.5)),
                    SizedBox(height: 25.h),

                    _buildLabel('Enter email code*'),
                    // Attached the controller here!
                    _buildInputField(hint: '6-digit code', controller: _otpController),
                    SizedBox(height: 20.h),

                    // Dynamic Timer UI
                    Center(
                      child: _canResend
                          ? TextButton(
                        onPressed: _isLoading ? null : _resendCode,
                        child: Text(
                          'Resend Code',
                          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: const Color(0xFF00B4ED)),
                        ),
                      )
                          : Text(
                        'Resend code in $_formattedTime',
                        style: TextStyle(fontSize: 13.sp, color: Colors.black54),
                      ),
                    ),
                    SizedBox(height: 20.h),

                    Container(
                      padding: EdgeInsets.all(15.w),
                      decoration: BoxDecoration(color: const Color(0xFFE1F5FE).withValues(alpha: 0.5), border: Border.all(color: const Color(0xFF00B4ED).withValues(alpha: 0.3)), borderRadius: BorderRadius.circular(5.r)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.info_outline, color: const Color(0xFF00B4ED), size: 20.r),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                style: TextStyle(fontSize: 11.sp, color: const Color(0xFF00B4ED), height: 1.4),
                                children: const [
                                  TextSpan(text: 'Kindly wait for at least '),
                                  TextSpan(text: '3 minutes ', style: TextStyle(fontWeight: FontWeight.bold)),
                                  TextSpan(text: 'for your '),
                                  TextSpan(text: '6-digit code ', style: TextStyle(fontWeight: FontWeight.bold)),
                                  TextSpan(text: 'to arrive. Sometimes there may be delays when receiving it. Thank you for your patience!'),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 40.h),

                    SizedBox(
                      width: double.infinity,
                      height: 48.h,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _submitRegistration,
                        style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00B4ED), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)), elevation: 0),
                        child: _isLoading
                            ? SizedBox(height: 20.h, width: 20.h, child: const CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5))
                            : Text('Next', style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    SizedBox(height: 30.h),

                    Center(
                      child: Column(
                        children: [
                          Text('Didn\'t receive the email?', style: TextStyle(fontSize: 12.sp, color: Colors.black54)),
                          Text('Try checking your junk or spam folders', style: TextStyle(fontSize: 12.sp, color: Colors.black54)),
                          SizedBox(height: 30.h),
                          RichText(
                            text: TextSpan(
                              style: TextStyle(fontSize: 13.sp, color: Colors.black),
                              children: [
                                const TextSpan(text: 'Not '),
                                TextSpan(text: userEmail, style: const TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                          TextButton(onPressed: () => context.pop(), child: const Text('Edit email here', style: TextStyle(color: Color(0xFF00B4ED), decoration: TextDecoration.underline))),
                        ],
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

  // Added controller parameter here!
  Widget _buildInputField({required String hint, TextEditingController? controller}) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8.r)),
      child: TextField(
        controller: controller, // Bound the controller
        keyboardType: TextInputType.number,
        style: TextStyle(fontSize: 14.sp),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey.shade400),
          contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r), borderSide: BorderSide(color: Colors.grey.shade300)),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r), borderSide: BorderSide(color: Colors.grey.shade300)),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r), borderSide: const BorderSide(color: Color(0xFF00B4ED))),
        ),
      ),
    );
  }
}