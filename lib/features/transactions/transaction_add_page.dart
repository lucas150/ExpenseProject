// // // // // // import 'package:expense_project/features/accounts/accounts_provider.dart';
// // // // // // import 'package:expense_project/features/transactions/transactions_provider.dart';
// // // // // // import 'package:flutter/material.dart';
// // // // // // import 'package:flutter_riverpod/flutter_riverpod.dart';
// // // // // // import 'package:uuid/uuid.dart';
// // // // // // import '../../../core/models/transaction_model.dart';

// // // // // // class AddTransactionPage extends ConsumerStatefulWidget {
// // // // // //   const AddTransactionPage({super.key});

// // // // // //   @override
// // // // // //   ConsumerState<AddTransactionPage> createState() => _AddTransactionPageState();
// // // // // // }

// // // // // // class _AddTransactionPageState extends ConsumerState<AddTransactionPage> {
// // // // // //   final _formKey = GlobalKey<FormState>();
// // // // // //   final _titleController = TextEditingController();
// // // // // //   final _amountController = TextEditingController();
// // // // // //   final _noteController = TextEditingController();

// // // // // //   TransactionType _selectedType = TransactionType.expense;
// // // // // //   String? _selectedAccount; // Starts as null - no account selected
// // // // // //   String? _selectedCategory;
// // // // // //   DateTime _selectedDate = DateTime.now();

// // // // // //   @override
// // // // // //   void dispose() {
// // // // // //     _titleController.dispose();
// // // // // //     _amountController.dispose();
// // // // // //     _noteController.dispose();
// // // // // //     super.dispose();
// // // // // //   }

// // // // // //   @override
// // // // // //   Widget build(BuildContext context) {
// // // // // //     final accountsAsync = ref.watch(accountsProvider);

// // // // // //     return Scaffold(
// // // // // //       appBar: AppBar(
// // // // // //         title: const Text('Add Transaction'),
// // // // // //         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
// // // // // //       ),
// // // // // //       body: Form(
// // // // // //         key: _formKey,
// // // // // //         child: SingleChildScrollView(
// // // // // //           padding: const EdgeInsets.all(16),
// // // // // //           child: Column(
// // // // // //             crossAxisAlignment: CrossAxisAlignment.start,
// // // // // //             children: [
// // // // // //               // Transaction Type Selection - UPDATED: Only Income/Expense
// // // // // //               Text(
// // // // // //                 'Transaction Type',
// // // // // //                 style: Theme.of(context).textTheme.titleMedium,
// // // // // //               ),
// // // // // //               const SizedBox(height: 8),
// // // // // //               Row(
// // // // // //                 children: TransactionType.values.map((type) {
// // // // // //                   return Expanded(
// // // // // //                     child: Padding(
// // // // // //                       padding: const EdgeInsets.symmetric(horizontal: 4),
// // // // // //                       child: ChoiceChip(
// // // // // //                         label: Text(_getTypeLabel(type)),
// // // // // //                         selected: _selectedType == type,
// // // // // //                         onSelected: (selected) {
// // // // // //                           if (selected) setState(() => _selectedType = type);
// // // // // //                         },
// // // // // //                       ),
// // // // // //                     ),
// // // // // //                   );
// // // // // //                 }).toList(),
// // // // // //               ),
// // // // // //               const SizedBox(height: 16),

// // // // // //               // Title Field - REQUIRED
// // // // // //               TextFormField(
// // // // // //                 controller: _titleController,
// // // // // //                 decoration: const InputDecoration(
// // // // // //                   labelText: 'Title *', // Mark as required
// // // // // //                   border: OutlineInputBorder(),
// // // // // //                 ),
// // // // // //                 validator: (value) {
// // // // // //                   if (value == null || value.isEmpty) {
// // // // // //                     return 'Please enter a title';
// // // // // //                   }
// // // // // //                   return null;
// // // // // //                 },
// // // // // //               ),
// // // // // //               const SizedBox(height: 16),

// // // // // //               // Amount Field - REQUIRED
// // // // // //               TextFormField(
// // // // // //                 controller: _amountController,
// // // // // //                 decoration: const InputDecoration(
// // // // // //                   labelText: 'Amount *', // Mark as required
// // // // // //                   prefixText: '₹ ',
// // // // // //                   border: OutlineInputBorder(),
// // // // // //                 ),
// // // // // //                 keyboardType: TextInputType.number,
// // // // // //                 validator: (value) {
// // // // // //                   if (value == null || value.isEmpty) {
// // // // // //                     return 'Please enter an amount';
// // // // // //                   }
// // // // // //                   if (double.tryParse(value) == null) {
// // // // // //                     return 'Please enter a valid number';
// // // // // //                   }
// // // // // //                   return null;
// // // // // //                 },
// // // // // //               ),
// // // // // //               const SizedBox(height: 16),

// // // // // //               // Account Selection - UPDATED: Optional with "No Account" option
// // // // // //               accountsAsync.when(
// // // // // //                 loading: () => const CircularProgressIndicator(),
// // // // // //                 error: (error, stack) => Text('Error: $error'),
// // // // // //                 data: (accounts) {
// // // // // //                   // Create dropdown items with "No Account" as first option
// // // // // //                   final dropdownItems = <DropdownMenuItem<String?>>[
// // // // // //                     const DropdownMenuItem<String?>(
// // // // // //                       value: null,
// // // // // //                       child: Text('No Account (General)'),
// // // // // //                     ),
// // // // // //                     ...accounts
// // // // // //                         .map(
// // // // // //                           (account) => DropdownMenuItem<String?>(
// // // // // //                             value: account.id,
// // // // // //                             child: Text(account.name),
// // // // // //                           ),
// // // // // //                         )
// // // // // //                         .toList(),
// // // // // //                   ];

// // // // // //                   return DropdownButtonFormField<String?>(
// // // // // //                     value: _selectedAccount,
// // // // // //                     decoration: const InputDecoration(
// // // // // //                       labelText: 'Account (Optional)',
// // // // // //                       border: OutlineInputBorder(),
// // // // // //                       helperText:
// // // // // //                           'Leave as "No Account" if you don\'t want to track by wallet',
// // // // // //                     ),
// // // // // //                     items: dropdownItems,
// // // // // //                     onChanged: (value) =>
// // // // // //                         setState(() => _selectedAccount = value),
// // // // // //                   );
// // // // // //                 },
// // // // // //               ),
// // // // // //               const SizedBox(height: 16),

// // // // // //               // Category Field - Optional
// // // // // //               TextFormField(
// // // // // //                 decoration: const InputDecoration(
// // // // // //                   labelText: 'Category (Optional)',
// // // // // //                   border: OutlineInputBorder(),
// // // // // //                 ),
// // // // // //                 onChanged: (value) =>
// // // // // //                     _selectedCategory = value.isEmpty ? null : value,
// // // // // //               ),
// // // // // //               const SizedBox(height: 16),

// // // // // //               // Date Selection
// // // // // //               InkWell(
// // // // // //                 onTap: () async {
// // // // // //                   final date = await showDatePicker(
// // // // // //                     context: context,
// // // // // //                     initialDate: _selectedDate,
// // // // // //                     firstDate: DateTime(2020),
// // // // // //                     lastDate: DateTime.now(),
// // // // // //                   );
// // // // // //                   if (date != null) {
// // // // // //                     setState(() => _selectedDate = date);
// // // // // //                   }
// // // // // //                 },
// // // // // //                 child: InputDecorator(
// // // // // //                   decoration: const InputDecoration(
// // // // // //                     labelText: 'Date',
// // // // // //                     border: OutlineInputBorder(),
// // // // // //                   ),
// // // // // //                   child: Text(_formatDate(_selectedDate)),
// // // // // //                 ),
// // // // // //               ),
// // // // // //               const SizedBox(height: 16),

// // // // // //               // Note Field - Optional
// // // // // //               TextFormField(
// // // // // //                 controller: _noteController,
// // // // // //                 decoration: const InputDecoration(
// // // // // //                   labelText: 'Note (Optional)',
// // // // // //                   border: OutlineInputBorder(),
// // // // // //                 ),
// // // // // //                 maxLines: 3,
// // // // // //               ),
// // // // // //               const SizedBox(height: 24),

// // // // // //               // Submit Button
// // // // // //               SizedBox(
// // // // // //                 width: double.infinity,
// // // // // //                 child: ElevatedButton(
// // // // // //                   onPressed: _submitTransaction,
// // // // // //                   child: const Text('Add Transaction'),
// // // // // //                 ),
// // // // // //               ),

// // // // // //               const SizedBox(height: 16),

// // // // // //               // Helper text
// // // // // //               Text(
// // // // // //                 '* Required fields\n'
// // // // // //                 'You can add transactions without selecting an account - '
// // // // // //                 'they\'ll be tracked under "No Account"',
// // // // // //                 style: Theme.of(
// // // // // //                   context,
// // // // // //                 ).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
// // // // // //               ),
// // // // // //             ],
// // // // // //           ),
// // // // // //         ),
// // // // // //       ),
// // // // // //     );
// // // // // //   }

// // // // // //   String _getTypeLabel(TransactionType type) {
// // // // // //     switch (type) {
// // // // // //       case TransactionType.income:
// // // // // //         return 'Income';
// // // // // //       case TransactionType.expense:
// // // // // //         return 'Expense';
// // // // // //     }
// // // // // //   }

// // // // // //   String _formatDate(DateTime date) {
// // // // // //     return '${date.day}/${date.month}/${date.year}';
// // // // // //   }

// // // // // //   void _submitTransaction() async {
// // // // // //     if (!_formKey.currentState!.validate()) return;

// // // // // //     // UPDATED: Create transaction with optional account (can be null)
// // // // // //     final transaction = TransactionModel(
// // // // // //       id: const Uuid().v4(),
// // // // // //       type: _selectedType,
// // // // // //       date: _selectedDate,
// // // // // //       title: _titleController.text,
// // // // // //       amount: double.parse(_amountController.text),
// // // // // //       account: _selectedAccount, // Can be null - that's perfectly fine!
// // // // // //       category: _selectedCategory?.isEmpty == true ? null : _selectedCategory,
// // // // // //       note: _noteController.text.isEmpty ? null : _noteController.text,
// // // // // //     );

// // // // // //     try {
// // // // // //       await ref.read(transactionsProvider.notifier).addTransaction(transaction);
// // // // // //       if (mounted) {
// // // // // //         ScaffoldMessenger.of(context).showSnackBar(
// // // // // //           SnackBar(
// // // // // //             content: Text(
// // // // // //               _selectedAccount == null
// // // // // //                   ? 'Transaction added without account!'
// // // // // //                   : 'Transaction added successfully!',
// // // // // //             ),
// // // // // //           ),
// // // // // //         );
// // // // // //         Navigator.of(context).pop();
// // // // // //       }
// // // // // //     } catch (e) {
// // // // // //       if (mounted) {
// // // // // //         ScaffoldMessenger.of(
// // // // // //           context,
// // // // // //         ).showSnackBar(SnackBar(content: Text('Error adding transaction: $e')));
// // // // // //       }
// // // // // //     }
// // // // // //   }
// // // // // // }

// // // // // import 'package:expense_project/core/models/category_model.dart';
// // // // // import 'package:expense_project/features/accounts/accounts_provider.dart';
// // // // // import 'package:expense_project/features/transactions/transactions_provider.dart';
// // // // // import 'package:expense_project/features/categories/categories_provider.dart';
// // // // // import 'package:flutter/material.dart';
// // // // // import 'package:flutter_riverpod/flutter_riverpod.dart';
// // // // // import 'package:uuid/uuid.dart';
// // // // // import '../../../core/models/transaction_model.dart';

// // // // // class AddTransactionPage extends ConsumerStatefulWidget {
// // // // //   const AddTransactionPage({super.key});

// // // // //   @override
// // // // //   ConsumerState<AddTransactionPage> createState() => _AddTransactionPageState();
// // // // // }

// // // // // class _AddTransactionPageState extends ConsumerState<AddTransactionPage> {
// // // // //   final _formKey = GlobalKey<FormState>();
// // // // //   final _titleController = TextEditingController();
// // // // //   final _amountController = TextEditingController();
// // // // //   final _noteController = TextEditingController();

// // // // //   TransactionType _selectedType = TransactionType.expense;
// // // // //   String? _selectedAccount;
// // // // //   String? _selectedCategory;
// // // // //   DateTime _selectedDate = DateTime.now();

// // // // //   @override
// // // // //   void dispose() {
// // // // //     _titleController.dispose();
// // // // //     _amountController.dispose();
// // // // //     _noteController.dispose();
// // // // //     super.dispose();
// // // // //   }

// // // // //   @override
// // // // //   Widget build(BuildContext context) {
// // // // //     final accountsAsync = ref.watch(accountsProvider);

