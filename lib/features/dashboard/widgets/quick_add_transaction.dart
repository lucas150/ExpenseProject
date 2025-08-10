import 'package:expense_project/app/app_theme.dart';
import 'package:flutter/material.dart';

class QuickAddTransaction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: palette[AppColors.surface],
        foregroundColor: palette[AppColors.onSurface],
        elevation: 0,
        side: BorderSide(color: Colors.grey[300]!),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.add, size: 20),
          SizedBox(width: 8),
          Text('Add Transaction'),
        ],
      ),
    );
  }
}
