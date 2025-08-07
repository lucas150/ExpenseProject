// // lib/features/transactions/pages/edit_transaction_page.dart
// import 'package:expense_project/core/currency_provider.dart';
// import 'package:expense_project/features/accounts/accounts_provider.dart';
// import 'package:expense_project/features/categories/categories_provider.dart';
// import 'package:expense_project/features/transactions/transactions_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../../../core/models/transaction_model.dart';

// class EditTransactionPage extends ConsumerStatefulWidget {
//   final TransactionModel transaction;

//   const EditTransactionPage({super.key, required this.transaction});

//   @override
//   ConsumerState<EditTransactionPage> createState() => _EditTransactionPageState();
// }

// class _EditTransactionPageState extends ConsumerState<EditTransactionPage> {
//   late final TextEditingController _titleController;
//   late final TextEditingController _amountController;
//   late final TextEditingController _noteController;
//   late TransactionType _selectedType;
//   String? _selectedCategory;
//   String? _selectedAccount;
//   late DateTime _selectedDate;

//   @override
//   void initState() {
//     super.initState();
//     _titleController = TextEditingController(text: widget.transaction.title);
//     _amountController = TextEditingController(text: widget.transaction.amount.toString());
//     _noteController = TextEditingController(text: widget.transaction.note ?? '');
//     _selectedType = widget.transaction.type;
//     _selectedCategory = widget.transaction.category;
//     _selectedAccount = widget.transaction.account;
//     _selectedDate = widget.transaction.date;
//   }

//   @override
//   void dispose() {
//     _titleController.dispose();
//     _amountController.dispose();
//     _noteController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final currency = ref.watch(currencyProvider);

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Edit Transaction'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.delete),
//             onPressed: _showDeleteConfirmation,
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Form(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Transaction Type
//               Card(
//                 child: Padding(
//                   padding: const EdgeInsets.all(16),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Transaction Type',
//                         style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
//                       ),
//                       const SizedBox(height: 12),
//                       Row(
//                         children: TransactionType.values.map((type) {
//                           return Expanded(
//                             child: Padding(
//                               padding: const EdgeInsets.only(right: 8),
//                               child: ChoiceChip(
//                                 label: Text(_getTypeLabel(type)),
//                                 selected: _selectedType == type,
//                                 onSelected: (selected) {
//                                   if (selected) {
//                                     setState(() {
//                                       _selectedType = type;
//                                       _selectedCategory = null; // Reset category when type changes
//                                     });
//                                   }
//                                 },
//                               ),
//                             ),
//                           );
//                         }).toList(),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),

//               const SizedBox(height: 16),

//               // Title and Amount
//               Card(
//                 child: Padding(
//                   padding: const EdgeInsets.all(16),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Transaction Details',
//                         style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
//                       ),
//                       const SizedBox(height: 12),
//                       TextFormField(
//                         controller: _titleController,
//                         decoration: const InputDecoration(
//                           labelText: 'Title *',
//                           border: OutlineInputBorder(),
//                         ),
//                         validator: (value) => value?.isEmpty == true ? 'Title is required' : null,
//                       ),
//                       const SizedBox(height: 16),
//                       TextFormField(
//                         controller: _amountController,
//                         keyboardType: TextInputType.number,
//                         decoration: InputDecoration(
//                           labelText: 'Amount *',
//                           prefixText: '${currency.symbol} ',
//                           border: const OutlineInputBorder(),
//                         ),
//                         validator: (value) {
//                           if (value?.isEmpty == true) return 'Amount is required';
//                           if (double.tryParse(value!) == null) return 'Enter a valid amount';
//                           return null;
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//               ),

//               const SizedBox(height: 16),

//               // Category Selection
//               _buildCategorySelector(),

//               const SizedBox(height: 16),

//               // Account Selection
//               _buildAccountSelector(),

//               const SizedBox(height: 16),

//               // Date Selection
//               Card(
//                 child: Padding(
//                   padding: const EdgeInsets.all(16),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Date',
//                         style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
//                       ),
//                       const SizedBox(height: 12),
//                       InkWell(
//                         onTap: _selectDate,
//                         child: InputDecorator(
//                           decoration: const InputDecoration(
//                             border: OutlineInputBorder(),
//                           ),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(_formatDate(_selectedDate)),
//                               const Icon(Icons.calendar_today),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),

//               const SizedBox(height: 16),

//               // Note
//               Card(
//                 child: Padding(
//                   padding: const EdgeInsets.all(16),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Note (Optional)',
//                         style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
//                       ),
//                       const SizedBox(height: 12),
//                       TextFormField(
//                         controller: _noteController,
//                         maxLines: 3,
//                         decoration: const InputDecoration(
//                           border: OutlineInputBorder(),
//                           hintText: 'Add a note...',
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),