// // // // //     return Scaffold(
// // // // //       appBar: AppBar(
// // // // //         title: const Text('Add Transaction'),
// // // // //         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
// // // // //       ),
// // // // //       body: Form(
// // // // //         key: _formKey,
// // // // //         child: SingleChildScrollView(
// // // // //           padding: const EdgeInsets.all(16),
// // // // //           child: Column(
// // // // //             crossAxisAlignment: CrossAxisAlignment.start,
// // // // //             children: [
// // // // //               // Transaction Type Selection
// // // // //               Text('Transaction Type',
// // // // //                   style: Theme.of(context).textTheme.titleMedium),
// // // // //               const SizedBox(height: 8),
// // // // //               Row(
// // // // //                 children: TransactionType.values.map((type) {
// // // // //                   return Expanded(
// // // // //                     child: Padding(
// // // // //                       padding: const EdgeInsets.symmetric(horizontal: 4),
// // // // //                       child: ChoiceChip(
// // // // //                         label: Text(_getTypeLabel(type)),
// // // // //                         selected: _selectedType == type,
// // // // //                         onSelected: (selected) {
// // // // //                           if (selected) {
// // // // //                             setState(() {
// // // // //                               _selectedType = type;
// // // // //                               _selectedCategory = null; // reset when toggling
// // // // //                             });
// // // // //                           }
// // // // //                         },
// // // // //                       ),
// // // // //                     ),
// // // // //                   );
// // // // //                 }).toList(),
// // // // //               ),
// // // // //               const SizedBox(height: 16),

// // // // //               // Title Field
// // // // //               TextFormField(
// // // // //                 controller: _titleController,
// // // // //                 decoration: const InputDecoration(
// // // // //                   labelText: 'Title *',
// // // // //                   border: OutlineInputBorder(),
// // // // //                 ),
// // // // //                 validator: (value) => value == null || value.isEmpty
// // // // //                     ? 'Please enter a title'
// // // // //                     : null,
// // // // //               ),
// // // // //               const SizedBox(height: 16),

// // // // //               // Amount Field
// // // // //               TextFormField(
// // // // //                 controller: _amountController,
// // // // //                 decoration: const InputDecoration(
// // // // //                   labelText: 'Amount *',
// // // // //                   prefixText: '₹ ',
// // // // //                   border: OutlineInputBorder(),
// // // // //                 ),
// // // // //                 keyboardType: TextInputType.number,
// // // // //                 validator: (value) {
// // // // //                   if (value == null || value.isEmpty) {
// // // // //                     return 'Please enter an amount';
// // // // //                   }
// // // // //                   if (double.tryParse(value) == null) {
// // // // //                     return 'Please enter a valid number';
// // // // //                   }
// // // // //                   return null;
// // // // //                 },
// // // // //               ),
// // // // //               const SizedBox(height: 16),

// // // // //               // Account Selection
// // // // //               accountsAsync.when(
// // // // //                 loading: () => const CircularProgressIndicator(),
// // // // //                 error: (error, stack) => Text('Error: $error'),
// // // // //                 data: (accounts) {
// // // // //                   final dropdownItems = <DropdownMenuItem<String?>>[
// // // // //                     const DropdownMenuItem<String?>(
// // // // //                       value: null,
// // // // //                       child: Text('No Account (General)'),
// // // // //                     ),
// // // // //                     ...accounts.map(
// // // // //                       (account) => DropdownMenuItem<String?>(
// // // // //                         value: account.id,
// // // // //                         child: Text(account.name),
// // // // //                       ),
// // // // //                     ),
// // // // //                   ];

// // // // //                   return DropdownButtonFormField<String?>(
// // // // //                     value: _selectedAccount,
// // // // //                     decoration: const InputDecoration(
// // // // //                       labelText: 'Account (Optional)',
// // // // //                       border: OutlineInputBorder(),
// // // // //                       helperText:
// // // // //                           'Leave as "No Account" if you don\'t want to track by wallet',
// // // // //                     ),
// // // // //                     items: dropdownItems,
// // // // //                     onChanged: (value) {
// // // // //                       setState(() => _selectedAccount = value);
// // // // //                     },
// // // // //                   );
// // // // //                 },
// // // // //               ),
// // // // //               const SizedBox(height: 16),

// // // // //               // Category Selection - DROPDOWN
// // // // //               _buildCategoryDropdown(),

// // // // //               const SizedBox(height: 16),

// // // // //               // Date Selection
// // // // //               InkWell(
// // // // //                 onTap: () async {
// // // // //                   final date = await showDatePicker(
// // // // //                     context: context,
// // // // //                     initialDate: _selectedDate,
// // // // //                     firstDate: DateTime(2020),
// // // // //                     lastDate: DateTime.now(),
// // // // //                   );
// // // // //                   if (date != null) setState(() => _selectedDate = date);
// // // // //                 },
// // // // //                 child: InputDecorator(
// // // // //                   decoration: const InputDecoration(
// // // // //                     labelText: 'Date',
// // // // //                     border: OutlineInputBorder(),
// // // // //                   ),
// // // // //                   child: Text(_formatDate(_selectedDate)),
// // // // //                 ),
// // // // //               ),
// // // // //               const SizedBox(height: 16),

// // // // //               // Note
// // // // //               TextFormField(
// // // // //                 controller: _noteController,
// // // // //                 decoration: const InputDecoration(
// // // // //                   labelText: 'Note (Optional)',
// // // // //                   border: OutlineInputBorder(),
// // // // //                 ),
// // // // //                 maxLines: 3,
// // // // //               ),
// // // // //               const SizedBox(height: 24),

// // // // //               // Submit Button
// // // // //               SizedBox(
// // // // //                 width: double.infinity,
// // // // //                 child: ElevatedButton(
// // // // //                   onPressed: _submitTransaction,
// // // // //                   child: const Text('Add Transaction'),
// // // // //                 ),
// // // // //               ),
// // // // //               const SizedBox(height: 16),

// // // // //               // Helper text
// // // // //               Text(
// // // // //                 '* Required fields\n'
// // // // //                 'You can add transactions without selecting an account - '
// // // // //                 'they\'ll be tracked under "No Account"',
// // // // //                 style: Theme.of(context)
// // // // //                     .textTheme
// // // // //                     .bodySmall
// // // // //                     ?.copyWith(color: Colors.grey[600]),
// // // // //               ),
// // // // //             ],
// // // // //           ),
// // // // //         ),
// // // // //       ),
// // // // //     );
// // // // //   }

// // // // //   /// Category dropdown builder
// // // // //   Widget _buildCategoryDropdown() {
// // // // //     final categoriesAsync = _selectedType == TransactionType.expense
// // // // //         ? ref.watch(expenseCategoriesProvider)
// // // // //         : ref.watch(incomeCategoriesProvider);

// // // // //     return categoriesAsync.when(
// // // // //       loading: () => const Center(child: CircularProgressIndicator()),
// // // // //       error: (error, stack) => Text('Error loading categories: $error'),
// // // // //       data: (categories) {
// // // // //         final items = <DropdownMenuItem<String?>>[
// // // // //           const DropdownMenuItem<String?>(
// // // // //             value: null,
// // // // //             child: Text('No Category'),
// // // // //           ),
// // // // //           ...categories.map(
// // // // //             (c) => DropdownMenuItem<String?>(
// // // // //               value: c is ExpenseCategory ? c.name : (c is IncomeCategory ? c.name : null),
// // // // //               child: Text(c is ExpenseCategory ? c.name : (c is IncomeCategory ? c.name : '')),
// // // // //             ),
// // // // //           ),
// // // // //         ];

// // // // //         return DropdownButtonFormField<String?>(
// // // // //           value: _selectedCategory,
// // // // //           decoration: const InputDecoration(
// // // // //             labelText: 'Category (Optional)',
// // // // //             border: OutlineInputBorder(),
// // // // //             helperText: 'Select a category or leave as "No Category"',
// // // // //           ),
// // // // //           items: items,
// // // // //           onChanged: (value) {
// // // // //             setState(() => _selectedCategory = value);
// // // // //           },
// // // // //         );
// // // // //       },
// // // // //     );
// // // // //   }

// // // // //   String _getTypeLabel(TransactionType type) {
// // // // //     switch (type) {
// // // // //       case TransactionType.income:
// // // // //         return 'Income';
// // // // //       case TransactionType.expense:
// // // // //         return 'Expense';
// // // // //     }
// // // // //   }

// // // // //   String _formatDate(DateTime date) {
// // // // //     return '${date.day}/${date.month}/${date.year}';
// // // // //   }

// // // // //   void _submitTransaction() async {
// // // // //     if (!_formKey.currentState!.validate()) return;

// // // // //     final transaction = TransactionModel(
// // // // //       id: const Uuid().v4(),
// // // // //       type: _selectedType,
// // // // //       date: _selectedDate,
// // // // //       title: _titleController.text,
// // // // //       amount: double.parse(_amountController.text),
// // // // //       account: _selectedAccount,
// // // // //       category: _selectedCategory?.isEmpty == true ? null : _selectedCategory,
// // // // //       note: _noteController.text.isEmpty ? null : _noteController.text,
// // // // //     );

// // // // //     try {
// // // // //       await ref.read(transactionsProvider.notifier).addTransaction(transaction);
// // // // //       if (mounted) {
// // // // //         ScaffoldMessenger.of(context).showSnackBar(
// // // // //           SnackBar(
// // // // //             content: Text(
// // // // //               _selectedAccount == null
// // // // //                   ? 'Transaction added without account!'
// // // // //                   : 'Transaction added successfully!',
// // // // //             ),
// // // // //           ),
// // // // //         );
// // // // //         Navigator.of(context).pop();
// // // // //       }
// // // // //     } catch (e) {
// // // // //       if (mounted) {
// // // // //         ScaffoldMessenger.of(context).showSnackBar(
// // // // //           SnackBar(content: Text('Error adding transaction: $e')),
// // // // //         );
// // // // //       }
// // // // //     }
// // // // //   }
// // // // // }

// // // // import 'package:flutter/material.dart';
// // // // import 'package:flutter_riverpod/flutter_riverpod.dart';
// // // // import 'package:uuid/uuid.dart';
// // // // import 'package:expense_project/core/models/transaction_model.dart';
// // // // import 'package:expense_project/core/models/account_model.dart';
// // // // import 'package:expense_project/core/models/category_model.dart';
// // // // import 'package:expense_project/features/accounts/accounts_provider.dart';
// // // // import 'package:expense_project/features/categories/categories_provider.dart';
// // // // import 'package:expense_project/features/transactions/transactions_provider.dart';

// // // // class AddTransactionPage extends ConsumerStatefulWidget {
// // // //   const AddTransactionPage({super.key});

// // // //   @override
// // // //   ConsumerState<AddTransactionPage> createState() => _AddTransactionPageState();
// // // // }

// // // // class _AddTransactionPageState extends ConsumerState<AddTransactionPage> {
// // // //   TransactionType _selectedType = TransactionType.expense;
// // // //   String? _selectedAccount;
// // // //   String? _selectedCategory;
// // // //   DateTime _selectedDate = DateTime.now();
// // // //   final TextEditingController _amountController = TextEditingController();
// // // //   final TextEditingController _commentController = TextEditingController();
// // // //   final _formKey = GlobalKey<FormState>();

// // // //   @override
// // // //   void dispose() {
// // // //     _amountController.dispose();
// // // //     _commentController.dispose();
// // // //     super.dispose();
// // // //   }

// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     final theme = Theme.of(context);

// // // //     final accountsAsync = ref.watch(accountsProvider);
// // // //     final categoriesAsync = _selectedType == TransactionType.expense
// // // //         ? ref.watch(expenseCategoriesProvider)
// // // //         : ref.watch(incomeCategoriesProvider);

// // // //     return Scaffold(
// // // //       backgroundColor: Colors.transparent,
// // // //       body: DraggableScrollableSheet(
// // // //         initialChildSize: 0.70,
// // // //         minChildSize: 0.38,
// // // //         maxChildSize: 0.97,
// // // //         builder: (context, scrollController) {
// // // //           return Container(
// // // //             decoration: BoxDecoration(
// // // //               color: theme.colorScheme.surface,
// // // //               borderRadius: const BorderRadius.vertical(
// // // //                 top: Radius.circular(20),
// // // //               ),
// // // //             ),
// // // //             padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
// // // //             child: Form(
// // // //               key: _formKey,
// // // //               child: ListView(
// // // //                 controller: scrollController,
// // // //                 children: [
// // // //                   Center(
// // // //                     child: Container(
// // // //                       width: 46,
// // // //                       height: 4,
// // // //                       decoration: BoxDecoration(
// // // //                         color: Colors.grey[400],
// // // //                         borderRadius: BorderRadius.circular(2),
// // // //                       ),
// // // //                     ),
// // // //                   ),
// // // //                   const SizedBox(height: 16),

// // // //                   // Account (left) and Category (right) chips
// // // //                   Row(
// // // //                     children: [
// // // //                       Expanded(
// // // //                         child: _AccountSelectorChips(
// // // //                           accountsAsync: accountsAsync,
// // // //                           selected: _selectedAccount,
// // // //                           onChanged: (a) =>
// // // //                               setState(() => _selectedAccount = a),
// // // //                         ),
// // // //                       ),
// // // //                       const SizedBox(width: 12),
// // // //                       Expanded(
// // // //                         child: _CategorySelectorChips(
// // // //                           categoriesAsync: categoriesAsync,
// // // //                           selected: _selectedCategory,
// // // //                           onChanged: (c) =>
// // // //                               setState(() => _selectedCategory = c),
// // // //                         ),
// // // //                       ),
// // // //                     ],
// // // //                   ),
// // // //                   const SizedBox(height: 16),

