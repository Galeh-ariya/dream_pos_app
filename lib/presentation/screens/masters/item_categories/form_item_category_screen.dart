import 'package:dream_pos/bloc/item_categories/store_item_category/store_item_category_bloc.dart';
import 'package:dream_pos/bloc/outlets/list_outlet/list_outlet_bloc.dart';
import 'package:dream_pos/core/colors.dart';
import 'package:dream_pos/data/models/response/outlet_reponse_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class FormItemCategoryScreen extends StatefulWidget {
  const FormItemCategoryScreen({
    super.key,
    this.initialCategoryName,
    this.selectedOutletId,
  });

  final String? initialCategoryName;
  final String? selectedOutletId;

  @override
  State<FormItemCategoryScreen> createState() => _FormItemCategoryScreenState();
}

class _FormItemCategoryScreenState extends State<FormItemCategoryScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _categoryNameController = TextEditingController();
  String? _selectedOutletId;

  bool get _isEditMode =>
      widget.initialCategoryName != null &&
      widget.initialCategoryName!.trim().isNotEmpty;

  @override
  void initState() {
    super.initState();
    _categoryNameController.text = widget.initialCategoryName ?? '';
    _selectedOutletId = widget.selectedOutletId;
    context.read<ListOutletBloc>().add(const ListOutletEvent.fetchOutlets());
  }

  @override
  void dispose() {
    _categoryNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfaceContainerLow,
      appBar: AppBar(
        backgroundColor: AppColors.surfaceContainerLow,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        titleSpacing: 0,
        title: Text(
          _isEditMode ? 'Form Edit Kategori' : 'Form Kategori Barang',
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.onSurface,
            letterSpacing: -0.2,
          ),
        ),
      ),
      body: BlocConsumer<StoreItemCategoryBloc, StoreItemCategoryState>(
        listener: (context, state) {
          state.whenOrNull(
            success: (message) {
              if (!mounted) return;
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(message)));

              Navigator.of(
                context,
              ).pop({'name': _categoryNameController.text.trim()});
            },
            error: (message) {
              if (!mounted) return;
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(message)));
            },
          );
        },
        builder: (context, state) {
          final isSaving = state.maybeWhen(
            loading: () => true,
            orElse: () => false,
          );

          return SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'FORM',
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.0,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _isEditMode
                        ? 'Edit Kategori Barang'
                        : 'Tambah Kategori Barang',
                    style: GoogleFonts.inter(
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      color: AppColors.onSurface,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(16, 18, 16, 16),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceContainerLowest,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 4),
                          child: Text(
                            'Nama Kategori Barang',
                            style: GoogleFonts.inter(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: AppColors.onSurface,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _categoryNameController,
                          textInputAction: TextInputAction.done,
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppColors.onSurface,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Masukkan nama kategori barang...',
                            hintStyle: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: AppColors.onSurfaceVariant.withOpacity(
                                0.5,
                              ),
                            ),
                            filled: true,
                            fillColor: AppColors.surfaceContainerHighest
                                .withOpacity(0.45),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: AppColors.primary,
                                width: 1.4,
                              ),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 14,
                            ),
                          ),
                          validator: (value) {
                            if ((value ?? '').trim().isEmpty) {
                              return 'Nama kategori barang wajib diisi.';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 14),
                        Padding(
                          padding: const EdgeInsets.only(left: 4),
                          child: Text(
                            'Outlet',
                            style: GoogleFonts.inter(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: AppColors.onSurface,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        _buildOutletInput(),
                        const SizedBox(height: 18),
                        SizedBox(
                          width: double.infinity,
                          child: FilledButton(
                            onPressed: isSaving ? null : _saveCategory,
                            style: FilledButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: Colors.white,
                              disabledBackgroundColor: AppColors.primary
                                  .withOpacity(0.45),
                              disabledForegroundColor: Colors.white70,
                              minimumSize: const Size.fromHeight(56),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              elevation: 0,
                            ),
                            child: isSaving
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const SizedBox(
                                        width: 18,
                                        height: 18,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2.2,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Text(
                                        'Menyimpan...',
                                        style: GoogleFonts.inter(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  )
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(Icons.save_outlined, size: 20),
                                      const SizedBox(width: 8),
                                      Text(
                                        _isEditMode
                                            ? 'Simpan Perubahan'
                                            : 'Simpan Kategori',
                                        style: GoogleFonts.inter(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _saveCategory() async {
    if (!_formKey.currentState!.validate()) return;

    final outletId = widget.selectedOutletId;
    if (outletId == null || outletId.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Outlet tidak valid. Gagal menyimpan kategori.'),
        ),
      );
      return;
    }

    final categoryName = _categoryNameController.text.trim();
    context.read<StoreItemCategoryBloc>().add(
      StoreItemCategoryEvent.storeItemCategory(outletId, categoryName),
    );
  }

  Widget _buildOutletInput() {
    return BlocBuilder<ListOutletBloc, ListOutletState>(
      builder: (context, state) {
        return state.when(
          initial: _buildOutletLoadingField,
          loading: _buildOutletLoadingField,
          success: _buildOutletDropdown,
          error: _buildOutletErrorField,
        );
      },
    );
  }

  Widget _buildOutletLoadingField() {
    return InputDecorator(
      decoration: _dropdownDecoration(hintText: 'Memuat daftar outlet...'),
      child: const LinearProgressIndicator(minHeight: 3),
    );
  }

  Widget _buildOutletErrorField(String message) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerHighest.withOpacity(0.45),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Gagal memuat outlet',
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: AppColors.onSurface,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            message,
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 8),
          TextButton(
            onPressed: () {
              context.read<ListOutletBloc>().add(
                const ListOutletEvent.fetchOutlets(),
              );
            },
            child: const Text('Coba Lagi'),
          ),
        ],
      ),
    );
  }

  Widget _buildOutletDropdown(List<OutletResponseModel> outlets) {
    final options = outlets
        .where((outlet) => outlet.id != null)
        .map(
          (outlet) => DropdownMenuItem<String>(
            value: outlet.id,
            child: Text(
              outlet.name ?? '-',
              style: GoogleFonts.inter(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: AppColors.onSurface,
              ),
            ),
          ),
        )
        .toList(growable: false);

    final hasSelected = options.any((item) => item.value == _selectedOutletId);
    final selectedValue = hasSelected ? _selectedOutletId : null;

    if (options.isEmpty) {
      return InputDecorator(
        decoration: _dropdownDecoration(hintText: 'Belum ada outlet tersedia'),
        child: Text(
          'Silakan tambahkan outlet terlebih dahulu.',
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.onSurfaceVariant,
          ),
        ),
      );
    }

    return DropdownButtonFormField<String>(
      value: selectedValue,
      isExpanded: true,
      icon: const Icon(Icons.keyboard_arrow_down_rounded),
      decoration: _dropdownDecoration(hintText: 'Pilih outlet...'),
      style: GoogleFonts.inter(
        fontSize: 15,
        fontWeight: FontWeight.w500,
        color: AppColors.onSurface,
      ),
      dropdownColor: AppColors.surfaceContainerLowest,
      items: options,
      onChanged: null,
    );
  }

  InputDecoration _dropdownDecoration({required String hintText}) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: GoogleFonts.inter(
        fontSize: 15,
        fontWeight: FontWeight.w500,
        color: AppColors.onSurfaceVariant.withOpacity(0.65),
      ),
      filled: true,
      fillColor: AppColors.surfaceContainerHighest.withOpacity(0.45),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppColors.primary, width: 1.4),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
    );
  }
}
