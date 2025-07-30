import 'package:expense_project/features/transactions/transaction_add_page.dart';
import 'package:expense_project/features/transactions/transactions_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/transaction_model.dart';

class TransactionsListPage extends ConsumerWidget {
  const TransactionsListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final txAsync = ref.watch(transactionsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('All Transactions')),
      body: txAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (txs) => txs.isEmpty
            ? const Center(child: Text('No transactions yet'))
            : ListView.separated(
                itemCount: txs.length,
                separatorBuilder: (_, __) => const Divider(height: 0),
                itemBuilder: (_, i) => _TxTile(tx: txs[i]),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const AddTransactionPage()),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _TxTile extends ConsumerWidget {
  final TransactionModel tx;
  const _TxTile({required this.tx});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(transactionsProvider.notifier);

    return ListTile(
      leading: Icon(
        tx.type == TransactionType.income ? Icons.south_west : Icons.north_east,
        color: tx.type == TransactionType.income ? Colors.green : Colors.red,
      ),
      title: Text(tx.title),
      subtitle: Text(
        '${tx.category ?? 'Uncategorised'} • ${tx.account ?? 'No Account'}',
      ),
      trailing: Text(
        '₹${tx.amount.toStringAsFixed(2)}',
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      onLongPress: () => showModalBottomSheet(
        context: context,
        builder: (_) => SafeArea(
          child: ListTile(
            leading: const Icon(Icons.delete),
            title: const Text('Delete'),
            onTap: () async {
              await notifier.deleteTransaction(tx.id);
              if (context.mounted) Navigator.pop(context);
            },
          ),
        ),
      ),
    );
  }
}
