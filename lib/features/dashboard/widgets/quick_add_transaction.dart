// lib/features/dashboard/widgets/quick_add_transaction.dart
import 'package:expense_project/core/currency_provider.dart';
import 'package:expense_project/core/models/category_model.dart';
import 'package:expense_project/features/categories/categories_provider.dart';
import 'package:expense_project/features/transactions/transactions_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../../core/models/transaction_model.dart';

class QuickAddTransaction extends ConsumerStatefulWidget {
  const QuickAddTransaction({super.key});

  @override
  ConsumerState<QuickAddTransaction> createState() =>
      _QuickAddTransactionState();
}

class _QuickAddTransactionState extends ConsumerState<QuickAddTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  TransactionType _selectedType = TransactionType.expense;
  String? _selectedCategory;
  bool _isExpanded = false;

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final currency = ref.watch(currencyProvider);

    return Card(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.add_circle_outline,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  'Quick Add Transaction',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: Icon(
                    _isExpanded ? Icons.expand_less : Icons.expand_more,
                  ),
                  onPressed: () => setState(() => _isExpanded = !_isExpanded),
                ),
              ],
            ),

            if (_isExpanded) ...[
              const SizedBox(height: 16),

              // Type Selection
              Row(
                children: [
                  Expanded(
                    child: ChoiceChip(
                      label: const Text('Income'),
                      selected: _selectedType == TransactionType.income,
                      onSelected: (_) => setState(
                        () => _selectedType = TransactionType.income,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ChoiceChip(
                      label: const Text('Expense'),
                      selected: _selectedType == TransactionType.expense,
                      onSelected: (_) => setState(
                        () => _selectedType = TransactionType.expense,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Title and Amount Row
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: TextField(
                      controller: _titleController,
                      decoration: const InputDecoration(
                        labelText: 'Title',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Amount',
                        prefixText: '${currency.symbol} ',
                        border: const OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Category Selection
              _buildCategorySelector(),

              const SizedBox(height: 16),

              // Add Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _addTransaction,
                  child: const Text('Add Transaction'),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildCategorySelector() {
    final categories = _selectedType == TransactionType.expense
        ? ref.watch(expenseCategoriesProvider)
        : ref.watch(incomeCategoriesProvider);

    return categories.when(
      data: (categoryList) => DropdownButtonFormField<String>(
        value: _selectedCategory,
        decoration: const InputDecoration(
          labelText: 'Category',
          border: OutlineInputBorder(),
        ),
        items: categoryList
            .map(
              (category) => DropdownMenuItem(
                // value: category.name,
               value: (category as ExpenseCategory).name,
                child: Text((category).name),
                // child: Text(category.name),
              ),
            )
            .toList(),
        onChanged: (value) => setState(() => _selectedCategory = value),
      ),
      loading: () => const CircularProgressIndicator(),
      error: (_, __) => const Text('Error loading categories'),
    );
  }

  void _addTransaction() async {
    if (_titleController.text.isEmpty || _amountController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all required fields')),
      );
      return;
    }

    final transaction = TransactionModel(
      id: const Uuid().v4(),
      type: _selectedType,
      date: DateTime.now(),
      title: _titleController.text,
      amount: double.tryParse(_amountController.text) ?? 0,
      category: _selectedCategory,
      account: null,
      note: null,
    );

    try {
      await ref.read(transactionsProvider.notifier).addTransaction(transaction);

      // Clear form
      _titleController.clear();
      _amountController.clear();
      setState(() {
        _selectedCategory = null;
        _isExpanded = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Transaction added successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error adding transaction: $e')));
    }
  }
}
