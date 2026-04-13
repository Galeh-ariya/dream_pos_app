import 'package:dream_pos/core/colors.dart';
import 'package:dream_pos/data/models/response/position_response_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AccessBulkDraft {
  const AccessBulkDraft({
    required this.id,
    this.isExpanded = true,
    this.jabatanId,
    this.kategoriMenu,
    this.namaAkses,
    this.valueAkses,
  });

  factory AccessBulkDraft.empty(String id) {
    return AccessBulkDraft(id: id);
  }

  final String id;
  final bool isExpanded;
  final int? jabatanId;
  final String? kategoriMenu;
  final String? namaAkses;
  final bool? valueAkses;

  AccessBulkDraft copyWith({
    String? id,
    bool? isExpanded,
    int? jabatanId,
    String? kategoriMenu,
    String? namaAkses,
    bool? valueAkses,
  }) {
    return AccessBulkDraft(
      id: id ?? this.id,
      isExpanded: isExpanded ?? this.isExpanded,
      jabatanId: jabatanId ?? this.jabatanId,
      kategoriMenu: kategoriMenu ?? this.kategoriMenu,
      namaAkses: namaAkses ?? this.namaAkses,
      valueAkses: valueAkses ?? this.valueAkses,
    );
  }

  bool get isMaster => kategoriMenu == 'Master';
}

class AccessBulkFormCard extends StatelessWidget {
  const AccessBulkFormCard({
    super.key,
    required this.draft,
    required this.index,
    required this.positions,
    required this.onChanged,
    required this.onDelete,
    required this.onToggleExpanded,
  });

  final AccessBulkDraft draft;
  final int index;
  final List<PositionResponseModel> positions;
  final ValueChanged<AccessBulkDraft> onChanged;
  final VoidCallback onDelete;
  final VoidCallback onToggleExpanded;

  static const List<String> _kategoriMenuOptions = [
    'Home',
    'Master',
    'Kasir',
    'Profil',
  ];

  static const Map<String, String> _masterAksesOptions = {
    'outlet': 'kelola outlet',
    'access': 'kelola hak akses',
    'employee': 'kelola karyawan',
    'position': 'kelola jabatan',
    'item': 'kelola item',
    'item_categories': 'kelola kategori item',
    'unit': 'kelola satuan',
  };

