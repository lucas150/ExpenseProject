
// ignore_for_file: deprecated_member_use
import 'package:expense_project/app/app_theme.dart';
import 'package:flutter/material.dart';

class TransactionFilterChips extends StatelessWidget {
  // Customize for minimal chips
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _chip('All', selected: true),
          _chip('Today'),
          _chip('Last 7 days'),
          _chip('Last 30 days'),
        ],
      ),
    );
  }

  Widget _chip(String label, {bool selected = false}) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(label, style: TextStyle(fontSize: 14)),
        selected: selected,
        onSelected: (_) {},
        backgroundColor: Colors.grey[200],
        selectedColor: palette[AppColors.primary]?.withOpacity(0.2),
      ),
    );
  }
}
