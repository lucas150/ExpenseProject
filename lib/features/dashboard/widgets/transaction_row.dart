import 'package:expense_project/app/app_theme.dart';
import 'package:expense_project/features/dashboard/widgets/getCategoryIcon.dart';
import 'package:expense_project/features/settings/modern_settings_page.dart';
import 'package:flutter/material.dart';
import 'package:expense_project/core/models/transaction_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget transactionRow(
  WidgetRef ref,
  TransactionModel transaction,
  Color text1,
  Color text2,
  Color green,
  Color red,
) {
  final isExpense = transaction.type == TransactionType.expense;
  final amountColor = isExpense ? red : green;
  final isDark = ref.watch(themeProvider);
  final themeData = isDark
      ? AppTheme.darkTheme(null)
      : AppTheme.lightTheme(null);
  final surface = themeData.colorScheme.surface;

  String capitalize(String? text) {
    if (text == null || text.isEmpty) return '';
    return text[0].toUpperCase() + text.substring(1);
  }

  return Container(
    margin: const EdgeInsets.symmetric(vertical: 6),
    // padding: const EdgeInsets.symmetric(horizontal: 16),
    decoration: BoxDecoration(
      // color: surface.withOpacity(0.5), // Use your surface color
      borderRadius: BorderRadius.circular(12),
      // boxShadow: [
      //   BoxShadow(
      //     // color: Colors.black.withOpacity(0.04),
      //     blurRadius: 6,
      //     offset: const Offset(0, 2),
      //   ),
      // ],
    ),

    child: Row(
      children: [
        // Brand/Category Icon
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: amountColor.withOpacity(0.12),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: FaIcon(
              getCategoryIcon(transaction.category, transaction.title),
              size: 18,
              color: amountColor,
            ),
          ),
        ),
        const SizedBox(width: 14),

        // Transaction Title & Category
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                capitalize(transaction.title),
                style: TextStyle(
                  fontSize: 15,
                  color: text1,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                capitalize(transaction.category),
                style: TextStyle(fontSize: 12, color: text2),
              ),
            ],
          ),
        ),

        // Amount & Date
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '${isExpense ? '-' : '+'}₹${transaction.amount.toStringAsFixed(0)}',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: amountColor,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              formatSimpleDate(transaction.date),
              style: TextStyle(fontSize: 11, color: text2),
            ),
          ],
        ),
      ],
    ),
  );
}

String formatSimpleDate(DateTime date) {
  final now = DateTime.now();
  final diff = now.difference(date).inDays;

  if (diff == 0) return 'Today';
  if (diff == 1) return 'Yesterday';
  if (diff < 7) return '${diff}d';

  return '${date.day}/${date.month}';
}