  @override
  Widget build(BuildContext context) {
    final positionName =
        positions
            .firstWhere(
              (position) => position.id == draft.jabatanId,
              orElse: () => PositionResponseModel(),
            )
            .namaJabatan
            ?.trim() ??
        '-';
    final kategoriLabel = draft.kategoriMenu ?? '-';
    final namaAksesLabel = draft.isMaster
        ? (_masterAksesOptions[draft.namaAkses] ?? '-')
        : (draft.namaAkses ?? '-');
    final valueLabel = draft.valueAkses == null
        ? '-'
        : draft.valueAkses.toString();

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.outlineVariant.withOpacity(0.18)),
      ),
      child: Column(
        children: [
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(18),
              onTap: onToggleExpanded,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(14, 14, 14, 12),
                child: Row(
                  children: [
                    Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.12),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          '${index + 1}',
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            fontWeight: FontWeight.w800,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Draft Hak Akses ${index + 1}',
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                              color: AppColors.onSurface,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            '$positionName | $kategoriLabel | $namaAksesLabel | $valueLabel',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: AppColors.onSurfaceVariant,
                              height: 1.35,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: onToggleExpanded,
                      icon: Icon(
                        draft.isExpanded
                            ? Icons.expand_less_rounded
                            : Icons.expand_more_rounded,
                      ),
                      color: AppColors.onSurfaceVariant,
                    ),
                    IconButton(
                      onPressed: onDelete,
                      icon: const Icon(Icons.delete_outline_rounded),
                      color: const Color(0xFFDE2B2B),
                    ),
                  ],
                ),
              ),
            ),
          ),
          AnimatedCrossFade(
            firstChild: _buildDetails(),
            secondChild: const SizedBox.shrink(),
            crossFadeState: draft.isExpanded
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
            duration: const Duration(milliseconds: 220),
            sizeCurve: Curves.easeInOut,
          ),
        ],
      ),
    );
  }

  Widget _buildDetails() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 2),
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Text(
              'Jabatan',
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: AppColors.onSurface,
              ),
            ),
          ),
          const SizedBox(height: 8),
          _buildPositionDropdown(),
          const SizedBox(height: 14),
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Text(
              'Kategori Menu',
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: AppColors.onSurface,
              ),
            ),
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            value: draft.kategoriMenu,
            isExpanded: true,
            icon: const Icon(Icons.keyboard_arrow_down_rounded),
            decoration: _fieldDecoration(hintText: 'Pilih kategori menu...'),
            style: GoogleFonts.inter(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: AppColors.onSurface,
            ),
            dropdownColor: AppColors.surfaceContainerLowest,
            items: _kategoriMenuOptions
                .map(
                  (option) => DropdownMenuItem<String>(
                    value: option,
                    child: Text(
                      option,
                      style: GoogleFonts.inter(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: AppColors.onSurface,
                      ),
                    ),
                  ),
                )
                .toList(growable: false),
            onChanged: (value) {
              final nextNamaAkses = value == 'Master'
                  ? null
                  : value?.toLowerCase();
              onChanged(
                draft.copyWith(kategoriMenu: value, namaAkses: nextNamaAkses),
              );
            },
          ),
          const SizedBox(height: 14),
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Text(
              'Nama Akses',
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: AppColors.onSurface,
              ),
            ),
          ),
          const SizedBox(height: 8),
          _buildNamaAksesField(),
          const SizedBox(height: 14),
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Text(
              'Value Akses',
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: AppColors.onSurface,
              ),
            ),
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField<bool>(
            value: draft.valueAkses,
            isExpanded: true,
            icon: const Icon(Icons.keyboard_arrow_down_rounded),
            decoration: _fieldDecoration(hintText: 'Pilih true atau false...'),
            style: GoogleFonts.inter(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: AppColors.onSurface,
            ),
            dropdownColor: AppColors.surfaceContainerLowest,
            items: const [
              DropdownMenuItem<bool>(value: true, child: Text('true')),
              DropdownMenuItem<bool>(value: false, child: Text('false')),
            ],
            onChanged: (value) {
              onChanged(draft.copyWith(valueAkses: value));
            },
          ),
          const SizedBox(height: 10),
          Text(
            'Outlet ID akan diambil dari halaman sebelumnya saat draft ini dikirim.',
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

  Widget _buildPositionDropdown() {
    final items = positions
        .where((position) => position.id != null)
        .map(
          (position) => DropdownMenuItem<int>(
            value: position.id,
            child: Text(
              position.namaJabatan?.trim().isEmpty == true
                  ? '-'
                  : position.namaJabatan!.trim(),
              style: GoogleFonts.inter(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: AppColors.onSurface,
              ),
            ),
          ),
        )
        .toList(growable: false);

    if (items.isEmpty) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerHighest.withOpacity(0.45),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          'Belum ada jabatan tersedia',
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.onSurfaceVariant,
          ),
        ),
      );
    }

    return DropdownButtonFormField<int>(
      value: draft.jabatanId,
      isExpanded: true,
      icon: const Icon(Icons.keyboard_arrow_down_rounded),
      decoration: _fieldDecoration(hintText: 'Pilih jabatan...'),
      style: GoogleFonts.inter(
        fontSize: 15,
        fontWeight: FontWeight.w500,
        color: AppColors.onSurface,
      ),
      dropdownColor: AppColors.surfaceContainerLowest,
      items: items,
      onChanged: (value) {
        onChanged(draft.copyWith(jabatanId: value));
      },
    );
  }

  Widget _buildNamaAksesField() {
    if (draft.kategoriMenu == 'Master') {
      return DropdownButtonFormField<String>(
        value: draft.namaAkses,
        isExpanded: true,
        icon: const Icon(Icons.keyboard_arrow_down_rounded),
        decoration: _fieldDecoration(hintText: 'Pilih nama akses...'),
        style: GoogleFonts.inter(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: AppColors.onSurface,
        ),
        dropdownColor: AppColors.surfaceContainerLowest,
        items: _masterAksesOptions.entries
            .map(
              (entry) => DropdownMenuItem<String>(
                value: entry.key,
                child: Text(
                  entry.value,
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: AppColors.onSurface,
                  ),
                ),
              ),
            )
            .toList(growable: false),
        onChanged: (value) {
          onChanged(draft.copyWith(namaAkses: value));
        },
      );
    }

    final autoValue = draft.kategoriMenu?.toLowerCase() ?? '-';

    return InputDecorator(
      decoration: _fieldDecoration(
        hintText: 'Pilih kategori menu terlebih dahulu',
      ),
      child: Text(
        autoValue,
        style: GoogleFonts.inter(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: AppColors.onSurface,
        ),
      ),
    );
  }

  InputDecoration _fieldDecoration({required String hintText}) {
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
