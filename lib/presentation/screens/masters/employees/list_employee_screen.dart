import 'package:dream_pos/bloc/employees/list_employee/list_employee_bloc.dart';
import 'package:dream_pos/core/colors.dart';
import 'package:dream_pos/data/models/response/employee_response_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class ListEmployeeScreen extends StatefulWidget {
  const ListEmployeeScreen({
    super.key,
    required this.selectedOutletId,
    this.selectedOutletName,
  });

  final String selectedOutletId;
  final String? selectedOutletName;

  @override
  State<ListEmployeeScreen> createState() => _ListEmployeeScreenState();
}

class _ListEmployeeScreenState extends State<ListEmployeeScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchEmployees();
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
            'Daftar Employee',
            style: GoogleFonts.inter(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: AppColors.onSurface,
              letterSpacing: -0.3,
            ),
          ),
        ),
      ),
      body: BlocConsumer<ListEmployeeBloc, ListEmployeeState>(
        listener: (context, state) {
          state.whenOrNull(
            error: (message) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(message)));
            },
          );
        },
        builder: (context, state) {
          return state.when(
            initial: _buildLoadingBody,
            loading: _buildLoadingBody,
            success: _buildSuccessBody,
            error: _buildErrorBody,
          );
        },
      ),
    );
  }

  Widget _buildLoadingBody() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildSuccessBody(List<EmployeeResponseModel> employees) {
    final query = _searchController.text.trim().toLowerCase();
    final filteredEmployees = employees
        .where(
          (employee) =>
              (employee.fullName ?? '').toLowerCase().contains(query) ||
              (employee.email ?? '').toLowerCase().contains(query) ||
              (employee.role ?? '').toLowerCase().contains(query),
        )
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
                  hintText: 'Cari employee...',
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
              onPressed: _onCreateEmployee,
              icon: const Icon(Icons.add_rounded, size: 18),
              label: Text(
                'Tambah Karyawan',
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
        ...filteredEmployees.map((employee) {
          return InkWell(
            borderRadius: BorderRadius.circular(14),
            onTap: () => _onEditEmployee(employee),
            child: _buildEmployeeCard(employee),
          );
        }),
        if (filteredEmployees.isEmpty)
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
              onPressed: _fetchEmployees,
              child: const Text('Coba Lagi'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmployeeCard(EmployeeResponseModel employee) {
    final fullName = (employee.fullName ?? '').trim().isEmpty
        ? '-'
        : employee.fullName!.trim();
    final email = (employee.email ?? '').trim().isEmpty
        ? '-'
        : employee.email!.trim();
    final role = (employee.role ?? '').trim().isEmpty
        ? '-'
        : employee.role!.trim();

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.outlineVariant.withOpacity(0.18)),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.12),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.person_outline_rounded,
              size: 22,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fullName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.onSurface,
                    letterSpacing: -0.2,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  email,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Role: $role',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.edit_outlined,
            size: 18,
            color: AppColors.onSurfaceVariant,
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
            ? 'Employee tidak ditemukan.'
            : 'Belum ada employee pada outlet ini.',
        style: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppColors.onSurfaceVariant,
        ),
      ),
    );
  }

  void _fetchEmployees() {
    context.read<ListEmployeeBloc>().add(
      ListEmployeeEvent.fetchEmployees(widget.selectedOutletId),
    );
  }

  Future<void> _onCreateEmployee() async {
    final result = await context.pushNamed(
      'master-form-employee',
      extra: {
        'selectedOutletId': widget.selectedOutletId,
        'selectedOutletName': widget.selectedOutletName,
      },
    );

    if (!mounted) return;
    if (result != null) {
      _fetchEmployees();
    }
  }

  Future<void> _onEditEmployee(EmployeeResponseModel employee) async {
    final result = await context.pushNamed(
      'master-form-employee',
      extra: {
        'selectedOutletId': widget.selectedOutletId,
        'selectedOutletName': widget.selectedOutletName,
        'initialEmail': employee.email,
        'initialFullName': employee.fullName,
        'initialJabatanId': employee.jabatanId,
      },
    );

    if (!mounted) return;
    if (result != null) {
      _fetchEmployees();
    }
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
}
