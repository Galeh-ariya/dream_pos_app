// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:dream_pos/data/models/response/user_data_response_model.dart';
import 'package:dream_pos/data/repositories/auth_local_repository.dart';
import 'package:flutter/material.dart';
import 'package:dream_pos/core/index.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  final supabase = Supabase.instance.client;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat();
    checkCurrentSession();
  }

  void checkCurrentSession() async {
    await Future.delayed(Duration(milliseconds: 500));

    final session = supabase.auth.currentSession;

    if (session != null) {
      fetchUser(session);
      context.go('/');
    } else {
      context.go('/login');
    }
  }

  Future<String> fetchUser(session) async {
    final id = session?.user.id;
    // debugPrint('Current User ID: $id');

      final data = await supabase
          .from('profiles')
          .select('''
            id,
            full_name,
            role,
            jabatan_id,
            email,
            outlets!outlets_owner_id_fkey(id, name, address, owner_id, fifo_lifo)
            ''')
              .eq('id', id);

    // debugPrint('User Dataku: ${data.toString()}');
    if (data.isNotEmpty) {
      final userModel = UserDataModel.fromJson(jsonEncode(data[0]));
      await AuthLocalRepository().updateUserData(userModel);
    }
    return data.toString();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Animated brand logo
              ScaleTransition(
                scale: Tween<double>(
                  begin: 0.95,
                  end: 1.05,
                ).animate(_animationController),
                child: Image.asset(
                  'assets/asset/brand.png',
                  width: 240,
                  height: 140,
                  fit: BoxFit.contain,
                ),
              ),

              const SizedBox(height: 16),

              // Subtitle
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.horizontalPadding,
                ),
                child: Text(
                  'The easiest Point of Sale System',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              const SizedBox(height: 60),

              // Animated dots
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  3,
                  (index) => AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, child) {
                      final delay = index * 0.2;
                      final value = (_animationController.value + delay) % 1.0;
                      final opacity = (value < 0.5
                          ? value * 2
                          : (1 - value) * 2);

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Opacity(
                          opacity: opacity,
                          child: Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
