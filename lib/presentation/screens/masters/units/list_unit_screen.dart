import 'package:dream_pos/core/colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class ListUnitScreen extends StatefulWidget {
  const ListUnitScreen({super.key});

  @override
  State<ListUnitScreen> createState() => _ListUnitScreenState();
}

class _ListUnitScreenState extends State<ListUnitScreen> {
  final TextEditingController _searchController = TextEditingController();

  static const List<String> _allUnits = ['Box', 'Centimeter', 'Kg', 'Carton'];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final query = _searchController.text.trim().toLowerCase();
    final filteredUnits = _allUnits
        .where((unit) => unit.toLowerCase().contains(query))
        .toList(growable: false);

    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Daftar Satuan',
            style: GoogleFonts.inter(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: AppColors.onSurface,
              letterSpacing: -0.3,
            ),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: TextField(
                  controller: _searchController,
                  onChanged: (_) => setState(() {}),
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.onSurface,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Cari satuan...',
                    hintStyle: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.onSurfaceVariant,
                    ),
                    prefixIcon: Icon(
                      Icons.search_rounded,
                      color: AppColors.onSurfaceVariant,
                      size: 21,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 12,
                    ),
                    filled: true,
                    fillColor: AppColors.surfaceContainerHigh,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide(
                        color: AppColors.outlineVariant.withOpacity(0.25),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide(
                        color: AppColors.primary.withOpacity(0.55),
                        width: 1.4,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              FilledButton.icon(
                onPressed: _onCreateUnit,
                icon: const Icon(Icons.add_rounded, size: 18),
                label: Text(
                  'Tambah Satuan',
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 14,
                  ),
                  minimumSize: const Size(0, 52),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...filteredUnits.map(_buildUnitCard),
          if (filteredUnits.isEmpty) _buildEmptySearchState(),
        ],
      ),
    );
  }

  Widget _buildUnitCard(String unitName) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.outlineVariant.withOpacity(0.18)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              unitName,
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.onSurface,
                letterSpacing: -0.2,
              ),
            ),
          ),
          IconButton(
            onPressed: () => _onEditUnit(unitName),
            splashRadius: 18,
            visualDensity: VisualDensity.compact,
            icon: Icon(
              Icons.edit_rounded,
              size: 20,
              color: AppColors.onSurfaceVariant,
            ),
          ),
          IconButton(
            onPressed: () => _onDeleteUnit(unitName),
            splashRadius: 18,
            visualDensity: VisualDensity.compact,
            icon: const Icon(
              Icons.delete_outline_rounded,
              size: 22,
              color: Color(0xFFDE2B2B),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptySearchState() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(
        'Satuan tidak ditemukan.',
        style: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppColors.onSurfaceVariant,
        ),
      ),
    );
  }

  void _onCreateUnit() {
    context.pushNamed('master-form-unit');
  }

  void _onEditUnit(String unitName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Edit satuan $unitName belum tersedia.')),
    );
  }

  void _onDeleteUnit(String unitName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Hapus satuan $unitName belum tersedia.')),
    );
  }
}