//               const SizedBox(height: 24),

//               // Save Button
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: _saveTransaction,
//                   style: ElevatedButton.styleFrom(
//                     padding: const EdgeInsets.symmetric(vertical: 16),
//                   ),
//                   child: const Text('Save Changes', style: TextStyle(fontSize: 16)),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildCategorySelector() {
//     final categories = _selectedType == TransactionType.expense
//         ? ref.watch(expenseCategoriesProvider)
//         : ref.watch(incomeCategoriesProvider);

//     return Card(
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'Category',
//                   style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
//                 ),
//                 TextButton(
//                   onPressed: () => Navigator.of(context).pushNamed('/categories'),
//                   child: const Text('Manage'),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 12),
//             categories.when(
//               data: (categoryList) => DropdownButtonFormField<String>(
//                 value: _selectedCategory,
//                 decoration: const InputDecoration(
//                   border: OutlineInputBorder(),
//                   hintText: 'Select a category',
//                 ),
//                 items: [
//                   const DropdownMenuItem<String>(
//                     value: null,
//                     child: Text('No Category'),
//                   ),
//                   ...categoryList.map((category) => DropdownMenuItem(
//                     value: category.name,
//                     child: Text(category.name),
//                   )),
//                 ],
//                 onChanged: (value) => setState(() => _selectedCategory = value),
//               ),
//               loading: () => const CircularProgressIndicator(),
//               error: (_, __) => const Text('Error loading categories'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildAccountSelector() {
//     final accountsAsync = ref.watch(accountsProvider);

//     return Card(
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Account (Optional)',
//               style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 12),
//             accountsAsync.when(
//               data: (accounts) => DropdownButtonFormField<String>(
//                 value: _selectedAccount,
//                 decoration: const InputDecoration(
//                   border: OutlineInputBorder(),
//                   hintText: 'Select an account',
//                 ),
//                 items: [
//                   const DropdownMenuItem<String>(
//                     value: null,
//                     child: Text('No Account (General)'),
//                   ),
//                   ...accounts.map((account) => DropdownMenuItem(
//                     value: account.id,
//                     child: Text(account.name),
//                   )),
//                 ],
//                 onChanged: (value) => setState(() => _selectedAccount = value),
//               ),
//               loading: () => const CircularProgressIndicator(),
//               error: (_, __) => const Text('Error loading accounts'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Future<void> _selectDate() async {
//     final date = await showDatePicker(
//       context: context,
//       initialDate: _selectedDate,
//       firstDate: DateTime(2020),
//       lastDate: DateTime.now(),
//     );
//     if (date != null) {
//       setState(() => _selectedDate = date);
//     }
//   }

//   String _getTypeLabel(TransactionType type) {
//     switch (type) {
//       case TransactionType.income:
//         return 'Income';
//       case TransactionType.expense:
//         return 'Expense';
//     }
//   }

//   String _formatDate(DateTime date) {
//     return '${date.day}/${date.month}/${date.year}';
//   }

