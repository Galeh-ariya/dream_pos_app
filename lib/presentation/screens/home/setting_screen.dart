import 'package:dream_pos/bloc/logout/logout_bloc.dart';
import 'package:dream_pos/data/models/response/user_data_response_model.dart';
import 'package:dream_pos/data/repositories/auth_local_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  static const Color _pageBackground = Color(0xFFF2F4F7);
  static const Color _headingColor = Color(0xFF1D2330);
  static const Color _mutedTextColor = Color(0xFF4E5563);
  static const Color _inputBackground = Color(0xFFEFF1F5);
  static const Color _inputTextColor = Color(0xFF353B45);
  static const Color _labelColor = Color(0xFF4B5160);
  static const Color _iconColor = Color(0xFFA2A9B6);
  static const Color _buttonBlue = Color(0xFF1460BC);
  static const Color _logoutRed = Color(0xFFBE123C);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen>
    with SingleTickerProviderStateMixin {
  late final Future<UserDataModel?> _userFuture;
  late final AnimationController _shimmerController;

  @override
  void initState() {
    super.initState();
    _userFuture = AuthLocalRepository().getUserData();
    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SettingScreen._pageBackground,
      appBar: AppBar(
        backgroundColor: SettingScreen._pageBackground,
        elevation: 0,
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        titleSpacing: 24,
        toolbarHeight: 64,
        title: Text(
          'Settings',
          style: GoogleFonts.inter(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: SettingScreen._headingColor,
            letterSpacing: -0.2,
          ),
        ),
      ),
      body: FutureBuilder<UserDataModel?>(
        future: _userFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return _buildLoadingBody();
          }

          final userData = snapshot.data;
          final profileName = userData?.fullName ?? '-';
          // final role = userData?.role ?? '-';
          final email = userData?.email ?? '-';
          final username =
              userData?.fullName?.toLowerCase().replaceAll(
                RegExp(r'\s+'),
                '_',
              ) ??
              '-';

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 36),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Column(
                      children: [
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              width: 112,
                              height: 112,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: Colors.white,
                                  width: 3,
                                ),
                                gradient: const LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Color(0xFF23626A),
                                    Color(0xFF163F45),
                                  ],
                                ),
                              ),
                              child: const Icon(
                                Icons.person_rounded,
                                color: Color(0xFFE5EAF2),
                                size: 66,
                              ),
                            ),
                            Positioned(
                              right: -4,
                              bottom: -4,
                              child: Container(
                                width: 34,
                                height: 34,
                                decoration: BoxDecoration(
                                  color: SettingScreen._buttonBlue,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2,
                                  ),
                                ),
                                child: const Icon(
                                  Icons.camera_alt_outlined,
                                  color: Colors.white,
                                  size: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 18),
                        Text(
                          profileName,
                          style: GoogleFonts.inter(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: SettingScreen._headingColor,
                            letterSpacing: -0.25,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          email,
                          style: GoogleFonts.inter(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: SettingScreen._mutedTextColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 34),
                  _buildLabel('PROFILE NAME'),
                  const SizedBox(height: 8),
                  _buildField(
                    text: profileName,
                    icon: Icons.person_outline_rounded,
                  ),
                  const SizedBox(height: 14),
                  _buildLabel('EMAIL'),
                  const SizedBox(height: 8),
                  _buildField(text: email, icon: Icons.mail_outline_rounded),
                  const SizedBox(height: 8),
                  _buildLabel('USERNAME'),
                  const SizedBox(height: 8),
                  _buildField(
                    text: username,
                    icon: Icons.alternate_email_rounded,
                  ),
                  const SizedBox(height: 34),
                  const Divider(color: Color(0xFFDFE3EA), thickness: 1),
                  const SizedBox(height: 48),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: SettingScreen._buttonBlue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 3,
                        shadowColor: const Color(0x33004B9A),
                      ),
                      child: Text(
                        'Update Profile',
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  BlocConsumer<LogoutBloc, LogoutState>(
                    listener: (context, state) {
                      state.maybeWhen(
                        success: () {
                          AuthLocalRepository().removeAuthData();
                          context.go('/login');
                        },
                        orElse: () {},
                      );
                    },
                    builder: (context, state) {
                      return state.maybeWhen(
                        loading: () {
                          return SizedBox(
                            width: double.infinity,
                            height: 56,
                            child: OutlinedButton(
                              onPressed: null,
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(
                                  color: SettingScreen._logoutRed,
                                  width: 1.4,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                backgroundColor: const Color(0xFFFFF1F2),
                              ),
                              child: CircularProgressIndicator(
                                color: SettingScreen._logoutRed,
                                strokeWidth: 2,
                              ),
                            ),
                          );
                        },
                        orElse: () {
                          return SizedBox(
                            width: double.infinity,
                            height: 56,
                            child: OutlinedButton(
                              onPressed: () {
                                AuthLocalRepository().removeAuthData();
                                context.read<LogoutBloc>().add(
                                  const LogoutEvent.logout(),
                                );
                              },
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(
                                  color: SettingScreen._logoutRed,
                                  width: 1.4,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                backgroundColor: const Color(0xFFFFF1F2),
                              ),
                              child: Text(
                                'Logout',
                                style: GoogleFonts.inter(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: SettingScreen._logoutRed,
                                  letterSpacing: 0.2,
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildLoadingBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 36),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  _buildSkeletonBox(width: 112, height: 112, radius: 14),
                  const SizedBox(height: 18),
                  _buildSkeletonBox(width: 170, height: 18, radius: 8),
                  const SizedBox(height: 8),
                  _buildSkeletonBox(width: 210, height: 16, radius: 8),
                ],
              ),
            ),
            const SizedBox(height: 34),
            _buildLabel('PROFILE NAME'),
            const SizedBox(height: 8),
            _buildSkeletonBox(width: double.infinity, height: 58, radius: 10),
            const SizedBox(height: 14),
            _buildLabel('EMAIL'),
            const SizedBox(height: 8),
            _buildSkeletonBox(width: double.infinity, height: 58, radius: 10),
            const SizedBox(height: 14),
            Row(
              children: [
                Expanded(child: _buildLabel('JABATAN/ROLE')),
                const SizedBox(width: 14),
                Expanded(child: _buildLabel('NAMA OUTLET')),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: _buildSkeletonBox(
                    width: double.infinity,
                    height: 58,
                    radius: 10,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: _buildSkeletonBox(
                    width: double.infinity,
                    height: 58,
                    radius: 10,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            _buildLabel('USERNAME'),
            const SizedBox(height: 8),
            _buildSkeletonBox(width: double.infinity, height: 58, radius: 10),
            const SizedBox(height: 34),
            const Divider(color: Color(0xFFDFE3EA), thickness: 1),
            const SizedBox(height: 48),
            _buildSkeletonBox(width: double.infinity, height: 56, radius: 10),
            const SizedBox(height: 12),
            _buildSkeletonBox(width: double.infinity, height: 56, radius: 10),
          ],
        ),
      ),
    );
  }

  Widget _buildSkeletonBox({
    required double width,
    required double height,
    required double radius,
  }) {
    return AnimatedBuilder(
      animation: _shimmerController,
      builder: (context, child) {
        return ShaderMask(
          blendMode: BlendMode.srcATop,
          shaderCallback: (Rect bounds) {
            return LinearGradient(
              begin: Alignment(-1 + (2 * _shimmerController.value), 0),
              end: Alignment(1 + (2 * _shimmerController.value), 0),
              colors: const [
                Color(0xFFE0E4EA),
                Color(0xFFF1F3F6),
                Color(0xFFE0E4EA),
              ],
              stops: const [0.1, 0.45, 0.8],
            ).createShader(bounds);
          },
          child: child,
        );
      },
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: const Color(0xFFE0E4EA),
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        color: SettingScreen._labelColor,
        letterSpacing: 1.4,
      ),
    );
  }

  Widget _buildField({required String text, IconData? icon}) {
    return Container(
      height: 58,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: SettingScreen._inputBackground,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.inter(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: SettingScreen._inputTextColor,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (icon != null) ...[
            const SizedBox(width: 8),
            Icon(icon, color: SettingScreen._iconColor, size: 21),
          ],
        ],
      ),
    );
  }
}
