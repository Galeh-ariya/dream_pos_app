import 'package:flutter/material.dart';
import 'package:dream_pos/core/index.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat();
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
              // Animated gradient container with glassmorphism
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  gradient: AppGradients.ctaPrimary,
                  borderRadius: BorderRadius.circular(AppRadii.xl),
                  boxShadow: AppShadows.cloudShadow,
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Pulsing background
                    ScaleTransition(
                      scale: Tween<double>(
                        begin: 0.95,
                        end: 1.05,
                      ).animate(_animationController),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: AppGradients.ctaPrimary,
                          borderRadius: BorderRadius.circular(AppRadii.xl),
                        ),
                      ),
                    ),
                    // Logo/Icon
                    Icon(
                      Icons.check_circle_outline,
                      size: 120,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 48),

              // Title
              Text(
                'Dream POS',
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  color: AppColors.onSurface,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 16),

              // Subtitle
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.horizontalPadding,
                ),
                child: Text(
                  'Point of Sale System',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              const SizedBox(height: 60),

              // Loading indicator with custom styling
              SizedBox(
                width: 60,
                height: 60,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Background circle
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.surfaceContainerLow,
                      ),
                    ),
                    // Rotating progress indicator
                    RotationTransition(
                      turns: _animationController,
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.primary.withOpacity(0.3),
                            width: 3,
                          ),
                        ),
                      ),
                    ),
                    // Rotating arc
                    RotationTransition(
                      turns: _animationController,
                      child: SizedBox(
                        width: 60,
                        height: 60,
                        child: CircularProgressIndicator(
                          strokeWidth: 4,
                          backgroundColor: AppColors.primary.withOpacity(0.12),
                          valueColor: AlwaysStoppedAnimation<Color>(
                            AppColors.primary.withOpacity(0.85),
                          ),
                        ),
                      ),
                    ),
                  ],
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
