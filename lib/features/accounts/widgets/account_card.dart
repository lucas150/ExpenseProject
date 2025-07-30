import 'package:flutter/material.dart';
import '../../../core/models/account_model.dart';

class AccountCard extends StatelessWidget {
  final Account account;
  const AccountCard({super.key, required this.account});

  @override
  Widget build(BuildContext context) => Card(
    child: ListTile(
      leading: const Icon(Icons.account_balance_wallet),
      title: Text(account.name),
      subtitle: Text(account.type),
      trailing: Text(
        '₹${account.balance.toStringAsFixed(2)}',
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
  );
}