// // // //                   // Date & Type row
// // // //                   Row(
// // // //                     children: [
// // // //                       Expanded(
// // // //                         child: InkWell(
// // // //                           borderRadius: BorderRadius.circular(9),
// // // //                           onTap: () async {
// // // //                             final date = await showDatePicker(
// // // //                               context: context,
// // // //                               initialDate: _selectedDate,
// // // //                               firstDate: DateTime(2020),
// // // //                               lastDate: DateTime(2100),
// // // //                             );
// // // //                             if (date != null)
// // // //                               setState(() => _selectedDate = date);
// // // //                           },
// // // //                           child: Container(
// // // //                             height: 40,
// // // //                             padding: const EdgeInsets.symmetric(horizontal: 14),
// // // //                             decoration: BoxDecoration(
// // // //                               color: theme.colorScheme.background,
// // // //                               borderRadius: BorderRadius.circular(9),
// // // //                               border: Border.all(color: theme.dividerColor),
// // // //                             ),
// // // //                             alignment: Alignment.centerLeft,
// // // //                             child: Text(
// // // //                               "${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}",
// // // //                               style: const TextStyle(fontSize: 15),
// // // //                             ),
// // // //                           ),
// // // //                         ),
// // // //                       ),
// // // //                       const SizedBox(width: 12),
// // // //                       ToggleButtons(
// // // //                         borderRadius: BorderRadius.circular(12),
// // // //                         selectedColor: Colors.white,
// // // //                         fillColor: theme.colorScheme.primary,
// // // //                         constraints: const BoxConstraints(
// // // //                           minWidth: 60,
// // // //                           minHeight: 36,
// // // //                         ),
// // // //                         isSelected: [
// // // //                           _selectedType == TransactionType.expense,
// // // //                           _selectedType == TransactionType.income,
// // // //                         ],
// // // //                         onPressed: (i) {
// // // //                           setState(() {
// // // //                             _selectedType = i == 0
// // // //                                 ? TransactionType.expense
// // // //                                 : TransactionType.income;
// // // //                             _selectedCategory = null;
// // // //                           });
// // // //                         },
// // // //                         children: const [
// // // //                           Padding(
// // // //                             padding: EdgeInsets.symmetric(horizontal: 10),
// // // //                             child: Text('Expense'),
// // // //                           ),
// // // //                           Padding(
// // // //                             padding: EdgeInsets.symmetric(horizontal: 10),
// // // //                             child: Text('Income'),
// // // //                           ),
// // // //                         ],
// // // //                       ),
// // // //                     ],
// // // //                   ),
// // // //                   const SizedBox(height: 22),

// // // //                   // Amount input, bold and centered
// // // //                   Row(
// // // //                     mainAxisAlignment: MainAxisAlignment.center,
// // // //                     children: [
// // // //                       Text(
// // // //                         '₹',
// // // //                         style: TextStyle(
// // // //                           fontSize: 30,
// // // //                           fontWeight: FontWeight.bold,
// // // //                           color: theme.colorScheme.primary,
// // // //                         ),
// // // //                       ),
// // // //                       const SizedBox(width: 6),
// // // //                       Expanded(
// // // //                         child: TextFormField(
// // // //                           controller: _amountController,
// // // //                           autofocus: true,
// // // //                           textAlign: TextAlign.left,
// // // //                           keyboardType: const TextInputType.numberWithOptions(
// // // //                             decimal: true,
// // // //                           ),
// // // //                           style: const TextStyle(
// // // //                             fontSize: 32,
// // // //                             fontWeight: FontWeight.w400,
// // // //                             letterSpacing: -0.5,
// // // //                           ),
// // // //                           decoration: const InputDecoration(
// // // //                             border: InputBorder.none,
// // // //                             hintText: "0",
// // // //                           ),
// // // //                           validator: (value) {
// // // //                             if (value == null || value.trim().isEmpty)
// // // //                               return 'Enter amount';
// // // //                             final val = double.tryParse(value);
// // // //                             if (val == null || val <= 0)
// // // //                               return 'Enter valid amount';
// // // //                             return null;
// // // //                           },
// // // //                         ),
// // // //                       ),
// // // //                     ],
// // // //                   ),
// // // //                   const SizedBox(height: 12),

// // // //                   // Comment
// // // //                   TextFormField(
// // // //                     controller: _commentController,
// // // //                     decoration: const InputDecoration(
// // // //                       labelText: "Add comment (optional)",
// // // //                       border: OutlineInputBorder(),
// // // //                     ),
// // // //                     minLines: 1,
// // // //                     maxLines: 2,
// // // //                   ),
// // // //                   const SizedBox(height: 20),

// // // //                   // Save button
// // // //                   SizedBox(
// // // //                     width: double.infinity,
// // // //                     child: ElevatedButton(
// // // //                       style: ElevatedButton.styleFrom(
// // // //                         padding: const EdgeInsets.symmetric(vertical: 16),
// // // //                         shape: RoundedRectangleBorder(
// // // //                           borderRadius: BorderRadius.circular(12),
// // // //                         ),
// // // //                       ),
// // // //                       onPressed: _canSave() ? _submitTransaction : null,
// // // //                       child: const Text("Save", style: TextStyle(fontSize: 16)),
// // // //                     ),
// // // //                   ),
// // // //                 ],
// // // //               ),
// // // //             ),
// // // //           );
// // // //         },
// // // //       ),
// // // //     );
// // // //   }

// // // //   bool _canSave() {
// // // //     return _selectedAccount != null &&
// // // //         _selectedCategory != null &&
// // // //         _amountController.text.trim().isNotEmpty &&
// // // //         double.tryParse(_amountController.text) != null &&
// // // //         double.parse(_amountController.text) > 0;
// // // //   }

// // // //   void _submitTransaction() async {
// // // //     if (!_formKey.currentState!.validate()) return;
// // // //     final transaction = TransactionModel(
// // // //       id: const Uuid().v4(),
// // // //       type: _selectedType,
// // // //       date: _selectedDate,
// // // //       title: _commentController.text.trim().isEmpty
// // // //           ? 'New Transaction'
// // // //           : _commentController.text,
// // // //       amount: double.parse(_amountController.text),
// // // //       account: _selectedAccount,
// // // //       category: _selectedCategory,
// // // //       note: _commentController.text.isEmpty ? null : _commentController.text,
// // // //     );

// // // //     try {
// // // //       await ref.read(transactionsProvider.notifier).addTransaction(transaction);
// // // //       if (mounted) Navigator.of(context).maybePop();
// // // //     } catch (e) {
// // // //       if (mounted) {
// // // //         ScaffoldMessenger.of(
// // // //           context,
// // // //         ).showSnackBar(SnackBar(content: Text('Error adding transaction: $e')));
// // // //       }
// // // //     }
// // // //   }
// // // // }

// // // // class _AccountSelectorChips extends StatelessWidget {
// // // //   final AsyncValue<List<Account>> accountsAsync;
// // // //   final String? selected;
// // // //   final ValueChanged<String> onChanged;

// // // //   const _AccountSelectorChips({
// // // //     required this.accountsAsync,
// // // //     required this.selected,
// // // //     required this.onChanged,
// // // //   });

// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return accountsAsync.when(
// // // //       loading: () => const Center(child: CircularProgressIndicator()),
// // // //       error: (e, _) => Text('Accounts: $e'),
// // // //       data: (accounts) {
// // // //         if (accounts.isEmpty) return const Text('No accounts');
// // // //         return SingleChildScrollView(
// // // //           scrollDirection: Axis.horizontal,
// // // //           child: Row(
// // // //             children: accounts.map((a) {
// // // //               final isSelected = a.name == selected;
// // // //               return Padding(
// // // //                 padding: const EdgeInsets.only(right: 7),
// // // //                 child: ChoiceChip(
// // // //                   label: Text(a.name),
// // // //                   selected: isSelected,
// // // //                   onSelected: (_) => onChanged(a.name),
// // // //                   selectedColor: Theme.of(context).colorScheme.primary,
// // // //                   labelStyle: TextStyle(
// // // //                     color: isSelected
// // // //                         ? Colors.white
// // // //                         : Theme.of(context).colorScheme.onSurface,
// // // //                   ),
// // // //                 ),
// // // //               );
// // // //             }).toList(),
// // // //           ),
// // // //         );
// // // //       },
// // // //     );
// // // //   }
// // // // }

// // // // class _CategorySelectorChips extends StatelessWidget {
// // // //   final AsyncValue<List<dynamic>> categoriesAsync;
// // // //   final String? selected;
// // // //   final ValueChanged<String> onChanged;

// // // //   const _CategorySelectorChips({
// // // //     required this.categoriesAsync,
// // // //     required this.selected,
// // // //     required this.onChanged,
// // // //   });

// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return categoriesAsync.when(
// // // //       loading: () => const Center(child: CircularProgressIndicator()),
// // // //       error: (e, _) => Text('Categories: $e'),
// // // //       data: (categories) {
// // // //         if (categories.isEmpty) return const Text('No categories');
// // // //         return SingleChildScrollView(
// // // //           scrollDirection: Axis.horizontal,
// // // //           child: Row(
// // // //             children: categories.map((c) {
// // // //               String name;
// // // //               if (c is ExpenseCategory) {
// // // //                 name = c.name;
// // // //               } else if (c is IncomeCategory) {
// // // //                 name = c.name;
// // // //               } else {
// // // //                 name = c.toString();
// // // //               }
// // // //               final isSelected = name == selected;
// // // //               return Padding(
// // // //                 padding: const EdgeInsets.only(right: 7),
// // // //                 child: ChoiceChip(
// // // //                   label: Text(name),
// // // //                   selected: isSelected,
// // // //                   onSelected: (_) => onChanged(name),
// // // //                   selectedColor: Theme.of(context).colorScheme.primary,
// // // //                   labelStyle: TextStyle(
// // // //                     color: isSelected
// // // //                         ? Colors.white
// // // //                         : Theme.of(context).colorScheme.onSurface,
// // // //                   ),
// // // //                 ),
// // // //               );
// // // //             }).toList(),
// // // //           ),
// // // //         );
// // // //       },
// // // //     );
// // // //   }
// // // // }

// // // import 'package:flutter/material.dart';
// // // import 'package:flutter_riverpod/flutter_riverpod.dart';
// // // import 'package:flutter/services.dart';
// // // import 'package:uuid/uuid.dart';
// // // import 'package:expense_project/core/models/transaction_model.dart';
// // // import 'package:expense_project/core/models/account_model.dart';
// // // import 'package:expense_project/core/models/category_model.dart';
// // // import 'package:expense_project/features/accounts/accounts_provider.dart';
// // // import 'package:expense_project/features/categories/categories_provider.dart';
// // // import 'package:expense_project/features/transactions/transactions_provider.dart';

// // // class AddTransactionPage extends ConsumerStatefulWidget {
// // //   const AddTransactionPage({super.key});

// // //   @override
// // //   ConsumerState<AddTransactionPage> createState() => _AddTransactionPageState();
// // // }

// // // class _AddTransactionPageState extends ConsumerState<AddTransactionPage> {
// // //   TransactionType _selectedType = TransactionType.expense;
// // //   String? _selectedAccount;
// // //   String? _selectedCategory;
// // //   DateTime _selectedDate = DateTime.now();
// // //   String _amount = '';
// // //   final TextEditingController _commentController = TextEditingController();

// // //   @override
// // //   void dispose() {
// // //     _commentController.dispose();
// // //     super.dispose();
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     final theme = Theme.of(context);
// // //     final isDark = theme.brightness == Brightness.dark;

// // //     // Minimalist colors
// // //     final bg = isDark ? const Color(0xFF000000) : const Color(0xFFFFFFFF);
// // //     final surface = isDark ? const Color(0xFF111111) : const Color(0xFFFBFBFB);
// // //     final text1 = isDark ? const Color(0xFFFFFFFF) : const Color(0xFF000000);
// // //     final text2 = isDark ? const Color(0xFF888888) : const Color(0xFF666666);
// // //     final accent = const Color(0xFF007AFF);

// // //     final accountsAsync = ref.watch(accountsProvider);
// // //     final categoriesAsync = _selectedType == TransactionType.expense
// // //         ? ref.watch(expenseCategoriesProvider)
// // //         : ref.watch(incomeCategoriesProvider);

