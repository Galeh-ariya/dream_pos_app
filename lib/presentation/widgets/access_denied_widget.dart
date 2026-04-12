import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AccessDeniedWidget extends StatelessWidget {
  final String title;
  final String message;

  const AccessDeniedWidget({
    super.key,
    this.title = 'Akses Ditolak',
    this.message =
        'Anda tidak dapat mengakses halaman ini. Silakan hubungi administrator jika Anda yakin ini adalah kesalahan.',
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 300,
                  height: 310,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 262,
                        height: 262,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          gradient: const RadialGradient(
                            center: Alignment.center,
                            radius: 0.92,
                            colors: [
                              Color(0xFF1C63D1),
                              Color(0xFF2458C8),
                              Color(0xFF5E6BEF),
                            ],
                            stops: [0.0, 0.52, 1.0],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 12,
                        child: Container(
                          width: 248,
                          height: 248,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(36),
                            gradient: RadialGradient(
                              center: const Alignment(0, -0.08),
                              radius: 0.88,
                              colors: [
                                const Color(0xFF2C74F0).withOpacity(0.96),
                                const Color(0xFF1F54C6).withOpacity(0.72),
                                const Color(0xFF1744B2).withOpacity(0.0),
                              ],
                              stops: const [0.0, 0.58, 1.0],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 34,
                        child: Container(
                          width: 212,
                          height: 212,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: const Color(
                                  0xFF0A45C0,
                                ).withOpacity(0.42),
                                blurRadius: 46,
                                spreadRadius: 14,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 92,
                        child: Container(
                          width: 164,
                          height: 164,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.10),
                                blurRadius: 18,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Container(
                              width: 92,
                              height: 92,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: const LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color(0xFF0E63D6),
                                    Color(0xFF4B89F1),
                                  ],
                                ),
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.shield_outlined,
                                  color: Colors.white,
                                  size: 40,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 78,
                        right: 50,
                        child: Container(
                          width: 52,
                          height: 52,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF3F4F9),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(
                                  0xFF1D3FA4,
                                ).withOpacity(0.14),
                                blurRadius: 18,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.shield,
                              size: 22,
                              color: Color(0xFF1D66E0),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 42,
                        child: Container(
                          width: 150,
                          height: 14,
                          decoration: BoxDecoration(
                            color: const Color(0xFF2D63D3).withOpacity(0.95),
                            borderRadius: BorderRadius.circular(999),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(
                                  0xFF0D3FB2,
                                ).withOpacity(0.24),
                                blurRadius: 18,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Container(
                          width: 232,
                          height: 36,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(22),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                const Color(0xFF5B78E6).withOpacity(0.0),
                                const Color(0xFF2B63D2).withOpacity(0.46),
                              ],
                            ),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.03),
                              width: 1,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 32,
                    height: 1.0,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF263058),
                    letterSpacing: -1.1,
                  ),
                ),
                const SizedBox(height: 18),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    height: 1.45,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF4F5778),
                    letterSpacing: 0.1,
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
