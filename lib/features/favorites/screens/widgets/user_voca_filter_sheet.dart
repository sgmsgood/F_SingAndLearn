import 'package:flutter/material.dart';

enum VocaStatusFilter { all, unknown, known }

Future<VocaStatusFilter?> openVocaFilterSheet(
    BuildContext context, {
      required VocaStatusFilter current,
    }) {
  return showModalBottomSheet<VocaStatusFilter>(
    context: context,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
    ),
    builder: (context) {
      Widget tile(String title, VocaStatusFilter value) {
        final selected = current == value;
        return ListTile(
          onTap: () => Navigator.pop(context, value),
          title: Text(title, style: TextStyle(fontWeight: selected ? FontWeight.w800 : FontWeight.w600)),
          trailing: selected ? Icon(Icons.check, color: Theme.of(context).colorScheme.primary) : null,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        );
      }

      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 10, 12, 14),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 44,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(99),
                ),
              ),
              const SizedBox(height: 14),
              tile('전체', VocaStatusFilter.all),
              tile('모름', VocaStatusFilter.unknown),
              tile('외움', VocaStatusFilter.known),
              const SizedBox(height: 6),
            ],
          ),
        ),
      );
    },
  );
}