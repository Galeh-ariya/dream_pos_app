import 'package:flutter/material.dart';
import 'package:dream_pos/core/index.dart';
import 'package:dream_pos/router/app_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter.router,
      debugShowCheckedModeBanner: false,
      title: 'Dream POS',
      theme: AppTheme.lightTheme,
    );
  }
}
