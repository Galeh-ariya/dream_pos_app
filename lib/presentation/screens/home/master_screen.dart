import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';

class MasterScreen extends StatelessWidget {
  const MasterScreen({super.key});

  static const Color _pageBackground = Color(0xFFF2F4F7);
  static const Color _appBarForeground = Color(0xFF1E232B);
  static const Color _titleBlue = Color(0xFF1265D8);
  static const Color _cardBackground = Color(0xFFF8FAFD);
  static const Color _cardBorder = Color(0xFFE5E9F0);
  static const Color _headlineColor = Color(0xFF1B1F28);
  static const Color _bodyColor = Color(0xFF5D6472);
  static const Color _arrowColor = Color(0xFF3B82F6);

  @override
  Widget build(BuildContext context) {
    final items = <_MasterMenuItem>[
      _MasterMenuItem(
        title: 'Kelola Outlet',
        subtitle: 'Pengaturan pembuatan outltet.',
        icon: Icons.person_outline_rounded,
        iconColor: Color(0xFF2F6CFF),
        iconBackground: Color(0xFFD9E7FF),
        onTap: () => context.push('/master/outlets'),
      ),
      const _MasterMenuItem(
        title: 'Kelola User',
        subtitle: 'Pengaturan hak akses dan profil pengguna sistem.',
        icon: Icons.person_outline_rounded,
        iconColor: Color(0xFF2F6CFF),
        iconBackground: Color(0xFFD9E7FF),
      ),
      const _MasterMenuItem(
        title: 'Kelola Item',
        subtitle: 'Manajemen stok barang gudang.',
        icon: Icons.inventory_2_outlined,
        iconColor: Color(0xFF169B4F),
        iconBackground: Color(0xFFD7F3E3),
      ),
      const _MasterMenuItem(
        title: 'Kelola Kategori Barang',
        subtitle: 'Manajemen kategori barang untuk setiap stok barang.',
        icon: Icons.category_outlined,
        iconColor: Color(0xFF2A66D9),
        iconBackground: Color(0xFFDCE5FF),
      ),
      const _MasterMenuItem(
        title: 'Kelola Satuan',
        subtitle: 'Definisi unit pengukuran untuk setiap item barang.',
        icon: Icons.straighten_rounded,
        iconColor: Color(0xFF4B5565),
        iconBackground: Color(0xFFE9EDF3),
      ),
    ];

    return Scaffold(
      backgroundColor: _pageBackground,
      appBar: AppBar(
        backgroundColor: _pageBackground,
        elevation: 0,
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        toolbarHeight: 72,
        titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              const Icon(
                Icons.grid_view_rounded,
                color: Color(0xFF1B67D8),
                size: 21,
              ),
              const SizedBox(width: 14),
              Text(
                'Master Data',
                style: GoogleFonts.inter(
                  color: _appBarForeground,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.2,
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.search_rounded,
                  size: 24,
                  color: Color(0xFF3E4655),
                ),
                splashRadius: 22,
              ),
            ],
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
        children: [
          RichText(
            text: TextSpan(
              style: GoogleFonts.inter(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                height: 1.25,
                letterSpacing: -0.45,
              ),
              children: const [
                TextSpan(
                  text: 'Master',
                  style: TextStyle(color: _headlineColor),
                ),
                TextSpan(text: ' '),
                TextSpan(
                  text: 'Control',
                  style: TextStyle(color: _titleBlue),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          ...items.map((item) => _MasterCard(item: item)),
        ],
      ),
    );
  }
}

class _MasterCard extends StatelessWidget {
  const _MasterCard({required this.item});

  final _MasterMenuItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: MasterScreen._cardBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: MasterScreen._cardBorder),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: item.onTap,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(22, 24, 18, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: item.iconBackground,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(item.icon, color: item.iconColor, size: 24),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Text(
                        item.title,
                        style: GoogleFonts.inter(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: MasterScreen._headlineColor,
                          letterSpacing: -0.2,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  item.subtitle,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: MasterScreen._bodyColor,
                    height: 1.35,
                    letterSpacing: -0.1,
                  ),
                ),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,
                  child: Icon(
                    Icons.arrow_forward_rounded,
                    color: MasterScreen._arrowColor,
                    size: 31,
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

class _MasterMenuItem {
  const _MasterMenuItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
    required this.iconBackground,
    this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconColor;
  final Color iconBackground;
  final VoidCallback? onTap;
}
