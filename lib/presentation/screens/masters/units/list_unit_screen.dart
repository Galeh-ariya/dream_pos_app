import 'package:dream_pos/core/colors.dart';
import 'package:dream_pos/bloc/units/del_unit/del_unit_bloc.dart';
import 'package:dream_pos/bloc/units/list_unit/list_unit_bloc.dart';
import 'package:dream_pos/data/models/response/unit_response_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class ListUnitScreen extends StatefulWidget {
  const ListUnitScreen({
    super.key,
    required this.selectedOutletId,
    this.selectedOutletName,
  });

  final String selectedOutletId;
  final String? selectedOutletName;

  @override
  State<ListUnitScreen> createState() => _ListUnitScreenState();
}

class _ListUnitScreenState extends State<ListUnitScreen> {
  final TextEditingController _searchController = TextEditingController();
  int? _deletingUnitId;

  @override
  void initState() {
    super.initState();
    _fetchUnits();
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
      body: MultiBlocListener(
        listeners: [
          BlocListener<ListUnitBloc, ListUnitState>(
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
          BlocListener<DelUnitBloc, DelUnitState>(
            listener: (context, state) {
              state.whenOrNull(
                success: (message) {
                  if (!mounted) return;

                  setState(() {
                    _deletingUnitId = null;
                  });

                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(message)));

                  _fetchUnits();
                },
                error: (message) {
                  if (!mounted) return;

                  setState(() {
                    _deletingUnitId = null;
                  });

                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(message)));
                },
              );
            },
          ),
        ],
        child: BlocBuilder<ListUnitBloc, ListUnitState>(
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

  Widget _buildSuccessBody(List<UnitResponseModel> units) {
    final query = _searchController.text.trim().toLowerCase();
    final filteredUnits = units
        .where((unit) => (unit.namaSatuan ?? '').toLowerCase().contains(query))
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
        if (filteredUnits.isEmpty)
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
              onPressed: _fetchUnits,
              child: const Text('Coba Lagi'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUnitCard(UnitResponseModel unit) {
    final unitName = (unit.namaSatuan ?? '').trim().isEmpty
        ? '-'
        : unit.namaSatuan!.trim();

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
          BlocBuilder<DelUnitBloc, DelUnitState>(
            builder: (context, state) {
              final isDeletingThisRow =
                  _deletingUnitId != null && _deletingUnitId == unit.id;
              final isBlocDeleting = state.maybeWhen(
                loading: () => true,
                orElse: () => false,
              );

              return IconButton(
                onPressed: (isBlocDeleting || isDeletingThisRow)
                    ? null
                    : () => _onDeleteUnit(unit),
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
            ? 'Satuan tidak ditemukan.'
            : 'Belum ada satuan pada outlet ini.',
        style: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppColors.onSurfaceVariant,
        ),
      ),
    );
  }

  void _fetchUnits() {
    context.read<ListUnitBloc>().add(
      ListUnitEvent.fetchUnits(widget.selectedOutletId),
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

  Future<void> _onCreateUnit() async {
    final result = await context.pushNamed(
      'master-form-unit',
      extra: {'initialOutletId': widget.selectedOutletId},
    );

    if (!mounted) return;
    if (result != null) {
      _fetchUnits();
    }
  }

  Future<void> _onDeleteUnit(UnitResponseModel unit) async {
    final unitId = unit.id;
    final outletId = unit.outletId;
    final unitName = (unit.namaSatuan ?? '-').trim().isEmpty
        ? '-'
        : unit.namaSatuan!.trim();

    if (unitId == null || outletId == null || outletId.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Data unit tidak valid. Gagal menghapus satuan.'),
        ),
      );
      return;
    }

    final isConfirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Hapus Satuan'),
          content: Text('Yakin ingin menghapus satuan $unitName?'),
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
      _deletingUnitId = unitId;
    });

    context.read<DelUnitBloc>().add(DelUnitEvent.delUnit(unitId, outletId));
  }
}
