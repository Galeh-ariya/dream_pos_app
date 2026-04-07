import 'package:dream_pos/bloc/logout/logout_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingScreen extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _pageBackground,
      appBar: AppBar(
        backgroundColor: _pageBackground,
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
            color: _headingColor,
            letterSpacing: -0.2,
          ),
        ),
      ),
      body: SingleChildScrollView(
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
                            border: Border.all(color: Colors.white, width: 3),
                            gradient: const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Color(0xFF23626A), Color(0xFF163F45)],
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
                              color: _buttonBlue,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
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
                      'Ahmad Syarif',
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: _headingColor,
                        letterSpacing: -0.25,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      'ahmad@retail.com',
                      style: GoogleFonts.inter(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: _mutedTextColor,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 34),
              _buildLabel('PROFILE NAME'),
              const SizedBox(height: 8),
              _buildField(
                text: 'Ahmad Syarif',
                icon: Icons.person_outline_rounded,
              ),
              const SizedBox(height: 14),
              _buildLabel('EMAIL'),
              const SizedBox(height: 8),
              _buildField(
                text: 'ahmad@retail.com',
                icon: Icons.mail_outline_rounded,
              ),
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
                  Expanded(child: _buildField(text: 'Manager Outlet')),
                  const SizedBox(width: 14),
                  Expanded(child: _buildField(text: 'Central Outlet')),
                ],
              ),
              const SizedBox(height: 14),
              _buildLabel('USERNAME'),
              const SizedBox(height: 8),
              _buildField(
                text: 'ahmad_syarif',
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
                    backgroundColor: _buttonBlue,
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
                              color: _logoutRed,
                              width: 1.4,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            backgroundColor: const Color(0xFFFFF1F2),
                          ),
                          child: CircularProgressIndicator(
                            color: _logoutRed,
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
                            context.read<LogoutBloc>().add(const LogoutEvent.logout());
                          },
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(
                              color: _logoutRed,
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
                              color: _logoutRed,
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
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        color: _labelColor,
        letterSpacing: 1.4,
      ),
    );
  }

  Widget _buildField({required String text, IconData? icon}) {
    return Container(
      height: 58,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: _inputBackground,
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
                color: _inputTextColor,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (icon != null) ...[
            const SizedBox(width: 8),
            Icon(icon, color: _iconColor, size: 21),
          ],
        ],
      ),
    );
  }
}
