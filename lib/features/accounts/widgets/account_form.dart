import 'package:flutter/material.dart';
import '../../../core/models/account_model.dart';
import 'package:uuid/uuid.dart';

class AccountForm extends StatefulWidget {
  final Account? existing;
  final void Function(Account) onSubmit;
  const AccountForm({super.key, this.existing, required this.onSubmit});

  @override
  State<AccountForm> createState() => _AccountFormState();
}

class _AccountFormState extends State<AccountForm> {
  late final _name = TextEditingController(text: widget.existing?.name);
  late final _balance = TextEditingController(
    text: widget.existing?.balance.toString() ?? '',
  );
  String _type = 'Cash';

  @override
  Widget build(BuildContext context) => AlertDialog(
    title: Text(widget.existing == null ? 'New Account' : 'Edit Account'),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          controller: _name,
          decoration: const InputDecoration(labelText: 'Name'),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _balance,
          decoration: const InputDecoration(labelText: 'Opening Balance'),
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: _type,
          items: const [
            DropdownMenuItem(value: 'Cash', child: Text('Cash')),
            DropdownMenuItem(value: 'Bank', child: Text('Bank')),
            DropdownMenuItem(value: 'Wallet', child: Text('Wallet')),
          ],
          onChanged: (v) => setState(() => _type = v!),
          decoration: const InputDecoration(labelText: 'Type'),
        ),
      ],
    ),
    actions: [
      TextButton(
        onPressed: Navigator.of(context).pop,
        child: const Text('Cancel'),
      ),
      ElevatedButton(
        onPressed: () {
          final acc = Account(
            id: widget.existing?.id ?? const Uuid().v4(),
            name: _name.text,
            balance: double.tryParse(_balance.text) ?? 0,
            type: _type,
            role: AccountRole.both,
          );
          widget.onSubmit(acc);
          Navigator.of(context).pop();
        },
        child: const Text('Save'),
      ),
    ],
  );
}
