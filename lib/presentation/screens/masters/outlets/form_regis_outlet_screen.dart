import 'package:dream_pos/bloc/outlets/store_outlet/store_outlet_bloc.dart';
import 'package:dream_pos/bloc/outlets/update_outlet/update_outlet_bloc.dart';
import 'package:dream_pos/core/index.dart';
import 'package:dream_pos/data/models/request/outlet_request_model.dart';
import 'package:dream_pos/data/models/response/outlet_reponse_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class FormRegisOutletScreen extends StatefulWidget {
  const FormRegisOutletScreen({super.key, this.outlet});

  final OutletResponseModel? outlet;

  @override
  State<FormRegisOutletScreen> createState() => _FormRegisOutletScreenState();
}

class _FormRegisOutletScreenState extends State<FormRegisOutletScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  _InventoryMethod _selectedMethod = _InventoryMethod.fifo;

  bool get _isEditMode => widget.outlet != null;

  @override
  void initState() {
    super.initState();
    final outlet = widget.outlet;
    if (outlet == null) return;

    _nameController.text = outlet.name ?? '';
    _addressController.text = outlet.address ?? '';
    _selectedMethod = _inventoryMethodFromValue(outlet.fifoLifo);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
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
          _isEditMode ? 'Form Edit Outlet' : 'Form Pendaftaran Outlet',
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.onSurface,
            letterSpacing: -0.2,
          ),
        ),
      ),
      body: _isEditMode
          ? BlocConsumer<UpdateOutletBloc, UpdateOutletState>(
              listener: (context, state) {
                state.whenOrNull(
                  success: (message) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(message)));
                    if (mounted) {
                      Navigator.of(context).pop();
                    }
                  },
                  error: (message) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(message)));
                  },
                );
              },
              builder: (context, state) {
                final isLoading = state.maybeWhen(
                  loading: () => true,
                  orElse: () => false,
                );

                return _buildFormContent(isLoading: isLoading);
              },
            )
          : BlocConsumer<StoreOutletBloc, StoreOutletState>(
              listener: (context, state) {
                state.whenOrNull(
                  success: (message) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(message)));
                    if (mounted) {
                      Navigator.of(context).pop();
                    }
                  },
                  error: (message) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(message)));
                  },
                );
              },
              builder: (context, state) {
                final isLoading = state.maybeWhen(
                  loading: () => true,
                  orElse: () => false,
                );

                return _buildFormContent(isLoading: isLoading);
              },
            ),
    );
  }

  Widget _buildFormContent({required bool isLoading}) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'FORM',
            style: GoogleFonts.inter(
              fontSize: 30 / 2,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.0,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            _isEditMode ? 'Edit Data Outlet' : 'Data Outlet Baru',
            style: GoogleFonts.inter(
              fontSize: 52 / 2,
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
                _buildLabel('Nama Outlet'),
                const SizedBox(height: 8),
                _buildInput(
                  controller: _nameController,
                  hint: 'Masukkan nama outlet...',
                ),
                const SizedBox(height: 16),
                _buildLabel('Alamat Lengkap'),
                const SizedBox(height: 8),
                _buildInput(
                  controller: _addressController,
                  hint: 'Jl. Sudirman No. 123...',
                  maxLines: 3,
                ),
                const SizedBox(height: 16),
                _buildLabel('Metode Inventaris'),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: _buildMethodCard(
                        method: _InventoryMethod.fifo,
                        title: 'FIFO',
                        subtitle: 'First In,\nFirst Out',
                        icon: Icons.inventory_2_outlined,
                        isEnabled: !isLoading,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildMethodCard(
                        method: _InventoryMethod.lifo,
                        title: 'LIFO',
                        subtitle: 'Last In, First\nOut',
                        icon: Icons.history_toggle_off_rounded,
                        isEnabled: !isLoading,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: isLoading ? null : _saveOutlet,
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      disabledBackgroundColor: AppColors.primary.withOpacity(0.45),
                      disabledForegroundColor: Colors.white70,
                      minimumSize: const Size.fromHeight(56),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 0,
                    ),
                    child: isLoading
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
                                _isEditMode ? 'Memproses...' : 'Menyimpan...',
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
                                    : 'Simpan Data Outlet',
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
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Text(
        text,
        style: GoogleFonts.inter(
          fontSize: 15,
          fontWeight: FontWeight.w700,
          color: AppColors.onSurface,
        ),
      ),
    );
  }

  Widget _buildInput({
    required TextEditingController controller,
    required String hint,
    int maxLines = 1,
    TextInputType? keyboardType,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      style: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: AppColors.onSurface,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppColors.onSurfaceVariant.withOpacity(0.5),
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
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 14,
        ),
      ),
    );
  }

  Widget _buildMethodCard({
    required _InventoryMethod method,
    required String title,
    required String subtitle,
    required IconData icon,
    bool isEnabled = true,
  }) {
    final isSelected = _selectedMethod == method;

    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: isEnabled ? () => setState(() => _selectedMethod = method) : null,
      child: Container(
        padding: const EdgeInsets.fromLTRB(12, 12, 10, 12),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withOpacity(0.08)
              : AppColors.surfaceContainerHigh.withOpacity(0.4),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected
                ? AppColors.primary
                : AppColors.outlineVariant.withOpacity(0.22),
            width: isSelected ? 1.8 : 1,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              size: 21,
              color: isSelected
                  ? AppColors.primary
                  : AppColors.onSurfaceVariant,
            ),
            const SizedBox(width: 9),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.inter(
                      fontSize: 34 / 2,
                      fontWeight: FontWeight.w700,
                      color: AppColors.onSurface,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      height: 1.2,
                      color: AppColors.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _InventoryMethod _inventoryMethodFromValue(String? value) {
    final normalized = value?.toUpperCase();
    if (normalized == 'LIFO') return _InventoryMethod.lifo;
    return _InventoryMethod.fifo;
  }

  void _saveOutlet() {
    final name = _nameController.text.trim();
    final address = _addressController.text.trim();

    if (name.isEmpty || address.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nama outlet dan alamat wajib diisi.')),
      );
      return;
    }

    if (_isEditMode) {
      final outletId = widget.outlet?.id;
      if (outletId == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('ID outlet tidak ditemukan.')),
        );
        return;
      }

      final model = OutletRequestModel(
        id: outletId,
        name: name,
        address: address,
        fifoLifo: _selectedMethod.name.toUpperCase(),
      );

      context.read<UpdateOutletBloc>().add(
        UpdateOutletEvent.updateOutlet(model),
      );
      return;
    }

    final model = OutletRequestModel(
      name: name,
      address: address,
      fifoLifo: _selectedMethod.name.toUpperCase(),
    );

    context.read<StoreOutletBloc>().add(StoreOutletEvent.createOutlet(model));
  }
}

enum _InventoryMethod { fifo, lifo }
