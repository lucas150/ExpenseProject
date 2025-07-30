import 'package:expense_project/features/accounts/accounts_provider.dart';
import 'package:expense_project/features/accounts/widgets/account_card.dart';
import 'package:expense_project/features/accounts/widgets/account_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/account_model.dart';

class AccountsPage extends ConsumerWidget {
  const AccountsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accAsync = ref.watch(accountsProvider);
    final notifier = ref.read(accountsProvider.notifier);

    void _openForm([Account? acc]) => showDialog(
      context: context,
      builder: (_) => AccountForm(
        existing: acc,
        onSubmit: (a) async {
          acc == null
              ? await notifier.addAccount(a)
              : await notifier.updateAccount(a);
        },
      ),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Accounts')),
      body: accAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (list) => list.isEmpty
            ? const Center(child: Text('No accounts yet'))
            : ListView(
                padding: const EdgeInsets.all(12),
                children: list
                    .map(
                      (a) => GestureDetector(
                        onLongPress: () => notifier.deleteAccount(a.id),
                        onTap: () => _openForm(a),
                        child: AccountCard(account: a),
                      ),
                    )
                    .toList(),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openForm(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