// // //     return Scaffold(
// // //       backgroundColor: Colors.transparent,
// // //       body: DraggableScrollableSheet(
// // //         initialChildSize: 0.95,
// // //         minChildSize: 0.4,
// // //         maxChildSize: 0.95,
// // //         builder: (context, scrollController) {
// // //           return Container(
// // //             decoration: BoxDecoration(
// // //               color: surface,
// // //               borderRadius: const BorderRadius.vertical(
// // //                 top: Radius.circular(24),
// // //               ),
// // //               boxShadow: [
// // //                 BoxShadow(
// // //                   color: Colors.black.withOpacity(isDark ? 0.3 : 0.1),
// // //                   blurRadius: 20,
// // //                   offset: const Offset(0, -5),
// // //                 ),
// // //               ],
// // //             ),
// // //             child: Column(
// // //               children: [
// // //                 // Drag handle
// // //                 Container(
// // //                   width: 40,
// // //                   height: 4,
// // //                   margin: const EdgeInsets.only(top: 12),
// // //                   decoration: BoxDecoration(
// // //                     color: text2.withOpacity(0.3),
// // //                     borderRadius: BorderRadius.circular(2),
// // //                   ),
// // //                 ),

// // //                 Expanded(
// // //                   child: Padding(
// // //                     padding: const EdgeInsets.symmetric(horizontal: 20),
// // //                     child: Column(
// // //                       children: [
// // //                         const SizedBox(height: 12),

// // //                         // Account & Category Row
// // //                         Row(
// // //                           children: [
// // //                             Expanded(
// // //                               child: _buildAccountSelector(
// // //                                 accountsAsync,
// // //                                 surface,
// // //                                 text1,
// // //                                 text2,
// // //                                 accent,
// // //                               ),
// // //                             ),
// // //                             const SizedBox(width: 16),
// // //                             Expanded(
// // //                               child: _buildCategorySelector(
// // //                                 categoriesAsync,
// // //                                 surface,
// // //                                 text1,
// // //                                 text2,
// // //                                 accent,
// // //                               ),
// // //                             ),
// // //                           ],
// // //                         ),

// // //                         const SizedBox(height: 12),

// // //                         // Date & Type Row
// // //                         Row(
// // //                           children: [
// // //                             Expanded(
// // //                               child: _buildDateSelector(surface, text1, text2),
// // //                             ),
// // //                             const SizedBox(width: 16),
// // //                             _buildTypeToggle(
// // //                               _selectedType,
// // //                               accent,
// // //                               surface,
// // //                               text1,
// // //                             ),
// // //                           ],
// // //                         ),

// // //                         // const SizedBox(height: 12),

// // //                         // Amount Display
// // //                         Container(
// // //                           width: double.infinity,
// // //                           // padding: const EdgeInsets.symmetric(vertical: 20),
// // //                           child: Column(
// // //                             children: [
// // //                               Text(
// // //                                 '₹${_formatAmount(_amount)}',
// // //                                 style: TextStyle(
// // //                                   fontSize: 48,
// // //                                   fontWeight: FontWeight.w200,
// // //                                   color:
// // //                                       _selectedType == TransactionType.expense
// // //                                       ? const Color(0xFFFF3B30)
// // //                                       : const Color(0xFF34C759),
// // //                                   letterSpacing: -1,
// // //                                 ),
// // //                               ),
// // //                               // const SizedBox(height: 12),
// // //                               _buildCommentField(text2),
// // //                             ],
// // //                           ),
// // //                         ),

// // //                         const Spacer(),

// // //                         // Custom Keypad
// // //                         _buildKeypad(surface, text1, text2, accent),

// // //                         // const SizedBox(height: 20),

// // //                         // Save Button
// // //                         SizedBox(
// // //                           width: double.infinity,
// // //                           height: 56,
// // //                           child: ElevatedButton(
// // //                             onPressed: _canSave() ? _saveTransaction : null,
// // //                             style: ElevatedButton.styleFrom(
// // //                               backgroundColor: accent,
// // //                               foregroundColor: Colors.white,
// // //                               elevation: 0,
// // //                               disabledBackgroundColor: text2.withOpacity(0.3),
// // //                               shape: RoundedRectangleBorder(
// // //                                 borderRadius: BorderRadius.circular(16),
// // //                               ),
// // //                             ),
// // //                             child: const Text(
// // //                               'Save',
// // //                               style: TextStyle(
// // //                                 fontSize: 16,
// // //                                 fontWeight: FontWeight.w500,
// // //                               ),
// // //                             ),
// // //                           ),
// // //                         ),

