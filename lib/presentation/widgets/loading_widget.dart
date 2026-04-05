import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/colors.dart';

class LoadingWidget extends StatefulWidget {
  final String? brandName;
  final String loadingText;
  final Color? circleColor;

  const LoadingWidget({
    Key? key,
    this.brandName = 'DIGITAL DREAM',
    this.loadingText = 'Loading...',
    this.circleColor,
  }) : super(key: key);

  @override
  State<LoadingWidget> createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();

    // Animated progress value from 0 to 1
    _progressAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
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
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFFE8F0FF).withOpacity(0.7),
              const Color(0xFFF5F8FF),
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Animated Filling Circle
                SizedBox(
                  width: 160,
                  height: 160,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Background circle - Light Blue
                      Container(
                        width: 160,
                        height: 160,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xFF90CAF9), // Light Blue
                            width: 6,
                          ),
                        ),
                      ),

                      // Animated Progress Circle - Dark Blue filling
                      AnimatedBuilder(
                        animation: _progressAnimation,
                        builder: (context, child) {
                          return Padding(
                            padding: const EdgeInsets.all(3),
                            child: SizedBox(
                              width: 154,
                              height: 154,
                              child: CircularProgressIndicator(
                                strokeWidth: 6,
                                backgroundColor: Colors.transparent,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  widget.circleColor ?? AppColors.primary,
                                ),
                                value: _progressAnimation.value,
                              ),
                            ),
                          );
                        },
                      ),

                      // Center Logo
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: widget.circleColor ?? AppColors.primary,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: (widget.circleColor ?? AppColors.primary)
                                  .withOpacity(0.3),
                              blurRadius: 16,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            '⊞',
                            style: GoogleFonts.inter(
                              fontSize: 48,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 48),

                // Loading Text
                Text(
                  widget.loadingText,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: widget.circleColor ?? AppColors.primary,
                    letterSpacing: 0.2,
                  ),
                ),

                const SizedBox(height: 48),

                // Brand Name
                if (widget.brandName != null)
                  Text(
                    widget.brandName!,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColors.onSurfaceVariant,
                      letterSpacing: 1.5,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