//   void _saveTransaction() async {
//     final updatedTransaction = widget.transaction.copyWith(
//       type: _selectedType,
//       title: _titleController.text,
//       amount: double.tryParse(_amountController.text) ?? 0,
//       category: _selectedCategory,
//       account: _selectedAccount,
//       date: _selectedDate,
//       note: _noteController.text.isEmpty ? null : _noteController.text,
//     );

//     try {
//       await ref.read(transactionsProvider.notifier).updateTransaction(updatedTransaction);

//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Transaction updated successfully!')),
//         );
//         Navigator.of(context).pop();
//       }
//     } catch (e) {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Error updating transaction: $e')),
//         );
//       }
//     }
//   }

//   void _showDeleteConfirmation() {
//     showModalBottomSheet(
//       context: context,
//       builder: (context) => Container(
//         padding: const EdgeInsets.all(24),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             const Icon(Icons.warning, color: Colors.orange, size: 48),
//             const SizedBox(height: 16),
//             const Text(
//               'Delete Transaction',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 8),
//             const Text(
//               'Are you sure you want to delete this transaction? This action cannot be undone.',
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 24),
//             Row(
//               children: [
//                 Expanded(
//                   child: OutlinedButton(
//                     onPressed: () => Navigator.of(context).pop(),
//                     child: const Text('Cancel'),
//                   ),
//                 ),
//                 const SizedBox(width: 16),
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: _deleteTransaction,
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.red,
//                       foregroundColor: Colors.white,
//                     ),
//                     child: const Text('Delete'),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _deleteTransaction() async {
//     try {
//       await ref.read(transactionsProvider.notifier).deleteTransaction(widget.transaction.id);

//       if (mounted) {
//         Navigator.of(context).pop(); // Close bottom sheet
//         Navigator.of(context).pop(); // Close edit page
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Transaction deleted successfully!')),
//         );
//       }
//     } catch (e) {
//       if (mounted) {
//         Navigator.of(context).pop(); // Close bottom sheet
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Error deleting transaction: $e')),
//         );
//       }
//     }
//   }
// }

// lib/features/transactions/pages/edit_transaction_page.dart
import 'package:expense_project/core/currency_provider.dart';
import 'package:expense_project/core/models/category_model.dart';
import 'package:expense_project/features/accounts/accounts_provider.dart';
import 'package:expense_project/features/categories/categories_provider.dart';
import 'package:expense_project/features/transactions/transactions_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/transaction_model.dart';

class EditTransactionPage extends ConsumerStatefulWidget {
  final TransactionModel transaction;

  const EditTransactionPage({super.key, required this.transaction});

  @override
  ConsumerState<EditTransactionPage> createState() =>
      _EditTransactionPageState();
}

