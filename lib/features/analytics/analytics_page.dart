import 'package:expense_project/features/transactions/transactions_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/transaction_model.dart';

class AnalyticsPage extends ConsumerWidget {
  const AnalyticsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final txAsync = ref.watch(transactionsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Analytics')),
      body: txAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (txs) {
          final income = txs
              .where((t) => t.type == TransactionType.income)
              .fold(0.0, (s, t) => s + t.amount);
          final expense = txs
              .where((t) => t.type == TransactionType.expense)
              .fold(0.0, (s, t) => s + t.amount);
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _Bar(label: 'Income', amount: income, color: Colors.green),
                const SizedBox(height: 16),
                _Bar(label: 'Expense', amount: expense, color: Colors.red),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _Bar extends StatelessWidget {
  final String label;
  final double amount;
  final Color color;
  const _Bar({required this.label, required this.amount, required this.color});

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Text(label, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 4),
          Container(
            height: 20,
            width: amount == 0 ? 50 : amount / 10, // naïve scaling
            color: color,
          ),
          const SizedBox(height: 4),
          Text('₹${amount.toStringAsFixed(2)}'),
        ],
      );
}
