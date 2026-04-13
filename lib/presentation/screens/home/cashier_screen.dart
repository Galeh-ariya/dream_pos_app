import 'package:dream_pos/bloc/outlets/list_outlet/list_outlet_bloc.dart';
import 'package:dream_pos/core/colors.dart';
import 'package:dream_pos/data/models/response/outlet_reponse_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class CashierScreen extends StatefulWidget {
  const CashierScreen({super.key});

  @override
  State<CashierScreen> createState() => _CashierScreenState();
}

class _CashierScreenState extends State<CashierScreen> {
  static const List<_OutletAccent> _accents = [
    _OutletAccent(
      iconColor: Color(0xFF7C4DFF),
      iconBackground: Color(0xFFF1EBFF),
    ),
    _OutletAccent(
      iconColor: Color(0xFFFF9800),
      iconBackground: Color(0xFFFFF2E3),
    ),
    _OutletAccent(
      iconColor: Color(0xFF22C55E),
      iconBackground: Color(0xFFE8FAEF),
    ),
    _OutletAccent(
      iconColor: Color(0xFFF472B6),
      iconBackground: Color(0xFFFDE8F2),
    ),
    _OutletAccent(
      iconColor: Color(0xFF3B82F6),
      iconBackground: Color(0xFFEAF2FF),
    ),
    _OutletAccent(
      iconColor: Color(0xFF14B8A6),
      iconBackground: Color(0xFFE6FFFB),
    ),
  ];

  @override
  void initState() {
    super.initState();
    context.read<ListOutletBloc>().add(const ListOutletEvent.fetchOutlets());
  }

  void _fetchOutlets() {
    context.read<ListOutletBloc>().add(const ListOutletEvent.fetchOutlets());
  }

  void _openCashier(OutletResponseModel outlet) {
    final outletName = outlet.name?.trim().isNotEmpty == true
        ? outlet.name!.trim()
        : '-';

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Membuka kasir untuk outlet: $outletName')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
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
              success: (outlets) => _buildContent(outlets),
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

  Widget _buildErrorBody(String message) {
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
                color: AppColors.onSurfaceVariant,
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

  Widget _buildContent(List<OutletResponseModel> outlets) {
    final size = MediaQuery.sizeOf(context);
    final isLandscape = size.width > size.height;
    final isTablet = size.shortestSide >= 600;
    final crossAxisCount = isTablet
        ? (isLandscape ? 4 : 3)
        : (isLandscape ? 3 : 2);
    final gridSpacing = isTablet ? 16.0 : 12.0;
    final childAspectRatio = isTablet && isLandscape ? 1.12 : 1.0;
    final contentMaxWidth = isTablet ? 1220.0 : 700.0;
    final horizontalPadding = isTablet ? 24.0 : 16.0;
    final verticalTopPadding = isTablet ? 20.0 : 12.0;
    final sectionPadding = isTablet ? 18.0 : 14.0;

    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: contentMaxWidth),
        child: ListView(
          padding: EdgeInsets.fromLTRB(
            horizontalPadding,
            verticalTopPadding,
            horizontalPadding,
            24,
          ),
          children: [
            Text(
              'Kasir',
              style: GoogleFonts.inter(
                fontSize: isTablet ? 32 : 26,
                fontWeight: FontWeight.w800,
                color: AppColors.onSurface,
                letterSpacing: -0.6,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Pilih outlet yang ingin dibuka untuk transaksi kasir.',
              style: GoogleFonts.inter(
                fontSize: isTablet ? 15 : 14,
                fontWeight: FontWeight.w500,
                color: AppColors.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: EdgeInsets.all(sectionPadding),
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerLowest,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: AppColors.outlineVariant.withOpacity(0.14),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Outlet Aktif',
                    style: GoogleFonts.inter(
                      fontSize: isTablet ? 14 : 13,
                      fontWeight: FontWeight.w700,
                      color: AppColors.onSurfaceVariant,
                      letterSpacing: 0.2,
                    ),
                  ),
                  const SizedBox(height: 12),
                  if (outlets.isEmpty)
                    _buildEmptyState()
                  else
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: outlets.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        mainAxisSpacing: gridSpacing,
                        crossAxisSpacing: gridSpacing,
                        childAspectRatio: childAspectRatio,
                      ),
                      itemBuilder: (context, index) {
                        return _buildOutletCard(
                          outlets[index],
                          index,
                          isTablet: isTablet,
                        );
                      },
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.12),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.storefront_rounded,
              color: AppColors.primary,
              size: 28,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Belum ada outlet',
            style: GoogleFonts.inter(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: AppColors.onSurface,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Outlet akan muncul di sini untuk dipilih sebelum membuka kasir.',
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

  Widget _buildOutletCard(
    OutletResponseModel outlet,
    int index, {
    required bool isTablet,
  }) {
    final outletName = outlet.name?.trim().isNotEmpty == true
        ? outlet.name!.trim()
        : '-';
    final outletAddress = outlet.address?.trim().isNotEmpty == true
        ? outlet.address!.trim()
        : 'Belum ada alamat';
    final accent = _accents[index % _accents.length];

    return InkWell(
      onTap: () => _openCashier(outlet),
      borderRadius: BorderRadius.circular(18),
      child: Container(
        padding: EdgeInsets.all(isTablet ? 16 : 14),
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: AppColors.outlineVariant.withOpacity(0.12)),
          boxShadow: [
            BoxShadow(
              color: AppColors.onSurface.withOpacity(0.05),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: isTablet ? 48 : 42,
                  height: isTablet ? 48 : 42,
                  decoration: BoxDecoration(
                    color: accent.iconBackground,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    Icons.store_rounded,
                    color: AppColors.primary,
                    size: isTablet ? 24 : 22,
                  ),
                ),
                const Spacer(),
                Icon(
                  Icons.chevron_right_rounded,
                  color: accent.iconColor,
                  size: isTablet ? 26 : 24,
                ),
              ],
            ),
            const Spacer(),
            Text(
              outletName,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.inter(
                fontSize: isTablet ? 16 : 15,
                fontWeight: FontWeight.w800,
                color: AppColors.onSurface,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              outletAddress,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.inter(
                fontSize: isTablet ? 12.5 : 11.5,
                fontWeight: FontWeight.w500,
                color: AppColors.onSurfaceVariant,
                height: 1.35,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OutletAccent {
  const _OutletAccent({required this.iconColor, required this.iconBackground});

  final Color iconColor;
  final Color iconBackground;
}
