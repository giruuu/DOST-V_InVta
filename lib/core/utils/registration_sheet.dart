import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_theme.dart';

class RegistrationSheet {
  static void show(
      BuildContext context, {
        required String eventName,
        required String type,
        required VoidCallback onSuccess, // NEW: Callback to trigger the UI update
      }) {
    final TextEditingController codeController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => TweenAnimationBuilder<double>(
        tween: Tween(begin: 0.0, end: 1.0),
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOutCubic,
        builder: (context, value, child) {
          return Transform.translate(
            offset: Offset(0, 30 * (1 - value)),
            child: Opacity(
              opacity: value,
              child: Container(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom + 24.h,
                  left: 24.w, right: 24.w, top: 12.h,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(child: Container(width: 40.w, height: 4.h, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(10)))),
                    SizedBox(height: 24.h),
                    Text(type == "WALK IN" ? "Instant Entry" : "Event Registration",
                        style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold, color: AppTheme.primaryBlue.withOpacity(0.7))),
                    Text(eventName, style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold, color: AppTheme.primaryBlue)),
                    SizedBox(height: 24.h),
                    Row(
                      children: [
                        Text("Access Code ", style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600)),
                        Text("(Optional)", style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: Colors.grey[500])),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    TextField(
                      controller: codeController,
                      autofocus: true,
                      cursorColor: AppTheme.primaryBlue,
                      decoration: InputDecoration(
                        hintText: "Enter VIP, Media, or Marshal code...",
                        hintStyle: TextStyle(fontSize: 13.sp, color: Colors.grey[400]),
                        filled: true,
                        fillColor: const Color(0xFFF8FAFC),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: BorderSide.none),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide(color: AppTheme.primaryBlue.withOpacity(0.4), width: 1.5),
                        ),
                      ),
                    ),
                    SizedBox(height: 24.h),
                    SizedBox(
                      width: double.infinity,
                      height: 50.h,
                      child: ElevatedButton(
                        // TRIGGER SUBMIT WITH CALLBACK
                        onPressed: () => _submit(context, eventName, codeController.text.trim(), onSuccess),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primaryBlue,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                          elevation: 0,
                        ),
                        child: Text("CONFIRM", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14.sp)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  static void _submit(BuildContext context, String event, String code, VoidCallback onSuccess) {
    context.pop(); // Close sheet
    onSuccess(); // Tell the UI to update to "REGISTERED"

    String message = code.isEmpty
        ? "Successfully registered for $event"
        : "Successfully registered with code: $code";

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: Colors.green,
      behavior: SnackBarBehavior.floating,
    ));
  }
}