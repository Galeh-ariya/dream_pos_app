import 'package:dream_pos/bloc/item_categories/del_item_category/del_item_category_bloc.dart';
import 'package:dream_pos/bloc/item_categories/list_item_category/list_item_category_bloc.dart';
import 'package:dream_pos/core/colors.dart';
import 'package:dream_pos/data/models/response/item_category_response_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class ListItemCategoryScreen extends StatefulWidget {
  const ListItemCategoryScreen({
    super.key,
    required this.selectedOutletId,
    this.selectedOutletName,
  });

  final String selectedOutletId;
  final String? selectedOutletName;

  @override
  State<ListItemCategoryScreen> createState() => _ListItemCategoryScreenState();
}

class _ListItemCategoryScreenState extends State<ListItemCategoryScreen> {
  final TextEditingController _searchController = TextEditingController();
  int? _deletingCategoryId;

  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
      body: MultiBlocListener(
        listeners: [
          BlocListener<ListItemCategoryBloc, ListItemCategoryState>(
            listener: (context, state) {
              state.whenOrNull(
                error: (message) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(message)));
                },
              );
            },
          ),
          BlocListener<DelItemCategoryBloc, DelItemCategoryState>(
            listener: (context, state) {
              state.whenOrNull(
                success: (message) {
                  if (!mounted) return;

                  setState(() {
                    _deletingCategoryId = null;
                  });

                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(message)));

                  _fetchCategories();
                },
                error: (message) {
                  if (!mounted) return;

                  setState(() {
                    _deletingCategoryId = null;
                  });

                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(message)));
                },
              );
            },
          ),
        ],
        child: BlocBuilder<ListItemCategoryBloc, ListItemCategoryState>(
          builder: (context, state) {
            return state.when(
              initial: _buildLoadingBody,
              loading: _buildLoadingBody,
              success: _buildSuccessBody,
              error: _buildErrorBody,
            );
          },
        ),
      ),
    );
  }

  Widget _buildLoadingBody() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildSuccessBody(List<ItemCategoryResponseModel> categories) {
    final query = _searchController.text.trim().toLowerCase();
    final filteredCategories = categories
        .where((cat) => (cat.namaKategori ?? '').toLowerCase().contains(query))
        .toList(growable: false);

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
      children: [
        if ((widget.selectedOutletName ?? '').trim().isNotEmpty)
          _buildSelectedOutletBanner(),
        if ((widget.selectedOutletName ?? '').trim().isNotEmpty)
          const SizedBox(height: 12),
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
        if (filteredCategories.isEmpty)
          _buildEmptySearchState(isSearch: query.isNotEmpty),
      ],
    );
  }

  Widget _buildErrorBody(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.error_outline_rounded,
              size: 40,
              color: Color(0xFFDE2B2B),
            ),
            const SizedBox(height: 10),
            Text(
              message,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 14),
            FilledButton(
              onPressed: _fetchCategories,
              child: const Text('Coba Lagi'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard(ItemCategoryResponseModel category) {
    final categoryName = (category.namaKategori ?? '').trim().isEmpty
        ? '-'
        : category.namaKategori!.trim();

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
          BlocBuilder<DelItemCategoryBloc, DelItemCategoryState>(
            builder: (context, state) {
              final isDeletingThisRow =
                  _deletingCategoryId != null &&
                  _deletingCategoryId == category.id;
              final isBlocDeleting = state.maybeWhen(
                loading: () => true,
                orElse: () => false,
              );

              return IconButton(
                onPressed: (isBlocDeleting || isDeletingThisRow)
                    ? null
                    : () => _onDeleteCategory(category),
                splashRadius: 18,
                visualDensity: VisualDensity.compact,
                icon: isDeletingThisRow
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Color(0xFFDE2B2B),
                        ),
                      )
                    : const Icon(
                        Icons.delete_outline_rounded,
                        size: 22,
                        color: Color(0xFFDE2B2B),
                      ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildEmptySearchState({required bool isSearch}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(
        isSearch
            ? 'Kategori tidak ditemukan.'
            : 'Belum ada kategori barang pada outlet ini.',
        style: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppColors.onSurfaceVariant,
        ),
      ),
    );
  }

  void _fetchCategories() {
    context.read<ListItemCategoryBloc>().add(
      ListItemCategoryEvent.fetchItemCategories(widget.selectedOutletId),
    );
  }

  Widget _buildSelectedOutletBanner() {
    final outletName = widget.selectedOutletName?.trim() ?? '-';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.storefront_rounded,
            size: 18,
            color: AppColors.primary,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'Outlet: $outletName',
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: AppColors.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _onCreateCategory() async {
    final result = await context.pushNamed(
      'master-form-item-category',
      extra: {'selectedOutletId': widget.selectedOutletId},
    );

    if (!mounted) return;
    if (result != null) {
      _fetchCategories();
    }
  }

  Future<void> _onDeleteCategory(ItemCategoryResponseModel category) async {
    final categoryId = category.id;
    final outletId = category.outletId;
    final categoryName = (category.namaKategori ?? '-').trim().isEmpty
        ? '-'
        : category.namaKategori!.trim();

    if (categoryId == null || outletId == null || outletId.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Data kategori tidak valid. Gagal menghapus kategori.'),
        ),
      );
      return;
    }

    final isConfirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Hapus Kategori'),
          content: Text('Yakin ingin menghapus kategori $categoryName?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Batal'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFFDE2B2B),
              ),
              child: const Text('Hapus'),
            ),
          ],
        );
      },
    );

    if (isConfirmed != true || !mounted) return;

    setState(() {
      _deletingCategoryId = categoryId;
    });

    context.read<DelItemCategoryBloc>().add(
      DelItemCategoryEvent.delItemCategory(outletId: outletId, id: categoryId),
    );
  }
}
