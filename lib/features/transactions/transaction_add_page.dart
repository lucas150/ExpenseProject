import 'package:expense_project/features/accounts/accounts_provider.dart';
import 'package:expense_project/features/transactions/transactions_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../../core/models/transaction_model.dart';

class AddTransactionPage extends ConsumerStatefulWidget {
  const AddTransactionPage({super.key});

  @override
  ConsumerState<AddTransactionPage> createState() => _AddTransactionPageState();
}

class _AddTransactionPageState extends ConsumerState<AddTransactionPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();

  TransactionType _selectedType = TransactionType.expense;
  String? _selectedAccount; // Starts as null - no account selected
  String? _selectedCategory;
  DateTime _selectedDate = DateTime.now();

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final accountsAsync = ref.watch(accountsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Transaction'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Transaction Type Selection - UPDATED: Only Income/Expense
              Text(
                'Transaction Type',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Row(
                children: TransactionType.values.map((type) {
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: ChoiceChip(
                        label: Text(_getTypeLabel(type)),
                        selected: _selectedType == type,
                        onSelected: (selected) {
                          if (selected) setState(() => _selectedType = type);
                        },
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),

              // Title Field - REQUIRED
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Title *', // Mark as required
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Amount Field - REQUIRED
              TextFormField(
                controller: _amountController,
                decoration: const InputDecoration(
                  labelText: 'Amount *', // Mark as required
                  prefixText: '₹ ',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an amount';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Account Selection - UPDATED: Optional with "No Account" option
              accountsAsync.when(
                loading: () => const CircularProgressIndicator(),
                error: (error, stack) => Text('Error: $error'),
                data: (accounts) {
                  // Create dropdown items with "No Account" as first option
                  final dropdownItems = <DropdownMenuItem<String?>>[
                    const DropdownMenuItem<String?>(
                      value: null,
                      child: Text('No Account (General)'),
                    ),
                    ...accounts
                        .map(
                          (account) => DropdownMenuItem<String?>(
                            value: account.id,
                            child: Text(account.name),
                          ),
                        )
                        .toList(),
                  ];

                  return DropdownButtonFormField<String?>(
                    value: _selectedAccount,
                    decoration: const InputDecoration(
                      labelText: 'Account (Optional)',
                      border: OutlineInputBorder(),
                      helperText:
                          'Leave as "No Account" if you don\'t want to track by wallet',
                    ),
                    items: dropdownItems,
                    onChanged: (value) =>
                        setState(() => _selectedAccount = value),
                  );
                },
              ),
              const SizedBox(height: 16),

              // Category Field - Optional
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Category (Optional)',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) =>
                    _selectedCategory = value.isEmpty ? null : value,
              ),
              const SizedBox(height: 16),

              // Date Selection
              InkWell(
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: _selectedDate,
                    firstDate: DateTime(2020),
                    lastDate: DateTime.now(),
                  );
                  if (date != null) {
                    setState(() => _selectedDate = date);
                  }
                },
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Date',
                    border: OutlineInputBorder(),
                  ),
                  child: Text(_formatDate(_selectedDate)),
                ),
              ),
              const SizedBox(height: 16),

              // Note Field - Optional
              TextFormField(
                controller: _noteController,
                decoration: const InputDecoration(
                  labelText: 'Note (Optional)',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 24),

              // Submit Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submitTransaction,
                  child: const Text('Add Transaction'),
                ),
              ),

              const SizedBox(height: 16),

              // Helper text
              Text(
                '* Required fields\n'
                'You can add transactions without selecting an account - '
                'they\'ll be tracked under "No Account"',
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getTypeLabel(TransactionType type) {
    switch (type) {
      case TransactionType.income:
        return 'Income';
      case TransactionType.expense:
        return 'Expense';
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  void _submitTransaction() async {
    if (!_formKey.currentState!.validate()) return;

    // UPDATED: Create transaction with optional account (can be null)
    final transaction = TransactionModel(
      id: const Uuid().v4(),
      type: _selectedType,
      date: _selectedDate,
      title: _titleController.text,
      amount: double.parse(_amountController.text),
      account: _selectedAccount, // Can be null - that's perfectly fine!
      category: _selectedCategory?.isEmpty == true ? null : _selectedCategory,
      note: _noteController.text.isEmpty ? null : _noteController.text,
    );

    try {
      await ref.read(transactionsProvider.notifier).addTransaction(transaction);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              _selectedAccount == null
                  ? 'Transaction added without account!'
                  : 'Transaction added successfully!',
            ),
          ),
        );
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error adding transaction: $e')));
      }
    }
  }
}
