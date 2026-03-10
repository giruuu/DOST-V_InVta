import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // 1. Add this

import 'core/theme/app_theme.dart';
import 'core/router/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  runApp(
    const ProviderScope(
      child: InVtaApp(),
    ),
  );
}

class InVtaApp extends StatelessWidget {
  const InVtaApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 2. Wrap with ScreenUtilInit
    return ScreenUtilInit(
      designSize: const Size(375, 812), // Your Figma Artboard size
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          title: 'InVta Event Management',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          routerConfig: appRouter,
        );
      },
    );
  }
}