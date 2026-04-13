import 'package:dream_pos/bloc/access/list_access/list_access_bloc.dart';
import 'package:dream_pos/bloc/access/del_access/del_access_bloc.dart';
import 'package:dream_pos/bloc/access/status_access/status_access_bloc.dart';
import 'package:dream_pos/bloc/positions/list_position/list_position_bloc.dart';
import 'package:dream_pos/core/colors.dart';
import 'package:dream_pos/data/models/response/access_response_model.dart';
import 'package:dream_pos/data/models/response/position_response_model.dart';
import 'package:dream_pos/data/repositories/access_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class ListAccessScreen extends StatefulWidget {
  const ListAccessScreen({
    super.key,
    required this.selectedOutletId,
    this.selectedOutletName,
  });

  final String selectedOutletId;
  final String? selectedOutletName;

  @override
  State<ListAccessScreen> createState() => _ListAccessScreenState();
}

class _ListAccessScreenState extends State<ListAccessScreen> {
  @override
  void initState() {
    super.initState();
    _fetchPositions();
  }

  void _fetchPositions() {
    context.read<ListPositionBloc>().add(
      ListPositionEvent.fetchPositions(widget.selectedOutletId),
    );
  }

  void _onAddAccessPressed() {
    final outletId = widget.selectedOutletId.trim();
    if (outletId.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Outlet tidak valid.')));
      return;
    }

    context.pushNamed(
      'master-form-access',
      extra: {'outletId': outletId, 'outletName': widget.selectedOutletName},
    );
  }

