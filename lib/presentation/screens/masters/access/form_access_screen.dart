import 'package:dream_pos/bloc/access/bulk_access/bulk_access_bloc.dart';
import 'package:dream_pos/bloc/access/list_access/list_access_bloc.dart';
import 'package:dream_pos/bloc/positions/list_position/list_position_bloc.dart';
import 'package:dream_pos/core/colors.dart';
import 'package:dream_pos/data/models/request/access_request_model.dart';
import 'package:dream_pos/data/models/response/position_response_model.dart';
import 'package:dream_pos/presentation/widgets/access_bulk_form_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class FormAccessScreen extends StatefulWidget {
  const FormAccessScreen({
    super.key,
    required this.selectedOutletId,
    this.selectedOutletName,
  });

  final String selectedOutletId;
  final String? selectedOutletName;

  @override
  State<FormAccessScreen> createState() => _FormAccessScreenState();
}

class _FormAccessScreenState extends State<FormAccessScreen> {
  final List<AccessBulkDraft> _drafts = [AccessBulkDraft.empty('draft-1')];
  int _draftSeed = 2;

  @override
  void initState() {
    super.initState();
    context.read<ListPositionBloc>().add(
      ListPositionEvent.fetchPositions(widget.selectedOutletId),
    );
  }

  void _addDraft() {
    setState(() {
      _drafts.add(AccessBulkDraft.empty('draft-$_draftSeed'));
      _draftSeed += 1;
    });
  }

  void _removeDraft(String draftId) {
    if (_drafts.length == 1) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Minimal satu draft harus tetap ada.')),
      );
      return;
    }

    setState(() {
      _drafts.removeWhere((draft) => draft.id == draftId);
    });
  }

  void _updateDraft(AccessBulkDraft updatedDraft) {
    setState(() {
      final index = _drafts.indexWhere((draft) => draft.id == updatedDraft.id);
      if (index != -1) {
        _drafts[index] = updatedDraft;
      }
    });
  }

  void _toggleDraftExpanded(String draftId) {
    setState(() {
      final index = _drafts.indexWhere((draft) => draft.id == draftId);
      if (index != -1) {
        _drafts[index] = _drafts[index].copyWith(
          isExpanded: !_drafts[index].isExpanded,
        );
      }
    });
  }

  void _submitBulkDrafts() {
    for (final draft in _drafts) {
      final validationMessage = _validateDraft(draft);
      if (validationMessage != null) {
        setState(() {
          final index = _drafts.indexWhere((item) => item.id == draft.id);
          if (index != -1) {
            _drafts[index] = _drafts[index].copyWith(isExpanded: true);
          }
        });

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(validationMessage)));
        return;
      }
    }

    final requests = _drafts
        .map(
          (draft) => AccessRequestModel(
            outletId: widget.selectedOutletId,
            jabatanId: draft.jabatanId,
            kategoriMenu: draft.kategoriMenu,
            namaAkses: draft.namaAkses,
            valueAkses: draft.valueAkses,
          ),
        )
        .toList(growable: false);

    context.read<BulkAccessBloc>().add(
      BulkAccessEvent.storeBulkAccess(requests),
    );
  }

  String? _validateDraft(AccessBulkDraft draft) {
    if (draft.jabatanId == null) {
      return 'Pilih jabatan untuk setiap draft.';
    }

    if (draft.kategoriMenu == null || draft.kategoriMenu!.trim().isEmpty) {
      return 'Kategori menu belum lengkap.';
    }

    if (draft.namaAkses == null || draft.namaAkses!.trim().isEmpty) {
      return 'Nama akses belum lengkap.';
    }

    if (draft.valueAkses == null) {
      return 'Value akses belum dipilih.';
    }

    return null;
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
            'Bulk Hak Akses',
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
            success: (positions) {
              return BlocConsumer<BulkAccessBloc, BulkAccessState>(
                listener: (context, bulkState) {
                  bulkState.whenOrNull(
                    success: (message) {
                      if (!mounted) return;

                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(message)));

                      context.read<ListAccessBloc>().add(
                        ListAccessEvent.fetchAccess(widget.selectedOutletId),
                      );

                      if (Navigator.of(context).canPop()) {
                        Navigator.of(context).pop();
                      }
                    },
                    error: (message) {
                      if (!mounted) return;

                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(message)));
                    },
                  );
                },
                builder: (context, bulkState) {
                  return _buildContent(outletName, positions, bulkState);
                },
              );
            },
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
              onPressed: () {
                context.read<ListPositionBloc>().add(
                  ListPositionEvent.fetchPositions(widget.selectedOutletId),
                );
              },
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
    BulkAccessState bulkState,
  ) {
    final isSubmitting = bulkState.maybeWhen(
      loading: () => true,
      orElse: () => false,
    );

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLowest,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: AppColors.outlineVariant.withOpacity(0.18),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Outlet Terpilih',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: AppColors.onSurfaceVariant,
                    letterSpacing: 0.2,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  outletName,
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: AppColors.onSurface,
                    letterSpacing: -0.3,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Outlet ID: ${widget.selectedOutletId}',
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Draft Hak Akses',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: AppColors.onSurface,
                  ),
                ),
              ),
              TextButton.icon(
                onPressed: _addDraft,
                icon: const Icon(Icons.add_rounded, size: 18),
                label: Text(
                  'Tambah Form',
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            'Klik + untuk menambah draft baru. Setiap draft bisa ditutup, dibuka lagi, atau dihapus sebelum dikirim sekaligus.',
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: AppColors.onSurfaceVariant,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 14),
          ..._drafts.asMap().entries.map((entry) {
            final index = entry.key;
            final draft = entry.value;

            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: AccessBulkFormCard(
                draft: draft,
                index: index,
                positions: positions,
                onChanged: _updateDraft,
                onDelete: () => _removeDraft(draft.id),
                onToggleExpanded: () => _toggleDraftExpanded(draft.id),
              ),
            );
          }),
          const SizedBox(height: 6),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: isSubmitting ? null : _submitBulkDrafts,
              icon: const Icon(Icons.send_rounded, size: 18),
              label: Text(
                isSubmitting ? 'Mengirim...' : 'Kirim Semua Draft',
                style: GoogleFonts.inter(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                minimumSize: const Size.fromHeight(56),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                elevation: 0,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Bagian ini masih desain. Saat store bloc siap, daftar draft ini tinggal dikirim sebagai bulk create.',
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
