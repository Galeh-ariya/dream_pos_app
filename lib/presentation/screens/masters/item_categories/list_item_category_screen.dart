import 'package:dream_pos/core/colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class ListItemCategoryScreen extends StatefulWidget {
  const ListItemCategoryScreen({super.key});

  @override
  State<ListItemCategoryScreen> createState() => _ListItemCategoryScreenState();
}

class _ListItemCategoryScreenState extends State<ListItemCategoryScreen> {
  final TextEditingController _searchController = TextEditingController();

  static const List<String> _allCategories = [
    'Minuman',
    'Makanan',
    'Snack',
    'Frozen Food',
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final query = _searchController.text.trim().toLowerCase();
    final filteredCategories = _allCategories
        .where((category) => category.toLowerCase().contains(query))
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
            'Kategori Barang',
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
                    hintText: 'Cari kategori...',
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
                onPressed: _onCreateCategory,
                icon: const Icon(Icons.add_rounded, size: 18),
                label: Text(
                  'Tambah Kategori',
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
          ...filteredCategories.map(_buildCategoryCard),
          if (filteredCategories.isEmpty) _buildEmptySearchState(),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(String categoryName) {
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
              categoryName,
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.onSurface,
                letterSpacing: -0.2,
              ),
            ),
          ),
          IconButton(
            onPressed: () => _onEditCategory(categoryName),
            splashRadius: 18,
            visualDensity: VisualDensity.compact,
            icon: Icon(
              Icons.edit_rounded,
              size: 20,
              color: AppColors.onSurfaceVariant,
            ),
          ),
          IconButton(
            onPressed: () => _onDeleteCategory(categoryName),
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
        'Kategori tidak ditemukan.',
        style: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppColors.onSurfaceVariant,
        ),
      ),
    );
  }

  void _onCreateCategory() {
    context.pushNamed('master-form-item-category');
  }

  void _onEditCategory(String categoryName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Edit kategori $categoryName belum tersedia.')),
    );
  }

  void _onDeleteCategory(String categoryName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Hapus kategori $categoryName belum tersedia.')),
    );
  }
}