class _EditTransactionPageState extends ConsumerState<EditTransactionPage> {
  late final TextEditingController _titleController;
  late final TextEditingController _amountController;
  late final TextEditingController _noteController;
  late TransactionType _selectedType;
  String? _selectedCategory;
  String? _selectedAccount;
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.transaction.title);
    _amountController = TextEditingController(
      text: widget.transaction.amount.toString(),
    );
    _noteController = TextEditingController(
      text: widget.transaction.note ?? '',
    );
    _selectedType = widget.transaction.type;
    _selectedCategory = widget.transaction.category;
    _selectedAccount = widget.transaction.account;
    _selectedDate = widget.transaction.date;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final currency = ref.watch(currencyProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Transaction'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: _showDeleteConfirmation,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Transaction Type
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Transaction Type',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: TransactionType.values.map((type) {
                          return Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: ChoiceChip(
                                label: Text(_getTypeLabel(type)),
                                selected: _selectedType == type,
                                onSelected: (selected) {
                                  if (selected) {
                                    setState(() {
                                      _selectedType = type;
                                      _selectedCategory =
                                          null; // Reset category when type changes
                                    });
                                  }
                                },
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Title and Amount
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Transaction Details',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _titleController,
                        decoration: const InputDecoration(
                          labelText: 'Title *',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) =>
                            value?.isEmpty == true ? 'Title is required' : null,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _amountController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Amount *',
                          prefixText: '${currency.symbol} ',
                          border: const OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value?.isEmpty == true) {
                            return 'Amount is required';
                          }
                          if (double.tryParse(value!) == null) {
                            return 'Enter a valid amount';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Category Selection
              _buildCategorySelector(),

              const SizedBox(height: 16),

              // Account Selection
              _buildAccountSelector(),

              const SizedBox(height: 16),

              // Date Selection
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Date',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      InkWell(
                        onTap: _selectDate,
                        child: InputDecorator(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(_formatDate(_selectedDate)),
                              const Icon(Icons.calendar_today),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Note
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Note (Optional)',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _noteController,
                        maxLines: 3,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Add a note...',
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Save Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveTransaction,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    'Save Changes',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategorySelector() {
    final categories = _selectedType == TransactionType.expense
        ? ref.watch(expenseCategoriesProvider)
        : ref.watch(incomeCategoriesProvider);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Category',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () =>
                      Navigator.of(context).pushNamed('/categories'),
                  child: const Text('Manage'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            categories.when(
              data: (categoryList) => DropdownButtonFormField<String>(
                value: _selectedCategory,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Select a category',
                ),
                items: [
                  const DropdownMenuItem<String>(
                    value: null,
                    child: Text('No Category'),
                  ),
                  ...categoryList.map(
                    (category) => DropdownMenuItem(
                      // value: category.name,
                      // child: Text(category.name),
                      value: (category as ExpenseCategory).name,
                      child: Text((category).name),
                    ),
                  ),
                ],
                onChanged: (value) => setState(() => _selectedCategory = value),
              ),
              loading: () => const CircularProgressIndicator(),
              error: (_, __) => const Text('Error loading categories'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAccountSelector() {
    final accountsAsync = ref.watch(accountsProvider);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Account (Optional)',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            accountsAsync.when(
              data: (accounts) => DropdownButtonFormField<String>(
                value: _selectedAccount,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Select an account',
                ),
                items: [
                  const DropdownMenuItem<String>(
                    value: null,
                    child: Text('No Account (General)'),
                  ),
                  ...accounts.map(
                    (account) => DropdownMenuItem(
                      value: account.id,
                      child: Text(account.name),
                    ),
                  ),
                ],
                onChanged: (value) => setState(() => _selectedAccount = value),
              ),
              loading: () => const CircularProgressIndicator(),
              error: (_, __) => const Text('Error loading accounts'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (date != null) {
      setState(() => _selectedDate = date);
    }
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

  void _saveTransaction() async {
    final updatedTransaction = widget.transaction.copyWith(
      type: _selectedType,
      title: _titleController.text,
      amount: double.tryParse(_amountController.text) ?? 0,
      category: _selectedCategory,
      account: _selectedAccount,
      date: _selectedDate,
      note: _noteController.text.isEmpty ? null : _noteController.text,
    );

    try {
      await ref
          .read(transactionsProvider.notifier)
          .updateTransaction(updatedTransaction);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Transaction updated successfully!')),
        );
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error updating transaction: $e')),
        );
      }
    }
  }

  void _showDeleteConfirmation() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.warning, color: Colors.orange, size: 48),
            const SizedBox(height: 16),
            const Text(
              'Delete Transaction',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Are you sure you want to delete this transaction? This action cannot be undone.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _deleteTransaction,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Delete'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _deleteTransaction() async {
    try {
      await ref
          .read(transactionsProvider.notifier)
          .deleteTransaction(widget.transaction.id);

      if (mounted) {
        Navigator.of(context).pop(); // Close bottom sheet
        Navigator.of(context).pop(); // Close edit page
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Transaction deleted successfully!')),
        );
      }
    } catch (e) {
      if (mounted) {
        Navigator.of(context).pop(); // Close bottom sheet
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error deleting transaction: $e')),
        );
      }
    }
  }
}
