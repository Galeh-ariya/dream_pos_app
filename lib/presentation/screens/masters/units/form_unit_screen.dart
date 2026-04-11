import 'package:dream_pos/core/colors.dart';
import 'package:dream_pos/bloc/outlets/list_outlet/list_outlet_bloc.dart';
import 'package:dream_pos/bloc/units/store_unit/store_unit_bloc.dart';
import 'package:dream_pos/data/models/response/outlet_reponse_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class FormUnitScreen extends StatefulWidget {
  const FormUnitScreen({super.key, this.initialUnitName, this.initialOutletId});

  final String? initialUnitName;
  final String? initialOutletId;

  @override
  State<FormUnitScreen> createState() => _FormUnitScreenState();
}

class _FormUnitScreenState extends State<FormUnitScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _unitNameController = TextEditingController();

  String? _selectedOutletId;
  bool get _isOutletLocked => (widget.initialOutletId ?? '').trim().isNotEmpty;

  bool get _isEditMode =>
      widget.initialUnitName != null &&
      widget.initialUnitName!.trim().isNotEmpty;

  @override
  void initState() {
    super.initState();
    _unitNameController.text = widget.initialUnitName ?? '';
    _selectedOutletId = widget.initialOutletId;
    context.read<ListOutletBloc>().add(const ListOutletEvent.fetchOutlets());
  }

  @override
  void dispose() {
    _unitNameController.dispose();
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
          _isEditMode ? 'Form Edit Satuan' : 'Form Satuan Baru',
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.onSurface,
            letterSpacing: -0.2,
          ),
        ),
      ),
      body: BlocConsumer<StoreUnitBloc, StoreUnitState>(
        listener: (context, state) {
          state.whenOrNull(
            success: (message) {
              if (!mounted) return;
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(message)));

              Navigator.of(context).pop({
                'name': _unitNameController.text.trim(),
                'outlet_id': _selectedOutletId,
              });
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
                    _isEditMode ? 'Edit Data Satuan' : 'Tambah Data Satuan',
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
                            'Nama Satuan',
                            style: GoogleFonts.inter(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: AppColors.onSurface,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _unitNameController,
                          textInputAction: TextInputAction.done,
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppColors.onSurface,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Masukkan nama satuan...',
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
                              return 'Nama satuan wajib diisi.';
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
                        _buildOutletInput(isSaving: isSaving),
                        const SizedBox(height: 18),
                        SizedBox(
                          width: double.infinity,
                          child: FilledButton(
                            onPressed: isSaving ? null : _saveUnit,
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
                                            : 'Simpan Data Satuan',
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

  Widget _buildOutletInput({required bool isSaving}) {
    return BlocBuilder<ListOutletBloc, ListOutletState>(
      builder: (context, state) {
        return state.when(
          initial: _buildOutletLoadingField,
          loading: _buildOutletLoadingField,
          success: (outlets) =>
              _buildOutletDropdown(outlets, isSaving: isSaving),
          error: (message) => _buildOutletErrorField(message),
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

  Widget _buildOutletDropdown(
    List<OutletResponseModel> outlets, {
    required bool isSaving,
  }) {
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
      onChanged: (isSaving || _isOutletLocked)
          ? null
          : (value) {
              setState(() {
                _selectedOutletId = value;
              });
            },
      validator: (value) {
        if ((value ?? '').trim().isEmpty) {
          return 'Outlet wajib dipilih.';
        }
        return null;
      },
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

  Future<void> _saveUnit() async {
    if (!_formKey.currentState!.validate()) return;

    final name = _unitNameController.text.trim();
    final selectedOutletId = _selectedOutletId;
    if (selectedOutletId == null || selectedOutletId.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Outlet wajib dipilih.')));
      return;
    }

    context.read<StoreUnitBloc>().add(
      StoreUnitEvent.storeUnit(selectedOutletId, name),
    );
  }
}