  @override
  Widget build(BuildContext context) {
    final outletName = widget.selectedOutletName?.trim().isNotEmpty == true
        ? widget.selectedOutletName!.trim()
        : '-';

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
            'Detail Hak Akses',
            style: GoogleFonts.inter(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: AppColors.onSurface,
              letterSpacing: -0.3,
            ),
          ),
        ),
      ),
      body: BlocConsumer<ListPositionBloc, ListPositionState>(
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
            error: _buildErrorBody,
            success: (positions) => _buildContent(outletName, positions),
          );
        },
      ),
    );
  }

  Widget _buildLoadingBody() {
    return const Center(child: CircularProgressIndicator());
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
              onPressed: _fetchPositions,
              child: const Text('Coba Lagi'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(
    String outletName,
    List<PositionResponseModel> positions,
  ) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerLow,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Text(
            'Outlet: $outletName',
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: AppColors.onSurface,
            ),
          ),
        ),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: AppColors.outlineVariant.withOpacity(0.18),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.badge_outlined,
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
                      'Total Jabatan',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${positions.length} jabatan tersedia',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: AppColors.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: FilledButton.icon(
            onPressed: _onAddAccessPressed,
            icon: const Icon(Icons.add_rounded, size: 18),
            label: Text(
              'Tambah Hak Akses',
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),
        ),
        const SizedBox(height: 14),
        if (positions.isEmpty)
          _buildEmptyState()
        else
          ...positions.map(
            (position) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _PositionAccessCard(
                position: position,
                selectedOutletId: widget.selectedOutletId,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          Icon(
            Icons.badge_outlined,
            size: 38,
            color: AppColors.onSurfaceVariant,
          ),
          const SizedBox(height: 10),
          Text(
            'Belum ada jabatan pada outlet ini',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppColors.onSurface,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Tambahkan jabatan dulu, lalu tiap jabatan bisa dibuka untuk melihat hak aksesnya.',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: AppColors.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _PositionAccessCard extends StatefulWidget {
  const _PositionAccessCard({
    required this.position,
    required this.selectedOutletId,
  });

  final PositionResponseModel position;
  final String selectedOutletId;

  @override
  State<_PositionAccessCard> createState() => _PositionAccessCardState();
}

class _PositionAccessCardState extends State<_PositionAccessCard> {
  late final ListAccessBloc _accessBloc;
  bool _isExpanded = false;
  bool _hasRequestedData = false;
  String? _pendingDeleteId;
  String? _pendingStatusId;

  @override
  void initState() {
    super.initState();
    _accessBloc = ListAccessBloc(AccessRepository());
  }

  @override
  void dispose() {
    _accessBloc.close();
    super.dispose();
  }

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
    });

    if (_isExpanded && !_hasRequestedData) {
      _hasRequestedData = true;
      _fetchAccessForPosition();
    }
  }

  void _fetchAccessForPosition() {
    final jabatanId = widget.position.id;
    if (jabatanId == null) return;

    _accessBloc.add(
      ListAccessEvent.fetchAccessByJabatan(widget.selectedOutletId, jabatanId),
    );
  }

  void _onToggleStatusPressed(AccessResponseModel akses) {
    final accessId = akses.id?.trim();
    if (accessId == null || accessId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('ID hak akses tidak valid.')),
      );
      return;
    }

    final currentValue = akses.valueAkses;
    final nextValue = !(currentValue ?? false);

    setState(() {
      _pendingStatusId = accessId;
    });

    context.read<StatusAccessBloc>().add(
      StatusAccessEvent.toggleStatus(accessId, nextValue),
    );
  }

  Future<void> _onDeletePressed(AccessResponseModel akses) async {
    final accessId = akses.id?.trim();
    if (accessId == null || accessId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('ID hak akses tidak valid.')),
      );
      return;
    }

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Hapus Hak Akses'),
          content: const Text('Yakin ingin menghapus data hak akses ini?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Batal'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Hapus'),
            ),
          ],
        );
      },
    );

    if (confirmed != true) return;

    setState(() {
      _pendingDeleteId = accessId;
    });

    context.read<DelAccessBloc>().add(DelAccessEvent.deleteAccess(accessId));
  }

  @override
  Widget build(BuildContext context) {
    final jabatanName = widget.position.namaJabatan?.trim().isNotEmpty == true
        ? widget.position.namaJabatan!.trim()
        : 'Jabatan belum diisi';

    return MultiBlocListener(
      listeners: [
        BlocListener<StatusAccessBloc, StatusAccessState>(
          listener: (context, state) {
            state.whenOrNull(
              success: (message) {
                if (_pendingStatusId == null) return;

                if (!mounted) return;
                setState(() {
                  _pendingStatusId = null;
                });

                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(message)));
                _fetchAccessForPosition();
              },
              error: (message) {
                if (_pendingStatusId == null) return;

                if (!mounted) return;
                setState(() {
                  _pendingStatusId = null;
                });

                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(message)));
              },
            );
          },
        ),
        BlocListener<DelAccessBloc, DelAccessState>(
          listener: (context, state) {
            state.whenOrNull(
              success: (message) {
                if (_pendingDeleteId == null) return;

                if (!mounted) return;
                setState(() {
                  _pendingDeleteId = null;
                });

                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(message)));
                _fetchAccessForPosition();
              },
              error: (message) {
                if (_pendingDeleteId == null) return;

                if (!mounted) return;
                setState(() {
                  _pendingDeleteId = null;
                });

                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(message)));
              },
            );
          },
        ),
      ],
      child: BlocProvider.value(
        value: _accessBloc,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: AppColors.outlineVariant.withOpacity(0.18),
            ),
          ),
          child: Column(
            children: [
              InkWell(
                onTap: _toggleExpanded,
                borderRadius: BorderRadius.circular(16),
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Row(
                    children: [
                      Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.12),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.badge_outlined,
                          size: 20,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              jabatanName,
                              style: GoogleFonts.inter(
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                                color: AppColors.onSurface,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Klik untuk melihat hak akses',
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: AppColors.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                      AnimatedRotation(
                        turns: _isExpanded ? 0.5 : 0,
                        duration: const Duration(milliseconds: 220),
                        child: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: AppColors.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              AnimatedCrossFade(
                firstChild: const SizedBox.shrink(),
                secondChild: Padding(
                  padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
                  child: BlocConsumer<ListAccessBloc, ListAccessState>(
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
                        initial: () => const SizedBox.shrink(),
                        loading: () => const Padding(
                          padding: EdgeInsets.symmetric(vertical: 18),
                          child: Center(child: CircularProgressIndicator()),
                        ),
                        error: (message) => _buildInlineError(message),
                        loaded: (aksesList) {
                          if (aksesList.isEmpty) {
                            return _buildInlineEmpty();
                          }

                          return Column(
                            children: aksesList
                                .map(_buildAccessItemCard)
                                .toList(growable: false),
                          );
                        },
                      );
                    },
                  ),
                ),
                crossFadeState: _isExpanded
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 220),
                sizeCurve: Curves.easeOut,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInlineEmpty() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(
        'Belum ada hak akses untuk jabatan ini.',
        style: GoogleFonts.inter(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: AppColors.onSurfaceVariant,
        ),
      ),
    );
  }

  Widget _buildInlineError(String message) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            message,
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 10),
          FilledButton(
            onPressed: _fetchAccessForPosition,
            child: const Text('Coba Lagi'),
          ),
        ],
      ),
    );
  }

  Widget _buildAccessItemCard(AccessResponseModel akses) {
    final kategoriMenu = akses.kategoriMenu?.trim();
    final namaAkses = akses.namaAkses?.trim();
    final kategoriLabel = (kategoriMenu == null || kategoriMenu.isEmpty)
        ? 'Kategori'
        : kategoriMenu;
    final namaLabel = (namaAkses == null || namaAkses.isEmpty)
        ? '-'
        : namaAkses;
    final valueAksesLabel = akses.valueAkses == null
        ? 'belum diisi'
        : (akses.valueAkses == true ? 'aktif' : 'nonaktif');
    final isActive = akses.valueAkses == true;
    final accessId = akses.id?.trim();
    final isStatusProcessing =
        accessId != null && accessId.isNotEmpty && _pendingStatusId == accessId;
    final isDeleteProcessing =
        accessId != null && accessId.isNotEmpty && _pendingDeleteId == accessId;

    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.outlineVariant.withOpacity(0.18)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  '$kategoriLabel: $namaLabel',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: AppColors.onSurface,
                    height: 1.3,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: isActive
                      ? Colors.green.withOpacity(0.14)
                      : AppColors.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  '($valueAksesLabel)',
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: isActive
                        ? Colors.green.shade700
                        : AppColors.onSurfaceVariant,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              OutlinedButton.icon(
                onPressed: isStatusProcessing || isDeleteProcessing
                    ? null
                    : () => _onToggleStatusPressed(akses),
                icon: Icon(
                  isActive ? Icons.toggle_off_rounded : Icons.toggle_on_rounded,
                  size: 18,
                ),
                label: Text(
                  isStatusProcessing ? '...' : (isActive ? 'Off' : 'On'),
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  visualDensity: VisualDensity.compact,
                  foregroundColor: isActive
                      ? const Color(0xFFB3261E)
                      : Colors.green.shade700,
                  side: BorderSide(
                    color: isActive
                        ? const Color(0xFFDE2B2B)
                        : Colors.green.shade600,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              // Tooltip(
              //   message: 'Edit',
              //   child: OutlinedButton(
              //     onPressed: isStatusProcessing || isDeleteProcessing
              //         ? null
              //         : () {
              //             ScaffoldMessenger.of(context).showSnackBar(
              //               const SnackBar(
              //                 content: Text('Aksi edit belum dihubungkan.'),
              //               ),
              //             );
              //           },
              //     style: OutlinedButton.styleFrom(
              //       visualDensity: VisualDensity.compact,
              //       minimumSize: const Size(36, 36),
              //       padding: EdgeInsets.zero,
              //       side: BorderSide(
              //         color: AppColors.outlineVariant.withOpacity(0.45),
              //       ),
              //     ),
              //     child: const Icon(Icons.edit_outlined, size: 18),
              //   ),
              // ),
              // const SizedBox(width: 8),
              Tooltip(
                message: 'Delete',
                child: OutlinedButton(
                  onPressed: isStatusProcessing || isDeleteProcessing
                      ? null
                      : () => _onDeletePressed(akses),
                  style: OutlinedButton.styleFrom(
                    visualDensity: VisualDensity.compact,
                    minimumSize: const Size(36, 36),
                    padding: EdgeInsets.zero,
                    foregroundColor: const Color(0xFFB3261E),
                    side: const BorderSide(color: Color(0xFFDE2B2B)),
                  ),
                  child: Icon(
                    isDeleteProcessing
                        ? Icons.hourglass_top_rounded
                        : Icons.delete_outline_rounded,
                    size: 18,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
