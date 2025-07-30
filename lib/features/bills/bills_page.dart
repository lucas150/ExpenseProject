import 'package:expense_project/features/bills/bills_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/bill_model.dart';
import 'package:uuid/uuid.dart';

class BillsPage extends ConsumerWidget {
  const BillsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final billsAsync = ref.watch(billsProvider);

    Future<void> _addBill() async {
      final title = TextEditingController();
      final amount = TextEditingController();
      DateTime date = DateTime.now().add(const Duration(days: 30));

      await showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('New Bill'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: title, decoration: const InputDecoration(labelText: 'Title')),
              TextField(controller: amount, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Amount')),
              const SizedBox(height: 8),
              ElevatedButton(
                  onPressed: () async {
                    final d = await showDatePicker(
                      context: context,
                      initialDate: date,
                      firstDate: DateTime.now().subtract(const Duration(days: 1)),
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                    );
                    if (d != null) date = d;
                  },
                  child: const Text('Select Due Date')),
            ],
          ),
          actions: [
            TextButton(onPressed: Navigator.of(context).pop, child: const Text('Cancel')),
            ElevatedButton(
              onPressed: () {
                final bill = BillModel(
                  id: const Uuid().v4(),
                  title: title.text,
                  amount: double.tryParse(amount.text) ?? 0,
                  dueDate: date,
                );
                ref.read(billsProvider.notifier).add(bill);
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Bills')),
      body: billsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (bills) => bills.isEmpty
            ? const Center(child: Text('No bills added'))
            : ListView.builder(
                itemCount: bills.length,
                itemBuilder: (_, i) {
                  final b = bills[i];
                  return CheckboxListTile(
                    title: Text(b.title),
                    subtitle: Text(
                        '₹${b.amount.toStringAsFixed(2)} • Due ${b.dueDate.day}/${b.dueDate.month}/${b.dueDate.year}'),
                    value: b.paid,
                    onChanged: (_) => ref.read(billsProvider.notifier).togglePaid(b),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addBill,
        child: const Icon(Icons.add),
      ),
    );
  }
}
