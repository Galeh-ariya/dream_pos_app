import 'package:dream_pos/bloc/employees/store_employee/store_employee_bloc.dart';
import 'package:dream_pos/bloc/positions/list_position/list_position_bloc.dart';
import 'package:dream_pos/core/colors.dart';
import 'package:dream_pos/data/models/request/employee_request_model.dart';
import 'package:dream_pos/data/models/response/position_response_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class FormEmployeeScreen extends StatefulWidget {
  const FormEmployeeScreen({
    super.key,
    required this.selectedOutletId,
    this.selectedOutletName,
    this.initialEmail,
    this.initialFullName,
    this.initialJabatanId,
  });

  final String selectedOutletId;
  final String? selectedOutletName;
  final String? initialEmail;
  final String? initialFullName;
  final int? initialJabatanId;

  @override
  State<FormEmployeeScreen> createState() => _FormEmployeeScreenState();
}

class _FormEmployeeScreenState extends State<FormEmployeeScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();

  int? _selectedJabatanId;

  bool get _isEditMode => (widget.initialEmail ?? '').trim().isNotEmpty;

  @override
  void initState() {
    super.initState();
    _emailController.text = widget.initialEmail ?? '';
    _fullNameController.text = widget.initialFullName ?? '';
    _selectedJabatanId = widget.initialJabatanId;

    context.read<ListPositionBloc>().add(
      ListPositionEvent.fetchPositions(widget.selectedOutletId),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _fullNameController.dispose();
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
          _isEditMode ? 'Form Edit Karyawan' : 'Form Karyawan',
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.onSurface,
            letterSpacing: -0.2,
          ),
        ),
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<StoreEmployeeBloc, StoreEmployeeState>(
            listener: (context, state) {
              state.whenOrNull(
                success: (message) {
                  if (!mounted) return;
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(message)));

                  Navigator.of(context).pop({'saved': true});
                },
                error: (message) {
                  if (!mounted) return;
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(message)));
                },
              );
            },
          ),
          BlocListener<ListPositionBloc, ListPositionState>(
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
        ],
        child: BlocBuilder<StoreEmployeeBloc, StoreEmployeeState>(
          builder: (context, storeState) {
            final isSaving = storeState.maybeWhen(
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
                      _isEditMode ? 'Edit Karyawan' : 'Tambah Karyawan',
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
                          _buildLabel('Email'),
                          const SizedBox(height: 8),
                          TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            style: _inputStyle(),
                            decoration: _inputDecoration(
                              hintText: 'Masukkan email karyawan...',
                            ),
                            validator: (value) {
                              if ((value ?? '').trim().isEmpty) {
                                return 'Email wajib diisi.';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 14),
                          _buildLabel('Password'),
                          const SizedBox(height: 8),
                          TextFormField(
                            controller: _passwordController,
                            obscureText: true,
                            textInputAction: TextInputAction.next,
                            style: _inputStyle(),
                            decoration: _inputDecoration(
                              hintText: _isEditMode
                                  ? 'Masukkan password baru...'
                                  : 'Masukkan password...',
                            ),
                            validator: (value) {
                              if ((value ?? '').trim().isEmpty) {
                                return 'Password wajib diisi.';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 14),
                          _buildLabel('Full Name'),
                          const SizedBox(height: 8),
                          TextFormField(
                            controller: _fullNameController,
                            textInputAction: TextInputAction.next,
                            style: _inputStyle(),
                            decoration: _inputDecoration(
                              hintText: 'Masukkan nama lengkap...',
                            ),
                            validator: (value) {
                              if ((value ?? '').trim().isEmpty) {
                                return 'Full name wajib diisi.';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 14),
                          _buildLabel('Jabatan'),
                          const SizedBox(height: 8),
                          _buildPositionDropdown(isSaving: isSaving),
                          const SizedBox(height: 14),
                          _buildLabel('Outlet'),
                          const SizedBox(height: 8),
                          InputDecorator(
                            decoration: _inputDecoration(hintText: 'Outlet'),
                            child: Text(
                              (widget.selectedOutletName ?? '').trim().isEmpty
                                  ? widget.selectedOutletId
                                  : widget.selectedOutletName!.trim(),
                              style: _inputStyle(),
                            ),
                          ),
                          const SizedBox(height: 18),
                          SizedBox(
                            width: double.infinity,
                            child: FilledButton(
                              onPressed: isSaving ? null : _saveEmployee,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.person_add_alt_rounded,
                                          size: 20,
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          _isEditMode
                                              ? 'Simpan Perubahan'
                                              : 'Masukkan Karyawan',
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
      ),
    );
  }

  Widget _buildPositionDropdown({required bool isSaving}) {
    return BlocBuilder<ListPositionBloc, ListPositionState>(
      builder: (context, state) {
        return state.when(
          initial: _buildPositionLoadingField,
          loading: _buildPositionLoadingField,
          success: (positions) => _buildPositionSelect(positions, isSaving),
          error: _buildPositionErrorField,
        );
      },
    );
  }

  Widget _buildPositionLoadingField() {
    return InputDecorator(
      decoration: _inputDecoration(hintText: 'Memuat daftar jabatan...'),
      child: const LinearProgressIndicator(minHeight: 3),
    );
  }

  Widget _buildPositionErrorField(String message) {
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
            'Gagal memuat jabatan',
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
              context.read<ListPositionBloc>().add(
                ListPositionEvent.fetchPositions(widget.selectedOutletId),
              );
            },
            child: const Text('Coba Lagi'),
          ),
        ],
      ),
    );
  }

  Widget _buildPositionSelect(
    List<PositionResponseModel> positions,
    bool isSaving,
  ) {
    final options = positions
        .where((position) => position.id != null)
        .map(
          (position) => DropdownMenuItem<int>(
            value: position.id,
            child: Text(
              (position.namaJabatan ?? '-').trim().isEmpty
                  ? '-'
                  : position.namaJabatan!.trim(),
              style: _inputStyle(),
            ),
          ),
        )
        .toList(growable: false);

    final hasSelected = options.any((item) => item.value == _selectedJabatanId);
    final selectedValue = hasSelected ? _selectedJabatanId : null;

    if (options.isEmpty) {
      return InputDecorator(
        decoration: _inputDecoration(hintText: 'Belum ada jabatan tersedia'),
        child: Text(
          'Silakan tambahkan jabatan pada outlet ini terlebih dahulu.',
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.onSurfaceVariant,
          ),
        ),
      );
    }

    return DropdownButtonFormField<int>(
      value: selectedValue,
      isExpanded: true,
      icon: const Icon(Icons.keyboard_arrow_down_rounded),
      decoration: _inputDecoration(hintText: 'Pilih jabatan...'),
      style: _inputStyle(),
      dropdownColor: AppColors.surfaceContainerLowest,
      items: options,
      onChanged: isSaving
          ? null
          : (value) {
              setState(() {
                _selectedJabatanId = value;
              });
            },
      validator: (value) {
        if (value == null) {
          return 'Jabatan wajib dipilih.';
        }
        return null;
      },
    );
  }

  Future<void> _saveEmployee() async {
    if (!_formKey.currentState!.validate()) return;

    final jabatanId = _selectedJabatanId;
    if (jabatanId == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Jabatan wajib dipilih.')));
      return;
    }

    final payload = EmployeeRequestModel(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
      fullName: _fullNameController.text.trim(),
    );

    context.read<StoreEmployeeBloc>().add(
      StoreEmployeeEvent.storeEmployee(
        payload,
        widget.selectedOutletId,
        jabatanId,
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

  TextStyle _inputStyle() {
    return GoogleFonts.inter(
      fontSize: 15,
      fontWeight: FontWeight.w500,
      color: AppColors.onSurface,
    );
  }

  InputDecoration _inputDecoration({required String hintText}) {
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
