import 'package:dream_pos/bloc/outlets/del_outlet/del_outlet_bloc.dart';
import 'package:dream_pos/bloc/outlets/list_outlet/list_outlet_bloc.dart';
import 'package:dream_pos/data/models/response/outlet_reponse_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';

class ListOutletScreen extends StatefulWidget {
  const ListOutletScreen({super.key});

  @override
  State<ListOutletScreen> createState() => _ListOutletScreenState();
}

class _ListOutletScreenState extends State<ListOutletScreen> {
  String? _deletingOutletId;

  @override
  void initState() {
    super.initState();
    context.read<ListOutletBloc>().add(const ListOutletEvent.fetchOutlets());
  }

  void _fetchOutlets() {
    context.read<ListOutletBloc>().add(const ListOutletEvent.fetchOutlets());
  }

  Future<void> _confirmDeleteOutlet(OutletResponseModel outlet) async {
    final outletId = outlet.id;
    if (outletId == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('ID outlet tidak valid.')));
      return;
    }

    final isConfirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Hapus outlet?'),
          content: Text(
            'Data ${outlet.name ?? 'outlet ini'} akan dihapus dari daftar.',
          ),
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

    if (isConfirmed != true) return;

    setState(() {
      _deletingOutletId = outletId;
    });

    context.read<DelOutletBloc>().add(DelOutletEvent.delOutlet(outletId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F4F8),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF1F4F8),
        elevation: 0,
        scrolledUnderElevation: 0,
        titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Daftar Outlet',
            style: GoogleFonts.inter(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF1E222B),
              letterSpacing: -0.4,
            ),
          ),
        ),
      ),
      body: BlocListener<DelOutletBloc, DelOutletState>(
        listener: (context, delState) {
          delState.whenOrNull(
            success: (message) {
              if (mounted) {
                setState(() {
                  _deletingOutletId = null;
                });
              }
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(message)));
              _fetchOutlets();
            },
            error: (message) {
              if (mounted) {
                setState(() {
                  _deletingOutletId = null;
                });
              }
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(message)));
            },
          );
        },
        child: BlocConsumer<ListOutletBloc, ListOutletState>(
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
              success: (outlets) {
                return ListView(
                  padding: const EdgeInsets.fromLTRB(16, 6, 16, 20),
                  children: [
                    _buildOutletSummary(outlets.length),
                    const SizedBox(height: 14),
                    if (outlets.isEmpty)
                      _buildEmptyState()
                    else
                      ...outlets.map(_buildOutletCard),
                  ],
                );
              },
              error: (message) => _buildErrorState(message),
            );
          },
        ),
      ),
    );
  }

  Widget _buildLoadingBody() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildErrorState(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.error_outline_rounded,
              size: 42,
              color: Color(0xFFDE2B2B),
            ),
            const SizedBox(height: 10),
            Text(
              message,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF505663),
              ),
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: _fetchOutlets,
              child: const Text('Coba Lagi'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFD),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.storefront_outlined,
            size: 42,
            color: Color(0xFF6A7280),
          ),
          const SizedBox(height: 8),
          Text(
            'Belum ada outlet terdaftar',
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF2A303B),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Silakan tambahkan outlet baru untuk mulai menggunakan sistem.',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF505663),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOutletSummary(int totalOutlets) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFE9EDF3),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total Outlet',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.3,
                    color: const Color(0xFF6A7280),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$totalOutlets Outlet Terdaftar',
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    height: 1.2,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF2A303B),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          FilledButton.icon(
            onPressed: () async {
              await context.pushNamed('master-form-outlet');
              if (!mounted) return;
              _fetchOutlets();
            },
            icon: const Icon(Icons.add_business_rounded, size: 18),
            label: Text(
              'Daftarkan Outlet',
              style: GoogleFonts.inter(fontWeight: FontWeight.w600),
            ),
            style: FilledButton.styleFrom(
              backgroundColor: const Color(0xFF0E64D9),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOutletCard(OutletResponseModel outlet) {
    const accentColor = Color(0xFF005CC8);
    const iconBackground = Color(0xFFDCE9FF);
    const iconColor = Color(0xFF0F63D8);
    final method = (outlet.fifoLifo ?? 'FIFO').toUpperCase();
    final isDeleting = _deletingOutletId == outlet.id;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFD),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: iconBackground,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.storefront_rounded,
                  size: 24,
                  color: iconColor,
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () async {
                  await context.pushNamed('master-form-outlet', extra: outlet);
                  if (!mounted) return;
                  _fetchOutlets();
                },
                splashRadius: 18,
                visualDensity: VisualDensity.compact,
                icon: const Icon(
                  Icons.edit_outlined,
                  size: 20,
                  color: Color(0xFF454A58),
                ),
              ),
              IconButton(
                onPressed: isDeleting
                    ? null
                    : () => _confirmDeleteOutlet(outlet),
                splashRadius: 18,
                visualDensity: VisualDensity.compact,
                icon: isDeleting
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
                        size: 21,
                        color: Color(0xFFDE2B2B),
                      ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            outlet.name ?? '-',
            style: GoogleFonts.inter(
              fontSize: 39 / 2,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1E222B),
              letterSpacing: -0.25,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            outlet.address ?? '-',
            style: GoogleFonts.inter(
              fontSize: 14,
              height: 1.38,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF505663),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: accentColor,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'METODE: $method',
                style: GoogleFonts.inter(
                  fontSize: 22 / 2,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.3,
                  color: accentColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