// // //                         const SizedBox(height: 20),
// // //                       ],
// // //                     ),
// // //                   ),
// // //                 ),
// // //               ],
// // //             ),
// // //           );
// // //         },
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildAccountSelector(
// // //     AsyncValue<List<Account>> accountsAsync,
// // //     Color surface,
// // //     Color text1,
// // //     Color text2,
// // //     Color accent,
// // //   ) {
// // //     return accountsAsync.when(
// // //       loading: () => _buildLoadingSelector('Account', surface, text1, text2),
// // //       error: (_, __) => _buildErrorSelector('Account', surface, text1, text2),
// // //       data: (accounts) {
// // //         if (accounts.isEmpty)
// // //           return _buildEmptySelector('No Accounts', surface, text1, text2);

// // //         final selectedAccount =
// // //             accounts.where((acc) => acc.name == _selectedAccount).isNotEmpty
// // //             ? accounts.firstWhere((acc) => acc.name == _selectedAccount)
// // //             : null;

// // //         return GestureDetector(
// // //           onTap: () => _showAccountPicker(accounts),
// // //           child: Container(
// // //             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
// // //             decoration: BoxDecoration(
// // //               color: surface,
// // //               borderRadius: BorderRadius.circular(12),
// // //               border: Border.all(
// // //                 color: selectedAccount != null
// // //                     ? accent.withOpacity(0.3)
// // //                     : text2.withOpacity(0.2),
// // //               ),
// // //             ),
// // //             child: Row(
// // //               children: [
// // //                 Icon(
// // //                   Icons.account_balance_wallet,
// // //                   size: 20,
// // //                   color: selectedAccount != null ? accent : text2,
// // //                 ),
// // //                 const SizedBox(width: 8),
// // //                 Expanded(
// // //                   child: Text(
// // //                     selectedAccount?.name ?? 'Select Account',
// // //                     style: TextStyle(
// // //                       fontSize: 14,
// // //                       color: selectedAccount != null ? text1 : text2,
// // //                     ),
// // //                     overflow: TextOverflow.ellipsis,
// // //                   ),
// // //                 ),
// // //                 Icon(Icons.keyboard_arrow_down, size: 16, color: text2),
// // //               ],
// // //             ),
// // //           ),
// // //         );
// // //       },
// // //     );
// // //   }

// // //   Widget _buildCategorySelector(
// // //     AsyncValue<List<dynamic>> categoriesAsync,
// // //     Color surface,
// // //     Color text1,
// // //     Color text2,
// // //     Color accent,
// // //   ) {
// // //     return categoriesAsync.when(
// // //       loading: () => _buildLoadingSelector('Category', surface, text1, text2),
// // //       error: (_, __) => _buildErrorSelector('Category', surface, text1, text2),
// // //       data: (categories) {
// // //         if (categories.isEmpty)
// // //           return _buildEmptySelector('No Categories', surface, text1, text2);

// // //         String? selectedCategoryName;
// // //         for (var cat in categories) {
// // //           String catName;
// // //           if (cat is ExpenseCategory) {
// // //             catName = cat.name;
// // //           } else if (cat is IncomeCategory) {
// // //             catName = cat.name;
// // //           } else {
// // //             continue;
// // //           }
// // //           if (catName == _selectedCategory) {
// // //             selectedCategoryName = catName;
// // //             break;
// // //           }
// // //         }

// // //         return GestureDetector(
// // //           onTap: () => _showCategoryPicker(categories),
// // //           child: Container(
// // //             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
// // //             decoration: BoxDecoration(
// // //               color: surface,
// // //               borderRadius: BorderRadius.circular(12),
// // //               border: Border.all(
// // //                 color: selectedCategoryName != null
// // //                     ? accent.withOpacity(0.3)
// // //                     : text2.withOpacity(0.2),
// // //               ),
// // //             ),
// // //             child: Row(
// // //               children: [
// // //                 Icon(
// // //                   Icons.category,
// // //                   size: 20,
// // //                   color: selectedCategoryName != null ? accent : text2,
// // //                 ),
// // //                 const SizedBox(width: 8),
// // //                 Expanded(
// // //                   child: Text(
// // //                     selectedCategoryName ?? 'Select Category',
// // //                     style: TextStyle(
// // //                       fontSize: 14,
// // //                       color: selectedCategoryName != null ? text1 : text2,
// // //                     ),
// // //                     overflow: TextOverflow.ellipsis,
// // //                   ),
// // //                 ),
// // //                 Icon(Icons.keyboard_arrow_down, size: 16, color: text2),
// // //               ],
// // //             ),
// // //           ),
// // //         );
// // //       },
// // //     );
// // //   }

// // //   Widget _buildLoadingSelector(
// // //     String label,
// // //     Color surface,
// // //     Color text1,
// // //     Color text2,
// // //   ) {
// // //     return Container(
// // //       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
// // //       decoration: BoxDecoration(
// // //         color: surface,
// // //         borderRadius: BorderRadius.circular(12),
// // //         border: Border.all(color: text2.withOpacity(0.2)),
// // //       ),
// // //       child: Row(
// // //         children: [
// // //           SizedBox(
// // //             width: 16,
// // //             height: 16,
// // //             child: CircularProgressIndicator(strokeWidth: 2, color: text2),
// // //           ),
// // //           const SizedBox(width: 8),
// // //           Text(label, style: TextStyle(fontSize: 14, color: text2)),
// // //         ],
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildErrorSelector(
// // //     String label,
// // //     Color surface,
// // //     Color text1,
// // //     Color text2,
// // //   ) {
// // //     return Container(
// // //       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
// // //       decoration: BoxDecoration(
// // //         color: surface,
// // //         borderRadius: BorderRadius.circular(12),
// // //         border: Border.all(color: text2.withOpacity(0.2)),
// // //       ),
// // //       child: Row(
// // //         children: [
// // //           Icon(Icons.error, size: 16, color: Colors.red),
// // //           const SizedBox(width: 8),
// // //           Text('Error', style: TextStyle(fontSize: 14, color: text2)),
// // //         ],
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildEmptySelector(
// // //     String label,
// // //     Color surface,
// // //     Color text1,
// // //     Color text2,
// // //   ) {
// // //     return Container(
// // //       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
// // //       decoration: BoxDecoration(
// // //         color: surface,
// // //         borderRadius: BorderRadius.circular(12),
// // //         border: Border.all(color: text2.withOpacity(0.2)),
// // //       ),
// // //       child: Text(label, style: TextStyle(fontSize: 14, color: text2)),
// // //     );
// // //   }

// // //   Widget _buildDateSelector(Color surface, Color text1, Color text2) {
// // //     return GestureDetector(
// // //       onTap: _selectDate,
// // //       child: Container(
// // //         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
// // //         decoration: BoxDecoration(
// // //           color: surface,
// // //           borderRadius: BorderRadius.circular(12),
// // //           border: Border.all(color: text2.withOpacity(0.2)),
// // //         ),
// // //         child: Row(
// // //           children: [
// // //             Icon(Icons.calendar_today, size: 16, color: text2),
// // //             const SizedBox(width: 8),
// // //             Text(
// // //               _formatDate(_selectedDate),
// // //               style: TextStyle(fontSize: 14, color: text1),
// // //             ),
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildTypeToggle(
// // //     TransactionType type,
// // //     Color accent,
// // //     Color surface,
// // //     Color text1,
// // //   ) {
// // //     return Container(
// // //       decoration: BoxDecoration(
// // //         color: surface,
// // //         borderRadius: BorderRadius.circular(12),
// // //         border: Border.all(color: accent.withOpacity(0.2)),
// // //       ),
// // //       child: Row(
// // //         mainAxisSize: MainAxisSize.min,
// // //         children: [
// // //           _buildToggleButton(
// // //             'Expense',
// // //             Icons.arrow_downward,
// // //             type == TransactionType.expense,
// // //             () => setState(() {
// // //               _selectedType = TransactionType.expense;
// // //               _selectedCategory = null;
// // //             }),
// // //             accent,
// // //             text1,
// // //           ),
// // //           _buildToggleButton(
// // //             'Income',
// // //             Icons.arrow_upward,
// // //             type == TransactionType.income,
// // //             () => setState(() {
// // //               _selectedType = TransactionType.income;
// // //               _selectedCategory = null;
// // //             }),
// // //             accent,
// // //             text1,
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildToggleButton(
// // //     String label,
// // //     IconData icon,
// // //     bool selected,
// // //     VoidCallback onTap,
// // //     Color accent,
// // //     Color text1,
// // //   ) {
// // //     return GestureDetector(
// // //       onTap: onTap,
// // //       child: Container(
// // //         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
// // //         decoration: BoxDecoration(
// // //           color: selected ? accent.withOpacity(0.1) : Colors.transparent,
// // //           borderRadius: BorderRadius.circular(10),
// // //         ),
// // //         child: Row(
// // //           mainAxisSize: MainAxisSize.min,
// // //           children: [
// // //             Icon(
// // //               icon,
// // //               size: 14,
// // //               color: selected ? accent : text1.withOpacity(0.6),
// // //             ),
// // //             const SizedBox(width: 4),
// // //             Text(
// // //               label,
// // //               style: TextStyle(
// // //                 fontSize: 12,
// // //                 color: selected ? accent : text1.withOpacity(0.6),
// // //                 fontWeight: selected ? FontWeight.w500 : FontWeight.w400,
// // //               ),
// // //             ),
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildCommentField(Color text2) {
// // //     return TextField(
// // //       controller: _commentController,
// // //       decoration: InputDecoration(
// // //         hintText: 'Add comment...',
// // //         hintStyle: TextStyle(color: text2, fontSize: 14),
// // //         border: InputBorder.none,
// // //         contentPadding: EdgeInsets.zero,
// // //       ),
// // //       textAlign: TextAlign.center,
// // //       style: TextStyle(fontSize: 14, color: text2),
// // //     );
// // //   }

// // //   Widget _buildKeypad(Color surface, Color text1, Color text2, Color accent) {
// // //     return Container(
// // //       padding: const EdgeInsets.all(16),
// // //       decoration: BoxDecoration(
// // //         color: surface,
// // //         borderRadius: BorderRadius.circular(16),
// // //       ),
// // //       child: Column(
// // //         children: [
// // //           _buildKeypadRow(['1', '2', '3'], text1, accent),
// // //           const SizedBox(height: 12),
// // //           _buildKeypadRow(['4', '5', '6'], text1, accent),
// // //           const SizedBox(height: 12),
// // //           _buildKeypadRow(['7', '8', '9'], text1, accent),
// // //           const SizedBox(height: 12),
// // //           _buildKeypadRow(['.', '0', '⌫'], text1, accent),
// // //         ],
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildKeypadRow(List<String> keys, Color text1, Color accent) {
// // //     return Row(
// // //       children: keys.map((key) {
// // //         return Expanded(
// // //           child: Padding(
// // //             padding: const EdgeInsets.symmetric(horizontal: 4),
// // //             child: _buildKeypadButton(key, text1, accent),
// // //           ),
// // //         );
// // //       }).toList(),
// // //     );
// // //   }

// // //   Widget _buildKeypadButton(String key, Color text1, Color accent) {
// // //     return GestureDetector(
// // //       onTap: () => _onKeypadTap(key),
// // //       child: Container(
// // //         height: 56,
// // //         decoration: BoxDecoration(
// // //           color: key == '⌫' ? accent.withOpacity(0.1) : Colors.transparent,
// // //           borderRadius: BorderRadius.circular(12),
// // //         ),
// // //         child: Center(
// // //           child: key == '⌫'
// // //               ? Icon(Icons.backspace_outlined, color: accent, size: 20)
// // //               : Text(
// // //                   key,
// // //                   style: TextStyle(
// // //                     fontSize: 20,
// // //                     color: text1,
// // //                     fontWeight: FontWeight.w400,
// // //                   ),
// // //                 ),
// // //         ),
// // //       ),
// // //     );
// // //   }

// // //   void _onKeypadTap(String key) {
// // //     HapticFeedback.selectionClick();

// // //     if (key == '⌫') {
// // //       if (_amount.isNotEmpty) {
// // //         setState(() => _amount = _amount.substring(0, _amount.length - 1));
// // //       }
// // //     } else if (key == '.') {
// // //       if (!_amount.contains('.') && _amount.isNotEmpty) {
// // //         setState(() => _amount = _amount + key);
// // //       }
// // //     } else {
// // //       if (_amount.length < 10) {
// // //         setState(() => _amount = _amount + key);
// // //       }
// // //     }
// // //   }

// // //   String _formatAmount(String amount) {
// // //     if (amount.isEmpty) return '0.00';
// // //     final double? value = double.tryParse(amount);
// // //     if (value == null) return amount;
// // //     return value.toStringAsFixed(2);
// // //   }

// // //   String _formatDate(DateTime date) {
// // //     final now = DateTime.now();
// // //     if (date.year == now.year &&
// // //         date.month == now.month &&
// // //         date.day == now.day) {
// // //       return 'Today';
// // //     } else if (date.year == now.year &&
// // //         date.month == now.month &&
// // //         date.day == now.day - 1) {
// // //       return 'Yesterday';
// // //     }
// // //     return '${date.day}/${date.month}/${date.year}';
// // //   }

// // //   void _showAccountPicker(List<Account> accounts) {
// // //     showModalBottomSheet(
// // //       context: context,
// // //       backgroundColor: Colors.transparent,
// // //       builder: (context) => Container(
// // //         margin: const EdgeInsets.all(16),
// // //         decoration: BoxDecoration(
// // //           color: Theme.of(context).colorScheme.surface,
// // //           borderRadius: BorderRadius.circular(16),
// // //         ),
// // //         child: Column(
// // //           mainAxisSize: MainAxisSize.min,
// // //           children: [
// // //             const Padding(
// // //               padding: EdgeInsets.all(16),
// // //               child: Text(
// // //                 'Select Account',
// // //                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
// // //               ),
// // //             ),
// // //             ...accounts.map((account) {
// // //               return ListTile(
// // //                 leading: const Icon(Icons.account_balance_wallet),
// // //                 title: Text(account.name),
// // //                 onTap: () {
// // //                   setState(() => _selectedAccount = account.name);
// // //                   Navigator.pop(context);
// // //                 },
// // //               );
// // //             }).toList(),
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }

// // //   void _showCategoryPicker(List<dynamic> categories) {
// // //     showModalBottomSheet(
// // //       context: context,
// // //       backgroundColor: Colors.transparent,
// // //       builder: (context) => Container(
// // //         margin: const EdgeInsets.all(16),
// // //         decoration: BoxDecoration(
// // //           color: Theme.of(context).colorScheme.surface,
// // //           borderRadius: BorderRadius.circular(16),
// // //         ),
// // //         child: Column(
// // //           mainAxisSize: MainAxisSize.min,
// // //           children: [
// // //             const Padding(
// // //               padding: EdgeInsets.all(16),
// // //               child: Text(
// // //                 'Select Category',
// // //                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
// // //               ),
// // //             ),
// // //             Flexible(
// // //               child: GridView.builder(
// // //                 shrinkWrap: true,
// // //                 padding: const EdgeInsets.all(16),
// // //                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
// // //                   crossAxisCount: 3,
// // //                   childAspectRatio: 1.2,
// // //                 ),
// // //                 itemCount: categories.length,
// // //                 itemBuilder: (context, index) {
// // //                   final category = categories[index];
// // //                   String categoryName;
// // //                   if (category is ExpenseCategory) {
// // //                     categoryName = category.name;
// // //                   } else if (category is IncomeCategory) {
// // //                     categoryName = category.name;
// // //                   } else {
// // //                     categoryName = category.toString();
// // //                   }

// // //                   return GestureDetector(
// // //                     onTap: () {
// // //                       setState(() => _selectedCategory = categoryName);
// // //                       Navigator.pop(context);
// // //                     },
// // //                     child: Column(
// // //                       mainAxisAlignment: MainAxisAlignment.center,
// // //                       children: [
// // //                         const Icon(Icons.category, size: 28),
// // //                         const SizedBox(height: 8),
// // //                         Text(
// // //                           categoryName,
// // //                           style: const TextStyle(fontSize: 12),
// // //                           textAlign: TextAlign.center,
// // //                           overflow: TextOverflow.ellipsis,
// // //                         ),
// // //                       ],
// // //                     ),
// // //                   );
// // //                 },
// // //               ),
// // //             ),
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }

// // //   void _selectDate() async {
// // //     final picked = await showDatePicker(
// // //       context: context,
// // //       initialDate: _selectedDate,
// // //       firstDate: DateTime(2020),
// // //       lastDate: DateTime(2030),
// // //     );
// // //     if (picked != null) {
// // //       setState(() => _selectedDate = picked);
// // //     }
// // //   }

// // //   bool _canSave() {
// // //     return _selectedAccount != null &&
// // //         _selectedCategory != null &&
// // //         _amount.isNotEmpty &&
// // //         double.tryParse(_amount) != null &&
// // //         double.parse(_amount) > 0;
// // //   }

// // //   void _saveTransaction() async {
// // //     if (!_canSave()) return;

// // //     final transaction = TransactionModel(
// // //       id: const Uuid().v4(),
// // //       type: _selectedType,
// // //       date: _selectedDate,
// // //       title: _commentController.text.isNotEmpty
// // //           ? _commentController.text
// // //           : 'Transaction',
// // //       amount: double.parse(_amount),
// // //       account: _selectedAccount,
// // //       category: _selectedCategory,
// // //       note: _commentController.text.isEmpty ? null : _commentController.text,
// // //     );

// // //     try {
// // //       await ref.read(transactionsProvider.notifier).addTransaction(transaction);
// // //       if (mounted) {
// // //         HapticFeedback.mediumImpact();
// // //         Navigator.of(context).pop();
// // //       }
// // //     } catch (e) {
// // //       if (mounted) {
// // //         ScaffoldMessenger.of(
// // //           context,
// // //         ).showSnackBar(SnackBar(content: Text('Error adding transaction: $e')));
// // //       }
// // //     }
// // //   }
// // // }

// // import 'package:flutter/material.dart';
// // import 'package:flutter_riverpod/flutter_riverpod.dart';
// // import 'package:flutter/services.dart';
// // import 'package:uuid/uuid.dart';
// // import 'package:expense_project/core/models/transaction_model.dart';
// // import 'package:expense_project/core/models/account_model.dart';
// // import 'package:expense_project/core/models/category_model.dart';
// // import 'package:expense_project/features/accounts/accounts_provider.dart';
// // import 'package:expense_project/features/categories/categories_provider.dart';
// // import 'package:expense_project/features/transactions/transactions_provider.dart';

// // class AddTransactionPage extends ConsumerStatefulWidget {
// //   const AddTransactionPage({super.key});

// //   @override
// //   ConsumerState<AddTransactionPage> createState() => _AddTransactionPageState();
// // }

// // class _AddTransactionPageState extends ConsumerState<AddTransactionPage> {
// //   TransactionType _selectedType = TransactionType.expense;
// //   String? _selectedAccount;
// //   String? _selectedCategory;
// //   DateTime _selectedDate = DateTime.now();
// //   String _amount = '';
// //   final TextEditingController _commentController = TextEditingController();

// //   @override
// //   void dispose() {
// //     _commentController.dispose();
// //     super.dispose();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     final theme = Theme.of(context);
// //     final isDark = theme.brightness == Brightness.dark;

// //     final surface = isDark ? const Color(0xFF111111) : const Color(0xFFFBFBFB);
// //     final text1 = isDark ? Colors.white : Colors.black;
// //     final text2 = isDark ? const Color(0xFF888888) : const Color(0xFF666666);
// //     final accent = const Color(0xFF007AFF);

// //     final accountsAsync = ref.watch(accountsProvider);
// //     final categoriesAsync = _selectedType == TransactionType.expense
// //         ? ref.watch(expenseCategoriesProvider)
// //         : ref.watch(incomeCategoriesProvider);

// //     return Scaffold(
// //       backgroundColor: Colors.transparent,
// //       body: DraggableScrollableSheet(
// //         expand: false,
// //         initialChildSize: 0.95,
// //         minChildSize: 0.4,
// //         maxChildSize: 1.0,
// //         builder: (context, scrollController) {
// //           return Container(
// //             decoration: BoxDecoration(
// //               color: surface,
// //               borderRadius: const BorderRadius.vertical(
// //                 top: Radius.circular(24),
// //               ),
// //               boxShadow: [
// //                 BoxShadow(
// //                   color: Colors.black.withOpacity(isDark ? 0.3 : 0.1),
// //                   blurRadius: 20,
// //                   offset: const Offset(0, -5),
// //                 ),
// //               ],
// //             ),
// //             child: Padding(
// //               padding: const EdgeInsets.symmetric(horizontal: 20),
// //               child: Column(
// //                 children: [
// //                   Container(
// //                     width: 40,
// //                     height: 4,
// //                     margin: const EdgeInsets.only(top: 12, bottom: 12),
// //                     decoration: BoxDecoration(
// //                       color: text2.withOpacity(0.3),
// //                       borderRadius: BorderRadius.circular(2),
// //                     ),
// //                   ),

// //                   // Account & Category
// //                   Row(
// //                     children: [
// //                       Expanded(
// //                         child: _buildAccountSelector(
// //                           accountsAsync,
// //                           surface,
// //                           text1,
// //                           text2,
// //                           accent,
// //                         ),
// //                       ),
// //                       const SizedBox(width: 16),
// //                       Expanded(
// //                         child: _buildCategorySelector(
// //                           categoriesAsync,
// //                           surface,
// //                           text1,
// //                           text2,
// //                           accent,
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                   const SizedBox(height: 12),

// //                   // Date & Type toggle
// //                   Row(
// //                     children: [
// //                       Expanded(
// //                         child: _buildDateSelector(surface, text1, text2),
// //                       ),
// //                       const SizedBox(width: 16),
// //                       _buildTypeToggle(_selectedType, accent, surface, text1),
// //                     ],
// //                   ),

// //                   const SizedBox(height: 12),

// //                   // Amount + comment
// //                   Text(
// //                     '₹${_formatAmount(_amount)}',
// //                     style: TextStyle(
// //                       fontSize: 42,
// //                       fontWeight: FontWeight.w200,
// //                       color: _selectedType == TransactionType.expense
// //                           ? const Color(0xFFFF3B30)
// //                           : const Color(0xFF34C759),
// //                     ),
// //                   ),
// //                   _buildCommentField(text2),

// //                   const Spacer(),

// //                   // Keypad
// //                   _buildKeypad(surface, text1, text2, accent),

// //                   const SizedBox(height: 12),

// //                   // Save button
// //                   SizedBox(
// //                     width: double.infinity,
// //                     height: 54,
// //                     child: ElevatedButton(
// //                       onPressed: _canSave() ? _saveTransaction : null,
// //                       style: ElevatedButton.styleFrom(
// //                         backgroundColor: accent,
// //                         foregroundColor: Colors.white,
// //                         disabledBackgroundColor: text2.withOpacity(0.3),
// //                         shape: RoundedRectangleBorder(
// //                           borderRadius: BorderRadius.circular(14),
// //                         ),
// //                       ),
// //                       child: const Text('Save', style: TextStyle(fontSize: 16)),
// //                     ),
// //                   ),
// //                   const SizedBox(height: 16),
// //                 ],
// //               ),
// //             ),
// //           );
// //         },
// //       ),
// //     );
// //   }

// //   // --- UI Builders ---

// //   Widget _buildAccountSelector(
// //     AsyncValue<List<Account>> data,
// //     Color surface,
// //     Color t1,
// //     Color t2,
// //     Color accent,
// //   ) {
// //     return data.when(
// //       loading: () => _loadingTile('Account', surface, t2),
// //       error: (_, __) => _errorTile(surface, t2),
// //       data: (accounts) {
// //         final selAcc = accounts.firstWhere(
// //           (a) => a.name == _selectedAccount,
// //           orElse: () => accounts.isEmpty
// //               ? Account(
// //                   id: '',
// //                   name: '',
// //                   balance: 0,
// //                   type: '',
// //                   role: AccountRole.both,
// //                 )
// //               : accounts.first,
// //         );
// //         return _dropdownTile(
// //           selAcc.name.isNotEmpty ? selAcc.name : 'Select Account',
// //           Icons.account_balance_wallet,
// //           surface,
// //           t1,
// //           t2,
// //           accent,
// //           onTap: () => _showAccountPicker(accounts),
// //           selected: _selectedAccount != null,
// //         );
// //       },
// //     );
// //   }

// //   Widget _buildCategorySelector(
// //     AsyncValue<List<dynamic>> data,
// //     Color surface,
// //     Color t1,
// //     Color t2,
// //     Color accent,
// //   ) {
// //     return data.when(
// //       loading: () => _loadingTile('Category', surface, t2),
// //       error: (_, __) => _errorTile(surface, t2),
// //       data: (categories) {
// //         String? selName;
// //         for (var c in categories) {
// //           if (c is ExpenseCategory && c.name == _selectedCategory)
// //             selName = c.name;
// //           if (c is IncomeCategory && c.name == _selectedCategory)
// //             selName = c.name;
// //         }
// //         return _dropdownTile(
// //           selName ?? 'Select Category',
// //           Icons.category,
// //           surface,
// //           t1,
// //           t2,
// //           accent,
// //           onTap: () => _showCategoryPicker(categories),
// //           selected: _selectedCategory != null,
// //         );
// //       },
// //     );
// //   }

// //   Widget _buildDateSelector(Color surface, Color t1, Color t2) {
// //     return GestureDetector(
// //       onTap: _selectDate,
// //       child: _dropdownTile(
// //         _formatDate(_selectedDate),
// //         Icons.calendar_today,
// //         surface,
// //         t1,
// //         t2,
// //         const Color(0xFF007AFF),
// //         selected: true,
// //       ),
// //     );
// //   }

// //   Widget _buildTypeToggle(
// //     TransactionType type,
// //     Color accent,
// //     Color surface,
// //     Color t1,
// //   ) {
// //     return Container(
// //       padding: const EdgeInsets.all(4),
// //       decoration: BoxDecoration(
// //         color: surface,
// //         borderRadius: BorderRadius.circular(12),
// //         border: Border.all(color: accent.withOpacity(0.3)),
// //       ),
// //       child: Row(
// //         mainAxisSize: MainAxisSize.min,
// //         children: [
// //           _toggleBtn(
// //             'Expense',
// //             Icons.arrow_downward,
// //             type == TransactionType.expense,
// //             () {
// //               setState(() => _selectedType = TransactionType.expense);
// //             },
// //             accent,
// //             t1,
// //           ),
// //           _toggleBtn(
// //             'Income',
// //             Icons.arrow_upward,
// //             type == TransactionType.income,
// //             () {
// //               setState(() => _selectedType = TransactionType.income);
// //             },
// //             accent,
// //             t1,
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _toggleBtn(
// //     String text,
// //     IconData icon,
// //     bool sel,
// //     VoidCallback onTap,
// //     Color accent,
// //     Color t1,
// //   ) {
// //     return GestureDetector(
// //       onTap: onTap,
// //       child: Container(
// //         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
// //         decoration: BoxDecoration(
// //           color: sel ? accent.withOpacity(0.1) : Colors.transparent,
// //           borderRadius: BorderRadius.circular(8),
// //         ),
// //         child: Row(
// //           children: [
// //             Icon(icon, size: 14, color: sel ? accent : t1.withOpacity(0.6)),
// //             const SizedBox(width: 4),
// //             Text(
// //               text,
// //               style: TextStyle(
// //                 fontSize: 12,
// //                 color: sel ? accent : t1.withOpacity(0.6),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildCommentField(Color t2) {
// //     return TextField(
// //       controller: _commentController,
// //       textAlign: TextAlign.center,
// //       decoration: InputDecoration(
// //         hintText: 'Add comment...',
// //         border: InputBorder.none,
// //         hintStyle: TextStyle(color: t2, fontSize: 14),
// //       ),
// //     );
// //   }

// //   // --- Keypad with functions ---
// //   Widget _buildKeypad(Color surface, Color t1, Color t2, Color accent) {
// //     final rows = [
// //       ['1', '2', '3', 'back'],
// //       ['4', '5', '6', 'date'],
// //       ['7', '8', '9', 'right'],
// //       ['rs', '0', '.', 'right'],
// //     ];
// //     return Column(
// //       children: rows.map((r) {
// //         return Padding(
// //           padding: const EdgeInsets.only(bottom: 8),
// //           child: Row(
// //             children: r
// //                 .map(
// //                   (key) => Expanded(
// //                     child: Padding(
// //                       padding: const EdgeInsets.symmetric(horizontal: 2),
// //                       child: _keyButton(key, t1, accent),
// //                     ),
// //                   ),
// //                 )
// //                 .toList(),
// //           ),
// //         );
// //       }).toList(),
// //     );
// //   }

// //   Widget _keyButton(String key, Color t1, Color accent) {
// //     IconData? icon;
// //     if (key == 'back') icon = Icons.backspace_outlined;
// //     if (key == 'right') icon = Icons.check_circle;
// //     if (key == 'date') icon = Icons.calendar_today;
// //     if (key == 'rs') icon = Icons.currency_rupee;

// //     return GestureDetector(
// //       onTap: () {
// //         if (key == 'right') {
// //           if (_canSave()) _saveTransaction();
// //         } else if (key == 'back') {
// //           if (_amount.isNotEmpty)
// //             setState(() => _amount = _amount.substring(0, _amount.length - 1));
// //         } else if (key == 'date') {
// //           _selectDate();
// //         } else if (key == 'rs') {
// //           setState(() => _amount = '');
// //         } else {
// //           if (key == '.' && _amount.contains('.')) return;
// //           setState(() => _amount += key);
// //         }
// //       },
// //       child: Container(
// //         height: 54,
// //         decoration: BoxDecoration(
// //           color: (key == 'right' && _canSave())
// //               ? accent
// //               : (key == 'back' || key == 'date' || key == 'rs')
// //               ? accent.withOpacity(0.1)
// //               : Colors.transparent,
// //           borderRadius: BorderRadius.circular(10),
// //         ),
// //         child: Center(
// //           child: icon != null
// //               ? Icon(
// //                   icon,
// //                   color: (key == 'right' && _canSave()) ? Colors.white : accent,
// //                   size: 22,
// //                 )
// //               : Text(key, style: TextStyle(fontSize: 20, color: t1)),
// //         ),
// //       ),
// //     );
// //   }

// //   // --- Utility UI ---
// //   Widget _dropdownTile(
// //     String text,
// //     IconData icon,
// //     Color surface,
// //     Color t1,
// //     Color t2,
// //     Color accent, {
// //     VoidCallback? onTap,
// //     bool selected = false,
// //   }) {
// //     return GestureDetector(
// //       onTap: onTap,
// //       child: Container(
// //         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
// //         decoration: BoxDecoration(
// //           color: surface,
// //           borderRadius: BorderRadius.circular(12),
// //           border: Border.all(color: (selected ? accent : t2).withOpacity(0.3)),
// //         ),
// //         child: Row(
// //           children: [
// //             Icon(icon, size: 18, color: selected ? accent : t2),
// //             const SizedBox(width: 6),
// //             Expanded(
// //               child: Text(
// //                 text,
// //                 style: TextStyle(fontSize: 14, color: selected ? t1 : t2),
// //               ),
// //             ),
// //             Icon(Icons.keyboard_arrow_down, size: 16, color: t2),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _loadingTile(String l, Color surface, Color t2) =>
// //       _dropdownTile(l, Icons.hourglass_empty, surface, t2, t2, t2);
// //   Widget _errorTile(Color surface, Color t2) =>
// //       _dropdownTile('Error', Icons.error, surface, t2, t2, t2);

// //   // --- Helpers ---
// //   String _formatAmount(String a) {
// //     if (a.isEmpty) return '0.00';
// //     final val = double.tryParse(a);
// //     return val == null ? a : val.toStringAsFixed(2);
// //   }

// //   String _formatDate(DateTime d) => '${d.day}/${d.month}/${d.year}';

// //   bool _canSave() =>
// //       _selectedAccount != null &&
// //       _selectedCategory != null &&
// //       _amount.isNotEmpty &&
// //       double.tryParse(_amount) != null;

// //   void _selectDate() async {
// //     final picked = await showDatePicker(
// //       context: context,
// //       initialDate: _selectedDate,
// //       firstDate: DateTime(2020),
// //       lastDate: DateTime(2030),
// //     );
// //     if (picked != null) setState(() => _selectedDate = picked);
// //   }

// //   Future<void> _showAccountPicker(List<Account> accounts) async {
// //     showModalBottomSheet(
// //       context: context,
// //       builder: (_) => ListView(
// //         shrinkWrap: true,
// //         children: accounts
// //             .map(
// //               (a) => ListTile(
// //                 title: Text(a.name),
// //                 onTap: () {
// //                   setState(() => _selectedAccount = a.name);
// //                   Navigator.pop(context);
// //                 },
// //               ),
// //             )
// //             .toList(),
// //       ),
// //     );
// //   }

// //   Future<void> _showCategoryPicker(List<dynamic> cats) async {
// //     showModalBottomSheet(
// //       context: context,
// //       builder: (_) => ListView(
// //         shrinkWrap: true,
// //         children: cats.map((c) {
// //           String name = c is ExpenseCategory
// //               ? c.name
// //               : (c is IncomeCategory ? c.name : c.toString());
// //           return ListTile(
// //             title: Text(name),
// //             onTap: () {
// //               setState(() => _selectedCategory = name);
// //               Navigator.pop(context);
// //             },
// //           );
// //         }).toList(),
// //       ),
// //     );
// //   }

// //   void _saveTransaction() async {
// //     final tx = TransactionModel(
// //       id: const Uuid().v4(),
// //       type: _selectedType,
// //       date: _selectedDate,
// //       title: _commentController.text.isNotEmpty
// //           ? _commentController.text
// //           : 'Transaction',
// //       amount: double.parse(_amount),
// //       account: _selectedAccount,
// //       category: _selectedCategory,
// //       note: _commentController.text.isEmpty ? null : _commentController.text,
// //     );
// //     await ref.read(transactionsProvider.notifier).addTransaction(tx);
// //     if (mounted) Navigator.pop(context);
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:uuid/uuid.dart';
// import 'package:expense_project/core/models/transaction_model.dart';
// import 'package:expense_project/core/models/account_model.dart';
// import 'package:expense_project/core/models/category_model.dart';
// import 'package:expense_project/features/accounts/accounts_provider.dart';
// import 'package:expense_project/features/categories/categories_provider.dart';
// import 'package:expense_project/features/transactions/transactions_provider.dart';

// class AddTransactionPage extends ConsumerStatefulWidget {
//   const AddTransactionPage({super.key});

//   @override
//   ConsumerState<AddTransactionPage> createState() => _AddTransactionPageState();
// }

// class _AddTransactionPageState extends ConsumerState<AddTransactionPage> {
//   TransactionType _selectedType = TransactionType.expense;
//   String? _selectedAccount;
//   String? _selectedCategory;
//   DateTime _selectedDate = DateTime.now();
//   String _amount = '';
//   final TextEditingController _commentController = TextEditingController();

//   @override
//   void dispose() {
//     _commentController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//     final surface = isDark ? const Color(0xFF1C1C1E) : Colors.white;
//     final text1 = isDark ? Colors.white : Colors.black;
//     final text2 = isDark ? Colors.grey[500]! : Colors.grey[700]!;
//     final accent = const Color(0xFF007AFF);

//     final accountsAsync = ref.watch(accountsProvider);
//     final categoriesAsync = _selectedType == TransactionType.expense
//         ? ref.watch(expenseCategoriesProvider)
//         : ref.watch(incomeCategoriesProvider);

//     return Scaffold(
//       backgroundColor: Colors.transparent,
//       resizeToAvoidBottomInset: true,
//       body: GestureDetector(
//         onTap: () => FocusScope.of(context).unfocus(),
//         child: DraggableScrollableSheet(
//           expand: false,
//           initialChildSize: 0.95,
//           minChildSize: 0.4,
//           maxChildSize: 1.0,
//           builder: (context, scrollController) {
//             return Container(
//               decoration: BoxDecoration(
//                 color: surface,
//                 borderRadius: const BorderRadius.vertical(
//                   top: Radius.circular(24),
//                 ),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(isDark ? 0.3 : 0.08),
//                     blurRadius: 15,
//                     offset: const Offset(0, -4),
//                   ),
//                 ],
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: ListView(
//                   controller: scrollController,
//                   children: [
//                     // Handle bar
//                     Center(
//                       child: Container(
//                         width: 40,
//                         height: 4,
//                         margin: const EdgeInsets.only(top: 12, bottom: 16),
//                         decoration: BoxDecoration(
//                           color: text2.withOpacity(0.35),
//                           borderRadius: BorderRadius.circular(2),
//                         ),
//                       ),
//                     ),
//                     // Account & Category
//                     Row(
//                       children: [
//                         Expanded(
//                           child: _buildAccountDropdown(
//                             accountsAsync,
//                             surface,
//                             text1,
//                             text2,
//                             accent,
//                           ),
//                         ),
//                         const SizedBox(width: 14),
//                         Expanded(
//                           child: _buildCategoryDropdown(
//                             categoriesAsync,
//                             surface,
//                             text1,
//                             text2,
//                             accent,
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 14),
//                     // Date + Toggle
//                     Row(
//                       children: [
//                         Expanded(
//                           child: _buildDateSelector(surface, text1, text2),
//                         ),
//                         const SizedBox(width: 14),
//                         _buildTypeToggle(_selectedType, accent, surface, text1),
//                       ],
//                     ),
//                     const SizedBox(height: 18),
//                     // Amount
//                     Text(
//                       '₹${_formatAmount(_amount)}',
//                       style: TextStyle(
//                         fontSize: 42,
//                         fontWeight: FontWeight.w200,
//                         color: _selectedType == TransactionType.expense
//                             ? const Color(0xFFFF3B30)
//                             : const Color(0xFF34C759),
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                     const SizedBox(height: 8),
//                     // Comment
//                     _buildCommentField(text2),
//                     const SizedBox(height: 20),
//                     // Keypad
//                     _buildKeypad(surface, text1, text2, accent),
//                     const SizedBox(height: 16),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }

//   // Inline Account Dropdown
//   Widget _buildAccountDropdown(
//     AsyncValue<List<Account>> data,
//     Color surface,
//     Color t1,
//     Color t2,
//     Color accent,
//   ) {
//     return data.when(
//       loading: () => _loadingTile('Account', surface, t2),
//       error: (_, __) => _errorTile(surface, t2),
//       data: (accounts) {
//         return Container(
//           padding: const EdgeInsets.symmetric(horizontal: 12),
//           decoration: BoxDecoration(
//             color: surface,
//             borderRadius: BorderRadius.circular(12),
//             border: Border.all(color: accent.withOpacity(0.3)),
//           ),
//           child: DropdownButtonHideUnderline(
//             child: DropdownButton<String>(
//               dropdownColor: surface,
//               value: _selectedAccount,
//               hint: Text('Account', style: TextStyle(color: t2)),
//               isExpanded: true,
//               items: accounts.map((acc) {
//                 return DropdownMenuItem(
//                   value: acc.name,
//                   child: Text(acc.name, style: TextStyle(color: t1)),
//                 );
//               }).toList(),
//               onChanged: (val) {
//                 setState(() => _selectedAccount = val);
//               },
//             ),
//           ),
//         );
//       },
//     );
//   }

//   // Inline Category Dropdown
//   Widget _buildCategoryDropdown(
//     AsyncValue<List<dynamic>> data,
//     Color surface,
//     Color t1,
//     Color t2,
//     Color accent,
//   ) {
//     return data.when(
//       loading: () => _loadingTile('Category', surface, t2),
//       error: (_, __) => _errorTile(surface, t2),
//       data: (categories) {
//         List<String> names = categories.map((c) {
//           if (c is ExpenseCategory) return c.name;
//           if (c is IncomeCategory) return c.name;
//           return c.toString();
//         }).toList();
//         return Container(
//           padding: const EdgeInsets.symmetric(horizontal: 12),
//           decoration: BoxDecoration(
//             color: surface,
//             borderRadius: BorderRadius.circular(12),
//             border: Border.all(color: accent.withOpacity(0.3)),
//           ),
//           child: DropdownButtonHideUnderline(
//             child: DropdownButton<String>(
//               dropdownColor: surface,
//               value: _selectedCategory,
//               hint: Text('Category', style: TextStyle(color: t2)),
//               isExpanded: true,
//               items: names.map((cat) {
//                 return DropdownMenuItem(
//                   value: cat,
//                   child: Text(cat, style: TextStyle(color: t1)),
//                 );
//               }).toList(),
//               onChanged: (val) {
//                 setState(() => _selectedCategory = val);
//               },
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildDateSelector(Color surface, Color t1, Color t2) {
//     return GestureDetector(
//       onTap: _selectDate,
//       child: _dropdownTile(
//         _formatDate(_selectedDate),
//         Icons.calendar_today,
//         surface,
//         t1,
//         t2,
//         const Color(0xFF007AFF),
//         selected: true,
//       ),
//     );
//   }

//   Widget _buildTypeToggle(
//     TransactionType type,
//     Color accent,
//     Color surface,
//     Color t1,
//   ) {
//     return Container(
//       padding: const EdgeInsets.all(4),
//       decoration: BoxDecoration(
//         color: surface,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: accent.withOpacity(0.25)),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           _toggleBtn(
//             'Expense',
//             Icons.arrow_downward,
//             type == TransactionType.expense,
//             () => setState(() => _selectedType = TransactionType.expense),
//             accent,
//             t1,
//           ),
//           _toggleBtn(
//             'Income',
//             Icons.arrow_upward,
//             type == TransactionType.income,
//             () => setState(() => _selectedType = TransactionType.income),
//             accent,
//             t1,
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _toggleBtn(
//     String text,
//     IconData icon,
//     bool sel,
//     VoidCallback onTap,
//     Color accent,
//     Color t1,
//   ) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
//         decoration: BoxDecoration(
//           color: sel ? accent.withOpacity(0.1) : Colors.transparent,
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: Row(
//           children: [
//             Icon(icon, size: 14, color: sel ? accent : t1.withOpacity(0.6)),
//             const SizedBox(width: 4),
//             Text(
//               text,
//               style: TextStyle(
//                 fontSize: 12,
//                 color: sel ? accent : t1.withOpacity(0.6),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildCommentField(Color t2) {
//     return TextField(
//       controller: _commentController,
//       textAlign: TextAlign.center,
//       decoration: InputDecoration(
//         hintText: 'Add comment...',
//         border: InputBorder.none,
//         hintStyle: TextStyle(color: t2, fontSize: 14),
//       ),
//     );
//   }

//   // Keypad
//   Widget _buildKeypad(Color surface, Color t1, Color t2, Color accent) {
//     return Column(
//       children: [
//         _keypadRow(['1', '2', '3', 'back'], t1, accent),
//         const SizedBox(height: 8),
//         _keypadRow(['4', '5', '6', 'date'], t1, accent),
//         const SizedBox(height: 8),
//         Row(
//           children: [
//             Expanded(
//               child: Column(
//                 children: [
//                   _keypadRow(['7', '8', '9'], t1, accent, shrink: true),
//                   const SizedBox(height: 8),
//                   _keypadRow(['rs', '0', '.'], t1, accent, shrink: true),
//                 ],
//               ),
//             ),
//             const SizedBox(width: 4),
//             GestureDetector(
//               onTap: () {
//                 if (_canSave()) _saveTransaction();
//               },
//               child: Container(
//                 height: 116,
//                 width: 70,
//                 decoration: BoxDecoration(
//                   color: _canSave() ? accent : accent.withOpacity(0.3),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: const Icon(
//                   Icons.check_circle,
//                   color: Colors.white,
//                   size: 32,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _keypadRow(
//     List<String> keys,
//     Color t1,
//     Color accent, {
//     bool shrink = false,
//   }) {
//     return Row(
//       children: keys.map((key) {
//         IconData? icon;
//         if (key == 'back') icon = Icons.backspace_outlined;
//         if (key == 'date') icon = Icons.calendar_today;
//         if (key == 'rs') icon = Icons.currency_rupee;

//         return Expanded(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 2),
//             child: GestureDetector(
//               onTap: () {
//                 if (key == 'back') {
//                   if (_amount.isNotEmpty) {
//                     setState(
//                       () => _amount = _amount.substring(0, _amount.length - 1),
//                     );
//                   }
//                 } else if (key == 'date') {
//                   _selectDate();
//                 } else if (key == 'rs') {
//                   setState(() => _amount = '');
//                 } else {
//                   if (key == '.' && _amount.contains('.')) return;
//                   setState(() => _amount += key);
//                 }
//               },
//               child: Container(
//                 height: 54,
//                 decoration: BoxDecoration(
//                   color: (key == 'back' || key == 'date' || key == 'rs')
//                       ? accent.withOpacity(0.1)
//                       : Colors.transparent,
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: Center(
//                   child: icon != null
//                       ? Icon(icon, color: accent, size: 22)
//                       : Text(key, style: TextStyle(fontSize: 20, color: t1)),
//                 ),
//               ),
//             ),
//           ),
//         );
//       }).toList(),
//     );
//   }

//   // Utility tiles
//   Widget _dropdownTile(
//     String text,
//     IconData icon,
//     Color surface,
//     Color t1,
//     Color t2,
//     Color accent, {
//     VoidCallback? onTap,
//     bool selected = false,
//   }) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
//         decoration: BoxDecoration(
//           color: surface,
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(color: (selected ? accent : t2).withOpacity(0.3)),
//         ),
//         child: Row(
//           children: [
//             Icon(icon, size: 18, color: selected ? accent : t2),
//             const SizedBox(width: 6),
//             Expanded(
//               child: Text(
//                 text,
//                 style: TextStyle(fontSize: 14, color: selected ? t1 : t2),
//               ),
//             ),
//             Icon(Icons.keyboard_arrow_down, size: 16, color: t2),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _loadingTile(String l, Color surface, Color t2) =>
//       _dropdownTile(l, Icons.hourglass_empty, surface, t2, t2, t2);
//   Widget _errorTile(Color surface, Color t2) =>
//       _dropdownTile('Error', Icons.error, surface, t2, t2, t2);

//   // Helpers
//   String _formatAmount(String a) {
//     if (a.isEmpty) return '0.00';
//     final val = double.tryParse(a);
//     return val == null ? a : val.toStringAsFixed(2);
//   }

//   String _formatDate(DateTime d) => '${d.day}/${d.month}/${d.year}';

//   bool _canSave() =>
//       _selectedAccount != null &&
//       _selectedCategory != null &&
//       _amount.isNotEmpty &&
//       double.tryParse(_amount) != null;

//   void _selectDate() async {
//     final picked = await showDatePicker(
//       context: context,
//       initialDate: _selectedDate,
//       firstDate: DateTime(2020),
//       lastDate: DateTime(2030),
//     );
//     if (picked != null) setState(() => _selectedDate = picked);
//   }

//   void _saveTransaction() async {
//     final tx = TransactionModel(
//       id: const Uuid().v4(),
//       type: _selectedType,
//       date: _selectedDate,
//       title: _commentController.text.isNotEmpty
//           ? _commentController.text
//           : 'Transaction',
//       amount: double.parse(_amount),
//       account: _selectedAccount,
//       category: _selectedCategory,
//       note: _commentController.text.isEmpty ? null : _commentController.text,
//     );
//     await ref.read(transactionsProvider.notifier).addTransaction(tx);
//     if (mounted) Navigator.pop(context);
//   }
// }






import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:expense_project/core/models/transaction_model.dart';
import 'package:expense_project/core/models/account_model.dart';
import 'package:expense_project/core/models/category_model.dart';
import 'package:expense_project/features/accounts/accounts_provider.dart';
import 'package:expense_project/features/categories/categories_provider.dart';
import 'package:expense_project/features/transactions/transactions_provider.dart';

class AddTransactionPage extends ConsumerStatefulWidget {
  const AddTransactionPage({super.key});

  @override
  ConsumerState<AddTransactionPage> createState() => _AddTransactionPageState();
}

class _AddTransactionPageState extends ConsumerState<AddTransactionPage> {
  TransactionType _selectedType = TransactionType.expense;
  String? _selectedAccount;
  String? _selectedCategory;
  DateTime _selectedDate = DateTime.now();
  String _amount = '';
  final TextEditingController _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final surface = isDark ? const Color(0xFF1C1C1E) : Colors.white;
    final text1 = isDark ? Colors.white : Colors.black;
    final text2 = isDark ? Colors.grey[500]! : Colors.grey[700]!;
    final accent = const Color(0xFF007AFF);

    final accountsAsync = ref.watch(accountsProvider);
    final categoriesAsync = _selectedType == TransactionType.expense
        ? ref.watch(expenseCategoriesProvider)
        : ref.watch(incomeCategoriesProvider);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.9,
          minChildSize: 0.5,
          maxChildSize: 0.95,
          builder: (context, scrollController) {
            return Container(
              decoration: BoxDecoration(
                color: surface,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(24),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(isDark ? 0.3 : 0.08),
                    blurRadius: 15,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Handle bar
                  Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(top: 12, bottom: 16),
                    decoration: BoxDecoration(
                      color: text2.withOpacity(0.35),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),

                  // Fixed content - no internal scrolling
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          // Account & Category
                          Row(
                            children: [
                              Expanded(
                                child: _buildAccountDropdown(
                                  accountsAsync,
                                  surface,
                                  text1,
                                  text2,
                                  accent,
                                ),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: _buildCategoryDropdown(
                                  categoriesAsync,
                                  surface,
                                  text1,
                                  text2,
                                  accent,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),

                          // Date + Toggle
                          Row(
                            children: [
                              Expanded(
                                child: _buildDateSelector(
                                  surface,
                                  text1,
                                  text2,
                                ),
                              ),
                              const SizedBox(width: 14),
                              _buildTypeToggle(
                                _selectedType,
                                accent,
                                surface,
                                text1,
                              ),
                            ],
                          ),
                          const SizedBox(height: 18),

                          // Amount
                          Text(
                            '₹${_formatAmount(_amount)}',
                            style: TextStyle(
                              fontSize: 42,
                              fontWeight: FontWeight.w200,
                              color: _selectedType == TransactionType.expense
                                  ? const Color(0xFFFF3B30)
                                  : const Color(0xFF34C759),
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),

                          // Comment
                          _buildCommentField(text2),

                          // Spacer to push keypad to bottom
                          const Spacer(),

                          // Keypad - Fixed layout
                          _buildKeypad(surface, text1, text2, accent),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  // Account Dropdown - Fixed
  Widget _buildAccountDropdown(
    AsyncValue<List<Account>> data,
    Color surface,
    Color t1,
    Color t2,
    Color accent,
  ) {
    return data.when(
      loading: () => _loadingTile('Account', surface, t2),
      error: (_, __) => _errorTile(surface, t2),
      data: (accounts) {
        if (accounts.isEmpty) {
          return _dropdownTile(
            'No Accounts',
            Icons.account_balance,
            surface,
            t2,
            t2,
            t2,
          );
        }

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: accent.withOpacity(0.3)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              dropdownColor: surface,
              value: _selectedAccount,
              hint: Text('Account', style: TextStyle(color: t2)),
              isExpanded: true,
              items: accounts.map((acc) {
                return DropdownMenuItem(
                  value: acc.name,
                  child: Text(acc.name, style: TextStyle(color: t1)),
                );
              }).toList(),
              onChanged: (val) {
                setState(() => _selectedAccount = val);
              },
            ),
          ),
        );
      },
    );
  }

  // Category Dropdown - Fixed
  Widget _buildCategoryDropdown(
    AsyncValue<List<dynamic>> data,
    Color surface,
    Color t1,
    Color t2,
    Color accent,
  ) {
    return data.when(
      loading: () => _loadingTile('Category', surface, t2),
      error: (_, __) => _errorTile(surface, t2),
      data: (categories) {
        if (categories.isEmpty) {
          return _dropdownTile(
            'No Categories',
            Icons.category,
            surface,
            t2,
            t2,
            t2,
          );
        }

        List<String> names = categories.map((c) {
          if (c is ExpenseCategory) return c.name;
          if (c is IncomeCategory) return c.name;
          return c.toString();
        }).toList();

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: accent.withOpacity(0.3)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              dropdownColor: surface,
              value: _selectedCategory,
              hint: Text('Category', style: TextStyle(color: t2)),
              isExpanded: true,
              items: names.map((cat) {
                return DropdownMenuItem(
                  value: cat,
                  child: Text(cat, style: TextStyle(color: t1)),
                );
              }).toList(),
              onChanged: (val) {
                setState(() {
                  _selectedCategory = val;
                  // Reset category when type changes
                  if (_selectedType != TransactionType.expense &&
                      _selectedType != TransactionType.income) {
                    _selectedCategory = null;
                  }
                });
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildDateSelector(Color surface, Color t1, Color t2) {
    return GestureDetector(
      onTap: _selectDate,
      child: _dropdownTile(
        _formatDate(_selectedDate),
        Icons.calendar_today,
        surface,
        t1,
        t2,
        const Color(0xFF007AFF),
        selected: true,
      ),
    );
  }

  Widget _buildTypeToggle(
    TransactionType type,
    Color accent,
    Color surface,
    Color t1,
  ) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: accent.withOpacity(0.25)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _toggleBtn(
            'Expense',
            Icons.arrow_downward,
            type == TransactionType.expense,
            () {
              setState(() {
                _selectedType = TransactionType.expense;
                _selectedCategory = null; // Reset category when switching type
              });
            },
            accent,
            t1,
          ),
          _toggleBtn(
            'Income',
            Icons.arrow_upward,
            type == TransactionType.income,
            () {
              setState(() {
                _selectedType = TransactionType.income;
                _selectedCategory = null; // Reset category when switching type
              });
            },
            accent,
            t1,
          ),
        ],
      ),
    );
  }

  Widget _toggleBtn(
    String text,
    IconData icon,
    bool sel,
    VoidCallback onTap,
    Color accent,
    Color t1,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: sel ? accent.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(icon, size: 14, color: sel ? accent : t1.withOpacity(0.6)),
            const SizedBox(width: 4),
            Text(
              text,
              style: TextStyle(
                fontSize: 12,
                color: sel ? accent : t1.withOpacity(0.6),
                fontWeight: sel ? FontWeight.w500 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCommentField(Color t2) {
    return Container(
      constraints: const BoxConstraints(maxHeight: 100),
      child: TextField(
        controller: _commentController,
        textAlign: TextAlign.center,
        maxLines: null,
        decoration: InputDecoration(
          hintText: 'Add comment...',
          border: InputBorder.none,
          hintStyle: TextStyle(color: t2, fontSize: 14),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        ),
        style: TextStyle(fontSize: 14, color: t2),
      ),
    );
  }

  // Fixed Keypad - Backspace spans rows 1 and 2
  Widget _buildKeypad(Color surface, Color t1, Color t2, Color accent) {
    return Column(
      children: [
        // Row 1 & 2 with merged backspace
        SizedBox(
          height: 116, // 2 rows height
          child: Row(
            children: [
              // Numbers column (1-6)
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    Expanded(
                      child: Row(
                        children: ['1', '2', '3'].map((key) {
                          return Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 2,
                              ),
                              child: _keypadButton(key, t1, accent, null),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: Row(
                        children: ['4', '5', '6'].map((key) {
                          return Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 2,
                              ),
                              child: _keypadButton(key, t1, accent, null),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 4),
              // Backspace button (spans 2 rows)
              SizedBox(
                width: 70,
                child: GestureDetector(
                  onTap: () {
                    if (_amount.isNotEmpty) {
                      setState(
                        () =>
                            _amount = _amount.substring(0, _amount.length - 1),
                      );
                    }
                  },
                  onLongPress: _selectDate,
                  child: Container(
                    height: 116,
                    decoration: BoxDecoration(
                      color: accent.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.backspace_outlined, color: accent, size: 24),
                        const SizedBox(height: 4),
                        Text(
                          'Hold for\ndate',
                          style: TextStyle(
                            fontSize: 10,
                            color: accent.withOpacity(0.7),
                            height: 1.1,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        // Row 3 & 4 with save button
        SizedBox(
          height: 116,
          child: Row(
            children: [
              // Numbers column (7-0)
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    Expanded(
                      child: Row(
                        children: ['7', '8', '9'].map((key) {
                          return Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 2,
                              ),
                              child: _keypadButton(key, t1, accent, null),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 2,
                              ),
                              child: _keypadButton('0', t1, accent, null),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 2,
                              ),
                              child: _keypadButton('.', t1, accent, null),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 2,
                              ),
                              child: GestureDetector(
                                onTap: () => setState(() => _amount = ''),
                                child: Container(
                                  height: 54,
                                  decoration: BoxDecoration(
                                    color: Colors.red.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.clear,
                                      color: Colors.red,
                                      size: 22,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 4),
              // Save button (spans 2 rows)
              SizedBox(
                width: 70,
                child: GestureDetector(
                  onTap: () {
                    if (_canSave()) _saveTransaction();
                  },
                  child: Container(
                    height: 116,
                    decoration: BoxDecoration(
                      color: _canSave() ? accent : accent.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.check_circle, color: Colors.white, size: 32),
                        const SizedBox(height: 4),
                        Text(
                          'Save',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white.withOpacity(0.9),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Helper method for individual keypad buttons
  Widget _keypadButton(String key, Color t1, Color accent, IconData? icon) {
    return GestureDetector(
      onTap: () {
        if (key == '.' && _amount.contains('.')) return;
        setState(() => _amount += key);
      },
      child: Container(
        height: 54,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: icon != null
              ? Icon(icon, color: accent, size: 22)
              : Text(
                  key,
                  style: TextStyle(
                    fontSize: 20,
                    color: t1,
                    fontWeight: FontWeight.w400,
                  ),
                ),
        ),
      ),
    );
  }

  // Utility tiles
  Widget _dropdownTile(
    String text,
    IconData icon,
    Color surface,
    Color t1,
    Color t2,
    Color accent, {
    VoidCallback? onTap,
    bool selected = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: (selected ? accent : t2).withOpacity(0.3)),
        ),
        child: Row(
          children: [
            Icon(icon, size: 18, color: selected ? accent : t2),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 14,
                  color: selected ? t1 : t2,
                  fontWeight: selected ? FontWeight.w500 : FontWeight.normal,
                ),
              ),
            ),
            if (onTap != null)
              Icon(Icons.keyboard_arrow_down, size: 16, color: t2),
          ],
        ),
      ),
    );
  }

  Widget _loadingTile(String l, Color surface, Color t2) =>
      _dropdownTile(l, Icons.hourglass_empty, surface, t2, t2, t2);

  Widget _errorTile(Color surface, Color t2) =>
      _dropdownTile('Error', Icons.error, surface, t2, t2, t2);

  // Helper methods
  String _formatAmount(String a) {
    if (a.isEmpty) return '0.00';
    final val = double.tryParse(a);
    if (val == null) return a;

    // Format with commas for better readability
    final formatter = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    String formatted = val.toStringAsFixed(2);
    return formatted.replaceAllMapped(formatter, (Match m) => '${m[1]},');
  }

  String _formatDate(DateTime d) {
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${d.day} ${months[d.month - 1]} ${d.year}';
  }

  bool _canSave() =>
      _selectedAccount != null &&
      _selectedCategory != null &&
      _amount.isNotEmpty &&
      double.tryParse(_amount) != null &&
      double.parse(_amount) > 0;

  void _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null && mounted) {
      setState(() => _selectedDate = picked);
    }
  }

  void _saveTransaction() async {
    if (!_canSave()) return;

    try {
      final tx = TransactionModel(
        id: const Uuid().v4(),
        type: _selectedType,
        date: _selectedDate,
        title: _commentController.text.isNotEmpty
            ? _commentController.text
            : '${_selectedType.name.capitalize()} Transaction',
        amount: double.parse(_amount),
        account: _selectedAccount,
        category: _selectedCategory,
        note: _commentController.text.isEmpty ? null : _commentController.text,
      );

      await ref.read(transactionsProvider.notifier).addTransaction(tx);

      if (mounted) {
        Navigator.pop(context);
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Transaction saved successfully'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      // Show error message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error saving transaction: $e'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 3),
          ),
        );
      }
    }
  }
}

// Extension to capitalize first letter
extension StringCapitalization on String {
  String capitalize() {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1);
  }
}
