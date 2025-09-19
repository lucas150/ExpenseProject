// // // import 'package:expense_project/core/currency_provider.dart';
// // // import 'package:expense_project/core/models/category_model.dart';
// // // import 'package:expense_project/features/accounts/accounts_provider.dart';
// // // import 'package:expense_project/features/categories/categories_provider.dart';
// // // import 'package:expense_project/features/transactions/transactions_provider.dart';
// // // import 'package:flutter/material.dart';
// // // import 'package:flutter_riverpod/flutter_riverpod.dart';
// // // import '../../../core/models/transaction_model.dart';

// // // class EditTransactionPage extends ConsumerStatefulWidget {
// // //   final TransactionModel transaction;

// // //   const EditTransactionPage({super.key, required this.transaction});

// // //   @override
// // //   ConsumerState<EditTransactionPage> createState() =>
// // //       _EditTransactionPageState();
// // // }

// // // class _EditTransactionPageState extends ConsumerState<EditTransactionPage> {
// // //   late final TextEditingController _titleController;
// // //   late final TextEditingController _amountController;
// // //   late final TextEditingController _noteController;
// // //   late TransactionType _selectedType;
// // //   String? _selectedCategory;
// // //   String? _selectedAccount;
// // //   late DateTime _selectedDate;

// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     _titleController = TextEditingController(text: widget.transaction.title);
// // //     _amountController = TextEditingController(
// // //       text: widget.transaction.amount.toString(),
// // //     );
// // //     _noteController = TextEditingController(
// // //       text: widget.transaction.note ?? '',
// // //     );
// // //     _selectedType = widget.transaction.type;
// // //     _selectedCategory = widget.transaction.category;
// // //     _selectedAccount = widget.transaction.account;
// // //     _selectedDate = widget.transaction.date;
// // //   }

// // //   @override
// // //   void dispose() {
// // //     // Clear focus to prevent text field context issues
// // //     FocusScope.of(context).unfocus();

// // //     // Dispose controllers safely
// // //     _titleController.dispose();
// // //     _amountController.dispose();
// // //     _noteController.dispose();
// // //     super.dispose();
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     final theme = Theme.of(context);
// // //     final currency = ref.watch(currencyProvider);

// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         title: const Text('Edit Transaction'),
// // //         actions: [
// // //           IconButton(
// // //             icon: const Icon(Icons.delete),
// // //             onPressed: _showDeleteConfirmation,
// // //           ),
// // //         ],
// // //       ),
// // //       body: SingleChildScrollView(
// // //         padding: const EdgeInsets.all(16),
// // //         child: Form(
// // //           child: Column(
// // //             crossAxisAlignment: CrossAxisAlignment.start,
// // //             children: [
// // //               // Transaction Type
// // //               Card(
// // //                 child: Padding(
// // //                   padding: const EdgeInsets.all(16),
// // //                   child: Column(
// // //                     crossAxisAlignment: CrossAxisAlignment.start,
// // //                     children: [
// // //                       Text(
// // //                         'Transaction Type',
// // //                         style: theme.textTheme.titleMedium?.copyWith(
// // //                           fontWeight: FontWeight.bold,
// // //                         ),
// // //                       ),
// // //                       const SizedBox(height: 12),
// // //                       Row(
// // //                         children: TransactionType.values.map((type) {
// // //                           return Expanded(
// // //                             child: Padding(
// // //                               padding: const EdgeInsets.only(right: 8),
// // //                               child: ChoiceChip(
// // //                                 label: Text(_getTypeLabel(type)),
// // //                                 selected: _selectedType == type,
// // //                                 onSelected: (selected) {
// // //                                   if (selected) {
// // //                                     setState(() {
// // //                                       _selectedType = type;
// // //                                       _selectedCategory =
// // //                                           null; // Reset category when type changes
// // //                                     });
// // //                                   }
// // //                                 },
// // //                               ),
// // //                             ),
// // //                           );
// // //                         }).toList(),
// // //                       ),
// // //                     ],
// // //                   ),
// // //                 ),
// // //               ),

// // //               const SizedBox(height: 16),

// // //               // Title and Amount
// // //               Card(
// // //                 child: Padding(
// // //                   padding: const EdgeInsets.all(16),
// // //                   child: Column(
// // //                     crossAxisAlignment: CrossAxisAlignment.start,
// // //                     children: [
// // //                       Text(
// // //                         'Transaction Details',
// // //                         style: theme.textTheme.titleMedium?.copyWith(
// // //                           fontWeight: FontWeight.bold,
// // //                         ),
// // //                       ),
// // //                       const SizedBox(height: 12),
// // //                       TextFormField(
// // //                         controller: _titleController,
// // //                         decoration: const InputDecoration(
// // //                           labelText: 'Title *',
// // //                           border: OutlineInputBorder(),
// // //                         ),
// // //                         validator: (value) =>
// // //                             value?.isEmpty == true ? 'Title is required' : null,
// // //                       ),
// // //                       const SizedBox(height: 16),
// // //                       TextFormField(
// // //                         controller: _amountController,
// // //                         keyboardType: TextInputType.number,
// // //                         decoration: InputDecoration(
// // //                           labelText: 'Amount *',
// // //                           prefixText: '${currency.symbol} ',
// // //                           border: const OutlineInputBorder(),
// // //                         ),
// // //                         validator: (value) {
// // //                           if (value?.isEmpty == true) {
// // //                             return 'Amount is required';
// // //                           }
// // //                           if (double.tryParse(value!) == null) {
// // //                             return 'Enter a valid amount';
// // //                           }
// // //                           return null;
// // //                         },
// // //                       ),
// // //                     ],
// // //                   ),
// // //                 ),
// // //               ),

// // //               const SizedBox(height: 16),

// // //               // Category Selection
// // //               _buildCategorySelector(),

// // //               const SizedBox(height: 16),

// // //               // Account Selection
// // //               _buildAccountSelector(),

// // //               const SizedBox(height: 16),

// // //               // Date Selection
// // //               Card(
// // //                 child: Padding(
// // //                   padding: const EdgeInsets.all(16),
// // //                   child: Column(
// // //                     crossAxisAlignment: CrossAxisAlignment.start,
// // //                     children: [
// // //                       Text(
// // //                         'Date',
// // //                         style: theme.textTheme.titleMedium?.copyWith(
// // //                           fontWeight: FontWeight.bold,
// // //                         ),
// // //                       ),
// // //                       const SizedBox(height: 12),
// // //                       InkWell(
// // //                         onTap: _selectDate,
// // //                         child: InputDecorator(
// // //                           decoration: const InputDecoration(
// // //                             border: OutlineInputBorder(),
// // //                           ),
// // //                           child: Row(
// // //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // //                             children: [
// // //                               Text(_formatDate(_selectedDate)),
// // //                               const Icon(Icons.calendar_today),
// // //                             ],
// // //                           ),
// // //                         ),
// // //                       ),
// // //                     ],
// // //                   ),
// // //                 ),
// // //               ),

// // //               const SizedBox(height: 16),

// // //               // Note
// // //               Card(
// // //                 child: Padding(
// // //                   padding: const EdgeInsets.all(16),
// // //                   child: Column(
// // //                     crossAxisAlignment: CrossAxisAlignment.start,
// // //                     children: [
// // //                       Text(
// // //                         'Note (Optional)',
// // //                         style: theme.textTheme.titleMedium?.copyWith(
// // //                           fontWeight: FontWeight.bold,
// // //                         ),
// // //                       ),
// // //                       const SizedBox(height: 12),
// // //                       TextFormField(
// // //                         controller: _noteController,
// // //                         maxLines: 3,
// // //                         decoration: const InputDecoration(
// // //                           border: OutlineInputBorder(),
// // //                           hintText: 'Add a note...',
// // //                         ),
// // //                       ),
// // //                     ],
// // //                   ),
// // //                 ),
// // //               ),

// // //               const SizedBox(height: 24),

// // //               // Save Button
// // //               SizedBox(
// // //                 width: double.infinity,
// // //                 child: ElevatedButton(
// // //                   onPressed: _saveTransaction,
// // //                   style: ElevatedButton.styleFrom(
// // //                     padding: const EdgeInsets.symmetric(vertical: 16),
// // //                   ),
// // //                   child: const Text(
// // //                     'Save Changes',
// // //                     style: TextStyle(fontSize: 16),
// // //                   ),
// // //                 ),
// // //               ),
// // //             ],
// // //           ),
// // //         ),
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildCategorySelector() {
// // //     final categories = _selectedType == TransactionType.expense
// // //         ? ref.watch(expenseCategoriesProvider)
// // //         : ref.watch(incomeCategoriesProvider);

// // //     return Card(
// // //       child: Padding(
// // //         padding: const EdgeInsets.all(16),
// // //         child: Column(
// // //           crossAxisAlignment: CrossAxisAlignment.start,
// // //           children: [
// // //             Row(
// // //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // //               children: [
// // //                 Text(
// // //                   'Category',
// // //                   style: Theme.of(context).textTheme.titleMedium?.copyWith(
// // //                     fontWeight: FontWeight.bold,
// // //                   ),
// // //                 ),
// // //                 TextButton(
// // //                   onPressed: () =>
// // //                       Navigator.of(context).pushNamed('/categories'),
// // //                   child: const Text('Manage'),
// // //                 ),
// // //               ],
// // //             ),
// // //             const SizedBox(height: 12),
// // //             categories.when(
// // //               data: (categoryList) => DropdownButtonFormField<String>(
// // //                 value: _selectedCategory,
// // //                 decoration: const InputDecoration(
// // //                   border: OutlineInputBorder(),
// // //                   hintText: 'Select a category',
// // //                 ),
// // //                 items: [
// // //                   const DropdownMenuItem<String>(
// // //                     value: null,
// // //                     child: Text('No Category'),
// // //                   ),
// // //                   ...categoryList.map(
// // //                     (category) => DropdownMenuItem(
// // //                       // value: category.name,
// // //                       // child: Text(category.name),
// // //                       value: (category as ExpenseCategory).name,
// // //                       child: Text((category).name),
// // //                     ),
// // //                   ),
// // //                 ],
// // //                 onChanged: (value) => setState(() => _selectedCategory = value),
// // //               ),
// // //               loading: () => const CircularProgressIndicator(),
// // //               error: (_, __) => const Text('Error loading categories'),
// // //             ),
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildAccountSelector() {
// // //     final accountsAsync = ref.watch(accountsProvider);

// // //     return Card(
// // //       child: Padding(
// // //         padding: const EdgeInsets.all(16),
// // //         child: Column(
// // //           crossAxisAlignment: CrossAxisAlignment.start,
// // //           children: [
// // //             Text(
// // //               'Account (Optional)',
// // //               style: Theme.of(
// // //                 context,
// // //               ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
// // //             ),
// // //             const SizedBox(height: 12),
// // //             accountsAsync.when(
// // //               data: (accounts) => DropdownButtonFormField<String>(
// // //                 value: _selectedAccount,
// // //                 decoration: const InputDecoration(
// // //                   border: OutlineInputBorder(),
// // //                   hintText: 'Select an account',
// // //                 ),
// // //                 items: [
// // //                   const DropdownMenuItem<String>(
// // //                     value: null,
// // //                     child: Text('No Account (General)'),
// // //                   ),
// // //                   ...accounts.map(
// // //                     (account) => DropdownMenuItem(
// // //                       value: account.id,
// // //                       child: Text(account.name),
// // //                     ),
// // //                   ),
// // //                 ],
// // //                 onChanged: (value) => setState(() => _selectedAccount = value),
// // //               ),
// // //               loading: () => const CircularProgressIndicator(),
// // //               error: (_, __) => const Text('Error loading accounts'),
// // //             ),
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }

// // //   Future<void> _selectDate() async {
// // //     if (!mounted) return;

// // //     final date = await showDatePicker(
// // //       context: context,
// // //       initialDate: _selectedDate,
// // //       firstDate: DateTime(2020),
// // //       lastDate: DateTime.now(),
// // //     );
// // //     if (date != null && mounted) {
// // //       setState(() => _selectedDate = date);
// // //     }
// // //   }

// // //   String _getTypeLabel(TransactionType type) {
// // //     switch (type) {
// // //       case TransactionType.income:
// // //         return 'Income';
// // //       case TransactionType.expense:
// // //         return 'Expense';
// // //     }
// // //   }

// // //   String _formatDate(DateTime date) {
// // //     return '${date.day}/${date.month}/${date.year}';
// // //   }

// // //   void _saveTransaction() async {
// // //     // Unfocus text fields before navigation to prevent disposal issues
// // //     FocusScope.of(context).unfocus();

// // //     final updatedTransaction = widget.transaction.copyWith(
// // //       type: _selectedType,
// // //       title: _titleController.text,
// // //       amount: double.tryParse(_amountController.text) ?? 0,
// // //       category: _selectedCategory,
// // //       account: _selectedAccount,
// // //       date: _selectedDate,
// // //       note: _noteController.text.isEmpty ? null : _noteController.text,
// // //     );

// // //     try {
// // //       await ref
// // //           .read(transactionsProvider.notifier)
// // //           .updateTransaction(updatedTransaction);

// // //       if (mounted) {
// // //         ScaffoldMessenger.of(context).showSnackBar(
// // //           const SnackBar(content: Text('Transaction updated successfully!')),
// // //         );
// // //         // Use a safer navigation approach
// // //         WidgetsBinding.instance.addPostFrameCallback((_) {
// // //           if (mounted) {
// // //             Navigator.of(context).pop();
// // //           }
// // //         });
// // //       }
// // //     } catch (e) {
// // //       if (mounted) {
// // //         ScaffoldMessenger.of(context).showSnackBar(
// // //           SnackBar(content: Text('Error updating transaction: $e')),
// // //         );
// // //       }
// // //     }
// // //   }

// // //   void _showDeleteConfirmation() {
// // //     if (!mounted) return;

// // //     showModalBottomSheet(
// // //       context: context,
// // //       builder: (context) => Container(
// // //         padding: const EdgeInsets.all(24),
// // //         child: Column(
// // //           mainAxisSize: MainAxisSize.min,
// // //           children: [
// // //             const Icon(Icons.warning, color: Colors.orange, size: 48),
// // //             const SizedBox(height: 16),
// // //             const Text(
// // //               'Delete Transaction',
// // //               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
// // //             ),
// // //             const SizedBox(height: 8),
// // //             const Text(
// // //               'Are you sure you want to delete this transaction? This action cannot be undone.',
// // //               textAlign: TextAlign.center,
// // //             ),
// // //             const SizedBox(height: 24),
// // //             Row(
// // //               children: [
// // //                 Expanded(
// // //                   child: OutlinedButton(
// // //                     onPressed: () => Navigator.of(context).pop(),
// // //                     child: const Text('Cancel'),
// // //                   ),
// // //                 ),
// // //                 const SizedBox(width: 16),
// // //                 Expanded(
// // //                   child: ElevatedButton(
// // //                     onPressed: _deleteTransaction,
// // //                     style: ElevatedButton.styleFrom(
// // //                       backgroundColor: Colors.red,
// // //                       foregroundColor: Colors.white,
// // //                     ),
// // //                     child: const Text('Delete'),
// // //                   ),
// // //                 ),
// // //               ],
// // //             ),
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }

// // //   void _deleteTransaction() async {
// // //     // Unfocus text fields before navigation to prevent disposal issues
// // //     FocusScope.of(context).unfocus();

// // //     try {
// // //       await ref
// // //           .read(transactionsProvider.notifier)
// // //           .deleteTransaction(widget.transaction.id);

// // //       if (mounted) {
// // //         // Use safer navigation with post frame callback
// // //         WidgetsBinding.instance.addPostFrameCallback((_) {
// // //           if (mounted) {
// // //             Navigator.of(context).pop(); // Close bottom sheet
// // //             Navigator.of(context).pop(); // Close edit page
// // //             ScaffoldMessenger.of(context).showSnackBar(
// // //               const SnackBar(
// // //                 content: Text('Transaction deleted successfully!'),
// // //               ),
// // //             );
// // //           }
// // //         });
// // //       }
// // //     } catch (e) {
// // //       if (mounted) {
// // //         WidgetsBinding.instance.addPostFrameCallback((_) {
// // //           if (mounted) {
// // //             Navigator.of(context).pop(); // Close bottom sheet
// // //             ScaffoldMessenger.of(context).showSnackBar(
// // //               SnackBar(content: Text('Error deleting transaction: $e')),
// // //             );
// // //           }
// // //         });
// // //       }
// // //     }
// // //   }
// // // }

// // import 'package:expense_project/core/currency_provider.dart';
// // import 'package:expense_project/core/models/category_model.dart';
// // import 'package:expense_project/features/accounts/accounts_provider.dart';
// // import 'package:expense_project/features/categories/categories_provider.dart';
// // import 'package:expense_project/features/transactions/transactions_provider.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_riverpod/flutter_riverpod.dart';
// // import '../../../core/models/transaction_model.dart';

// // class EditTransactionPage extends ConsumerStatefulWidget {
// //   final TransactionModel transaction;

// //   const EditTransactionPage({super.key, required this.transaction});

// //   @override
// //   ConsumerState<EditTransactionPage> createState() =>
// //       _EditTransactionPageState();
// // }

// // class _EditTransactionPageState extends ConsumerState<EditTransactionPage> {
// //   late final TextEditingController _titleController;
// //   late final TextEditingController _amountController;
// //   late final TextEditingController _noteController;
// //   late TransactionType _selectedType;
// //   String? _selectedCategory;
// //   String? _selectedAccount;
// //   late DateTime _selectedDate;
// //   bool _isProcessing = false; // Add processing state

// //   @override
// //   void initState() {
// //     super.initState();
// //     _titleController = TextEditingController(text: widget.transaction.title);
// //     _amountController = TextEditingController(
// //       text: widget.transaction.amount.toString(),
// //     );
// //     _noteController = TextEditingController(
// //       text: widget.transaction.note ?? '',
// //     );
// //     _selectedType = widget.transaction.type;
// //     _selectedCategory = widget.transaction.category;
// //     _selectedAccount = widget.transaction.account;
// //     _selectedDate = widget.transaction.date;
// //   }

// //   @override
// //   void dispose() {
// //     // Clear focus to prevent text field context issues
// //     if (mounted) {
// //       FocusScope.of(context).unfocus();
// //     }

// //     // Dispose controllers safely
// //     _titleController.dispose();
// //     _amountController.dispose();
// //     _noteController.dispose();
// //     super.dispose();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     final theme = Theme.of(context);
// //     final currency = ref.watch(currencyProvider);

// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('Edit Transaction'),
// //         actions: [
// //           IconButton(
// //             icon: const Icon(Icons.delete),
// //             onPressed: _isProcessing ? null : _showDeleteConfirmation,
// //           ),
// //         ],
// //       ),
// //       body: SingleChildScrollView(
// //         padding: const EdgeInsets.all(16),
// //         child: Form(
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               // Transaction Type
// //               Card(
// //                 child: Padding(
// //                   padding: const EdgeInsets.all(16),
// //                   child: Column(
// //                     crossAxisAlignment: CrossAxisAlignment.start,
// //                     children: [
// //                       Text(
// //                         'Transaction Type',
// //                         style: theme.textTheme.titleMedium?.copyWith(
// //                           fontWeight: FontWeight.bold,
// //                         ),
// //                       ),
// //                       const SizedBox(height: 12),
// //                       Row(
// //                         children: TransactionType.values.map((type) {
// //                           return Expanded(
// //                             child: Padding(
// //                               padding: const EdgeInsets.only(right: 8),
// //                               child: ChoiceChip(
// //                                 label: Text(_getTypeLabel(type)),
// //                                 selected: _selectedType == type,
// //                                 onSelected: _isProcessing
// //                                     ? null
// //                                     : (selected) {
// //                                         if (selected) {
// //                                           setState(() {
// //                                             _selectedType = type;
// //                                             _selectedCategory =
// //                                                 null; // Reset category when type changes
// //                                           });
// //                                         }
// //                                       },
// //                               ),
// //                             ),
// //                           );
// //                         }).toList(),
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //               ),

// //               const SizedBox(height: 16),

// //               // Title and Amount
// //               Card(
// //                 child: Padding(
// //                   padding: const EdgeInsets.all(16),
// //                   child: Column(
// //                     crossAxisAlignment: CrossAxisAlignment.start,
// //                     children: [
// //                       Text(
// //                         'Transaction Details',
// //                         style: theme.textTheme.titleMedium?.copyWith(
// //                           fontWeight: FontWeight.bold,
// //                         ),
// //                       ),
// //                       const SizedBox(height: 12),
// //                       TextFormField(
// //                         controller: _titleController,
// //                         enabled: !_isProcessing,
// //                         decoration: const InputDecoration(
// //                           labelText: 'Title *',
// //                           border: OutlineInputBorder(),
// //                         ),
// //                         validator: (value) =>
// //                             value?.isEmpty == true ? 'Title is required' : null,
// //                       ),
// //                       const SizedBox(height: 16),
// //                       TextFormField(
// //                         controller: _amountController,
// //                         enabled: !_isProcessing,
// //                         keyboardType: TextInputType.number,
// //                         decoration: InputDecoration(
// //                           labelText: 'Amount *',
// //                           prefixText: '${currency.symbol} ',
// //                           border: const OutlineInputBorder(),
// //                         ),
// //                         validator: (value) {
// //                           if (value?.isEmpty == true) {
// //                             return 'Amount is required';
// //                           }
// //                           if (double.tryParse(value!) == null) {
// //                             return 'Enter a valid amount';
// //                           }
// //                           return null;
// //                         },
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //               ),

// //               const SizedBox(height: 16),

// //               // Category Selection
// //               _buildCategorySelector(),

// //               const SizedBox(height: 16),

// //               // Account Selection
// //               _buildAccountSelector(),

// //               const SizedBox(height: 16),

// //               // Date Selection
// //               Card(
// //                 child: Padding(
// //                   padding: const EdgeInsets.all(16),
// //                   child: Column(
// //                     crossAxisAlignment: CrossAxisAlignment.start,
// //                     children: [
// //                       Text(
// //                         'Date',
// //                         style: theme.textTheme.titleMedium?.copyWith(
// //                           fontWeight: FontWeight.bold,
// //                         ),
// //                       ),
// //                       const SizedBox(height: 12),
// //                       InkWell(
// //                         onTap: _isProcessing ? null : _selectDate,
// //                         child: InputDecorator(
// //                           decoration: const InputDecoration(
// //                             border: OutlineInputBorder(),
// //                           ),
// //                           child: Row(
// //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                             children: [
// //                               Text(_formatDate(_selectedDate)),
// //                               const Icon(Icons.calendar_today),
// //                             ],
// //                           ),
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //               ),

// //               const SizedBox(height: 16),

// //               // Note
// //               Card(
// //                 child: Padding(
// //                   padding: const EdgeInsets.all(16),
// //                   child: Column(
// //                     crossAxisAlignment: CrossAxisAlignment.start,
// //                     children: [
// //                       Text(
// //                         'Note (Optional)',
// //                         style: theme.textTheme.titleMedium?.copyWith(
// //                           fontWeight: FontWeight.bold,
// //                         ),
// //                       ),
// //                       const SizedBox(height: 12),
// //                       TextFormField(
// //                         controller: _noteController,
// //                         enabled: !_isProcessing,
// //                         maxLines: 3,
// //                         decoration: const InputDecoration(
// //                           border: OutlineInputBorder(),
// //                           hintText: 'Add a note...',
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //               ),

// //               const SizedBox(height: 24),

// //               // Save Button
// //               SizedBox(
// //                 width: double.infinity,
// //                 child: ElevatedButton(
// //                   onPressed: _isProcessing ? null : _saveTransaction,
// //                   style: ElevatedButton.styleFrom(
// //                     padding: const EdgeInsets.symmetric(vertical: 16),
// //                   ),
// //                   child: _isProcessing
// //                       ? const Row(
// //                           mainAxisAlignment: MainAxisAlignment.center,
// //                           children: [
// //                             SizedBox(
// //                               width: 16,
// //                               height: 16,
// //                               child: CircularProgressIndicator(strokeWidth: 2),
// //                             ),
// //                             SizedBox(width: 8),
// //                             Text('Saving...'),
// //                           ],
// //                         )
// //                       : const Text(
// //                           'Save Changes',
// //                           style: TextStyle(fontSize: 16),
// //                         ),
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildCategorySelector() {
// //     final categories = _selectedType == TransactionType.expense
// //         ? ref.watch(expenseCategoriesProvider)
// //         : ref.watch(incomeCategoriesProvider);

// //     return Card(
// //       child: Padding(
// //         padding: const EdgeInsets.all(16),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             Row(
// //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //               children: [
// //                 Text(
// //                   'Category',
// //                   style: Theme.of(context).textTheme.titleMedium?.copyWith(
// //                     fontWeight: FontWeight.bold,
// //                   ),
// //                 ),
// //                 TextButton(
// //                   onPressed: _isProcessing
// //                       ? null
// //                       : () {
// //                           if (mounted) {
// //                             Navigator.of(context).pushNamed('/categories');
// //                           }
// //                         },
// //                   child: const Text('Manage'),
// //                 ),
// //               ],
// //             ),
// //             const SizedBox(height: 12),
// //             categories.when(
// //               data: (categoryList) => DropdownButtonFormField<String>(
// //                 value: _selectedCategory,
// //                 decoration: const InputDecoration(
// //                   border: OutlineInputBorder(),
// //                   hintText: 'Select a category',
// //                 ),
// //                 items: [
// //                   const DropdownMenuItem<String>(
// //                     value: null,
// //                     child: Text('No Category'),
// //                   ),
// //                   ...categoryList.map(
// //                     (category) => DropdownMenuItem(
// //                       value: (category as ExpenseCategory).name,
// //                       child: Text((category).name),
// //                     ),
// //                   ),
// //                 ],
// //                 onChanged: _isProcessing
// //                     ? null
// //                     : (value) => setState(() => _selectedCategory = value),
// //               ),
// //               loading: () => const CircularProgressIndicator(),
// //               error: (_, __) => const Text('Error loading categories'),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildAccountSelector() {
// //     final accountsAsync = ref.watch(accountsProvider);

// //     return Card(
// //       child: Padding(
// //         padding: const EdgeInsets.all(16),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             Text(
// //               'Account (Optional)',
// //               style: Theme.of(
// //                 context,
// //               ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
// //             ),
// //             const SizedBox(height: 12),
// //             accountsAsync.when(
// //               data: (accounts) => DropdownButtonFormField<String>(
// //                 value: _selectedAccount,
// //                 decoration: const InputDecoration(
// //                   border: OutlineInputBorder(),
// //                   hintText: 'Select an account',
// //                 ),
// //                 items: [
// //                   const DropdownMenuItem<String>(
// //                     value: null,
// //                     child: Text('No Account (General)'),
// //                   ),
// //                   ...accounts.map(
// //                     (account) => DropdownMenuItem(
// //                       value: account.id,
// //                       child: Text(account.name),
// //                     ),
// //                   ),
// //                 ],
// //                 onChanged: _isProcessing
// //                     ? null
// //                     : (value) => setState(() => _selectedAccount = value),
// //               ),
// //               loading: () => const CircularProgressIndicator(),
// //               error: (_, __) => const Text('Error loading accounts'),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   Future<void> _selectDate() async {
// //     if (!mounted || _isProcessing) return;

// //     final date = await showDatePicker(
// //       context: context,
// //       initialDate: _selectedDate,
// //       firstDate: DateTime(2020),
// //       lastDate: DateTime.now(),
// //     );
// //     if (date != null && mounted && !_isProcessing) {
// //       setState(() => _selectedDate = date);
// //     }
// //   }

// //   String _getTypeLabel(TransactionType type) {
// //     switch (type) {
// //       case TransactionType.income:
// //         return 'Income';
// //       case TransactionType.expense:
// //         return 'Expense';
// //     }
// //   }

// //   String _formatDate(DateTime date) {
// //     return '${date.day}/${date.month}/${date.year}';
// //   }

// //   void _saveTransaction() async {
// //     if (_isProcessing || !mounted) return;

// //     setState(() => _isProcessing = true);

// //     // Unfocus text fields before navigation to prevent disposal issues
// //     FocusScope.of(context).unfocus();

// //     final updatedTransaction = widget.transaction.copyWith(
// //       type: _selectedType,
// //       title: _titleController.text,
// //       amount: double.tryParse(_amountController.text) ?? 0,
// //       category: _selectedCategory,
// //       account: _selectedAccount,
// //       date: _selectedDate,
// //       note: _noteController.text.isEmpty ? null : _noteController.text,
// //     );

// //     try {
// //       await ref
// //           .read(transactionsProvider.notifier)
// //           .updateTransaction(updatedTransaction);

// //       if (mounted) {
// //         // Show success message first
// //         ScaffoldMessenger.of(context).showSnackBar(
// //           const SnackBar(content: Text('Transaction updated successfully!')),
// //         );

// //         // Then navigate back safely
// //         Navigator.of(context).pop();
// //       }
// //     } catch (e) {
// //       if (mounted) {
// //         setState(() => _isProcessing = false);
// //         ScaffoldMessenger.of(context).showSnackBar(
// //           SnackBar(content: Text('Error updating transaction: $e')),
// //         );
// //       }
// //     }
// //   }

// //   void _showDeleteConfirmation() {
// //     if (!mounted || _isProcessing) return;

// //     showDialog(
// //       context: context,
// //       builder: (dialogContext) => AlertDialog(
// //         title: const Text('Delete Transaction'),
// //         content: const Text(
// //           'Are you sure you want to delete this transaction? This action cannot be undone.',
// //         ),
// //         actions: [
// //           TextButton(
// //             onPressed: () => Navigator.of(dialogContext).pop(),
// //             child: const Text('Cancel'),
// //           ),
// //           TextButton(
// //             onPressed: () {
// //               Navigator.of(dialogContext).pop();
// //               _deleteTransaction();
// //             },
// //             style: TextButton.styleFrom(foregroundColor: Colors.red),
// //             child: const Text('Delete'),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   void _deleteTransaction() async {
// //     if (_isProcessing || !mounted) return;

// //     setState(() => _isProcessing = true);

// //     // Unfocus text fields before navigation to prevent disposal issues
// //     FocusScope.of(context).unfocus();

// //     try {
// //       await ref
// //           .read(transactionsProvider.notifier)
// //           .deleteTransaction(widget.transaction.id);

// //       if (mounted) {
// //         // Show success message
// //         ScaffoldMessenger.of(context).showSnackBar(
// //           const SnackBar(content: Text('Transaction deleted successfully!')),
// //         );

// //         // Navigate back safely
// //         Navigator.of(context).pop();
// //       }
// //     } catch (e) {
// //       if (mounted) {
// //         setState(() => _isProcessing = false);
// //         ScaffoldMessenger.of(context).showSnackBar(
// //           SnackBar(content: Text('Error deleting transaction: $e')),
// //         );
// //       }
// //     }
// //   }
// // }

// import 'package:expense_project/core/currency_provider.dart';
// import 'package:expense_project/core/models/category_model.dart';
// import 'package:expense_project/features/accounts/accounts_provider.dart';
// import 'package:expense_project/features/categories/categories_provider.dart';
// import 'package:expense_project/features/transactions/transactions_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart'; // Add this import
// import '../../../core/models/transaction_model.dart';

// class EditTransactionPage extends ConsumerStatefulWidget {
//   final TransactionModel transaction;

//   const EditTransactionPage({super.key, required this.transaction});

//   @override
//   ConsumerState<EditTransactionPage> createState() =>
//       _EditTransactionPageState();
// }

// class _EditTransactionPageState extends ConsumerState<EditTransactionPage> {
//   late final TextEditingController _titleController;
//   late final TextEditingController _amountController;
//   late final TextEditingController _noteController;
//   late TransactionType _selectedType;
//   String? _selectedCategory;
//   String? _selectedAccount;
//   late DateTime _selectedDate;
//   bool _isProcessing = false;
//   bool _isDisposed = false; // Add disposal tracking

//   @override
//   void initState() {
//     super.initState();
//     _titleController = TextEditingController(text: widget.transaction.title);
//     _amountController = TextEditingController(
//       text: widget.transaction.amount.toString(),
//     );
//     _noteController = TextEditingController(
//       text: widget.transaction.note ?? '',
//     );
//     _selectedType = widget.transaction.type;
//     _selectedCategory = widget.transaction.category;
//     _selectedAccount = widget.transaction.account;
//     _selectedDate = widget.transaction.date;
//   }

//   @override
//   void dispose() {
//     _isDisposed = true;
//     _isProcessing = false;

//     // Safe disposal of controllers
//     try {
//       _titleController.dispose();
//       _amountController.dispose();
//       _noteController.dispose();
//     } catch (e) {
//       // Ignore disposal errors
//     }

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
//             onPressed: _isProcessing ? null : _showDeleteConfirmation,
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
//                         style: theme.textTheme.titleMedium?.copyWith(
//                           fontWeight: FontWeight.bold,
//                         ),
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
//                                 onSelected: _isProcessing
//                                     ? null
//                                     : (selected) {
//                                         if (selected) {
//                                           setState(() {
//                                             _selectedType = type;
//                                             _selectedCategory =
//                                                 null; // Reset category when type changes
//                                           });
//                                         }
//                                       },
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
//                         style: theme.textTheme.titleMedium?.copyWith(
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       const SizedBox(height: 12),
//                       TextFormField(
//                         controller: _titleController,
//                         enabled: !_isProcessing,
//                         decoration: const InputDecoration(
//                           labelText: 'Title *',
//                           border: OutlineInputBorder(),
//                         ),
//                         validator: (value) =>
//                             value?.isEmpty == true ? 'Title is required' : null,
//                       ),
//                       const SizedBox(height: 16),
//                       TextFormField(
//                         controller: _amountController,
//                         enabled: !_isProcessing,
//                         keyboardType: TextInputType.number,
//                         decoration: InputDecoration(
//                           labelText: 'Amount *',
//                           prefixText: '${currency.symbol} ',
//                           border: const OutlineInputBorder(),
//                         ),
//                         validator: (value) {
//                           if (value?.isEmpty == true) {
//                             return 'Amount is required';
//                           }
//                           if (double.tryParse(value!) == null) {
//                             return 'Enter a valid amount';
//                           }
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
//                         style: theme.textTheme.titleMedium?.copyWith(
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       const SizedBox(height: 12),
//                       InkWell(
//                         onTap: _isProcessing ? null : _selectDate,
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
//                         style: theme.textTheme.titleMedium?.copyWith(
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       const SizedBox(height: 12),
//                       TextFormField(
//                         controller: _noteController,
//                         enabled: !_isProcessing,
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
//                   onPressed: _isProcessing ? null : _saveTransaction,
//                   style: ElevatedButton.styleFrom(
//                     padding: const EdgeInsets.symmetric(vertical: 16),
//                   ),
//                   child: _isProcessing
//                       ? const Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             SizedBox(
//                               width: 16,
//                               height: 16,
//                               child: CircularProgressIndicator(strokeWidth: 2),
//                             ),
//                             SizedBox(width: 8),
//                             Text('Saving...'),
//                           ],
//                         )
//                       : const Text(
//                           'Save Changes',
//                           style: TextStyle(fontSize: 16),
//                         ),
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
//                   style: Theme.of(context).textTheme.titleMedium?.copyWith(
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 TextButton(
//                   onPressed: _isProcessing
//                       ? null
//                       : () {
//                           if (mounted) {
//                             try {
//                               context.pushNamed('/categories');
//                             } catch (e) {
//                               Navigator.of(context).pushNamed('/categories');
//                             }
//                           }
//                         },
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
//                   ...categoryList.map(
//                     (category) => DropdownMenuItem(
//                       value: (category as ExpenseCategory).name,
//                       child: Text((category).name),
//                     ),
//                   ),
//                 ],
//                 onChanged: _isProcessing
//                     ? null
//                     : (value) => setState(() => _selectedCategory = value),
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
//               style: Theme.of(
//                 context,
//               ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
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
//                   ...accounts.map(
//                     (account) => DropdownMenuItem(
//                       value: account.id,
//                       child: Text(account.name),
//                     ),
//                   ),
//                 ],
//                 onChanged: _isProcessing
//                     ? null
//                     : (value) => setState(() => _selectedAccount = value),
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
//     if (!mounted || _isProcessing) return;

//     final date = await showDatePicker(
//       context: context,
//       initialDate: _selectedDate,
//       firstDate: DateTime(2020),
//       lastDate: DateTime.now(),
//     );
//     if (date != null && mounted && !_isProcessing) {
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
//     if (_isProcessing || _isDisposed || !mounted) return;

//     setState(() => _isProcessing = true);

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
//       await ref
//           .read(transactionsProvider.notifier)
//           .updateTransaction(updatedTransaction);

//       if (!_isDisposed && mounted) {
//         // Use GoRouter's context.pop() instead of Navigator
//         _showSuccessAndExit('Transaction updated successfully!');
//       }
//     } catch (e) {
//       if (!_isDisposed && mounted) {
//         setState(() => _isProcessing = false);
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Error updating transaction: $e')),
//         );
//       }
//     }
//   }

//   void _showSuccessAndExit(String message) {
//     if (_isDisposed || !mounted) return;

//     // Show snackbar and exit safely
//     ScaffoldMessenger.of(
//       context,
//     ).showSnackBar(SnackBar(content: Text(message)));

//     // Use GoRouter's pop method which is safer with disposal
//     try {
//       context.pop();
//     } catch (e) {
//       // Fallback to Navigator if context.pop fails
//       try {
//         Navigator.of(context).pop();
//       } catch (navError) {
//         // If all else fails, just mark as not processing
//         if (mounted) {
//           setState(() => _isProcessing = false);
//         }
//       }
//     }
//   }

//   void _showDeleteConfirmation() {
//     if (!mounted || _isProcessing) return;

//     showDialog(
//       context: context,
//       builder: (dialogContext) => AlertDialog(
//         title: const Text('Delete Transaction'),
//         content: const Text(
//           'Are you sure you want to delete this transaction? This action cannot be undone.',
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.of(dialogContext).pop(),
//             child: const Text('Cancel'),
//           ),
//           TextButton(
//             onPressed: () {
//               Navigator.of(dialogContext).pop();
//               _deleteTransaction();
//             },
//             style: TextButton.styleFrom(foregroundColor: Colors.red),
//             child: const Text('Delete'),
//           ),
//         ],
//       ),
//     );
//   }

//   void _deleteTransaction() async {
//     if (_isProcessing || _isDisposed || !mounted) return;

//     setState(() => _isProcessing = true);

//     try {
//       await ref
//           .read(transactionsProvider.notifier)
//           .deleteTransaction(widget.transaction.id);

//       if (!_isDisposed && mounted) {
//         _showSuccessAndExit('Transaction deleted successfully!');
//       }
//     } catch (e) {
//       if (!_isDisposed && mounted) {
//         setState(() => _isProcessing = false);
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Error deleting transaction: $e')),
//         );
//       }
//     }
//   }
// }

import 'package:expense_project/core/currency_provider.dart';
import 'package:expense_project/core/models/category_model.dart';
import 'package:expense_project/features/accounts/accounts_provider.dart';
import 'package:expense_project/features/categories/categories_provider.dart';
import 'package:expense_project/features/transactions/transactions_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
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
  bool _isProcessing = false;

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
    final isDark = theme.brightness == Brightness.dark;

    // Color Theory Consistent with Dashboard
    final bg = isDark ? const Color(0xFF000000) : const Color(0xFFFFFFFF);
    final surface = isDark ? const Color(0xFF111111) : const Color(0xFFFBFBFB);
    final cardSurface = isDark ? const Color(0xFF1C1C1E) : Colors.white;
    final textMain = isDark ? Colors.white : Colors.black;
    final textSec = isDark ? const Color(0xFF888888) : const Color(0xFF666666);
    final accent = const Color(0xFF007AFF);
    final red = const Color(0xFFFF3B30);

    return Scaffold(
      backgroundColor: bg,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: surface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: accent, size: 18),
          onPressed: _isProcessing
              ? null
              : () {
                  if (mounted) {
                    Navigator.of(context).pop();
                  }
                },
        ),
        title: Text(
          'Edit Transaction',
          style: TextStyle(
            color: textMain,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.delete_outline_rounded, color: red),
            onPressed: _isProcessing ? null : _showDeleteConfirmation,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Transaction Type
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: cardSurface,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(isDark ? 0.3 : 0.06),
                    blurRadius: 12,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Transaction Type',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: textMain,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: TransactionType.values.map((type) {
                      final isSelected = _selectedType == type;
                      final isIncome = type == TransactionType.income;
                      final chipColor = isIncome
                          ? const Color(0xFF34C759)
                          : red;

                      return Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                            right: type == TransactionType.income ? 8 : 0,
                          ),
                          child: GestureDetector(
                            onTap: _isProcessing
                                ? null
                                : () {
                                    setState(() {
                                      _selectedType = type;
                                      _selectedCategory =
                                          null; // Reset category when type changes
                                    });
                                  },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? chipColor.withOpacity(0.15)
                                    : surface,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: isSelected
                                      ? chipColor
                                      : textSec.withOpacity(0.2),
                                  width: 1,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  _getTypeLabel(type),
                                  style: TextStyle(
                                    color: isSelected ? chipColor : textSec,
                                    fontWeight: isSelected
                                        ? FontWeight.w600
                                        : FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Title and Amount
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: cardSurface,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(isDark ? 0.3 : 0.06),
                    blurRadius: 12,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Transaction Details',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: textMain,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _titleController,
                    enabled: !_isProcessing,
                    style: TextStyle(color: textMain),
                    decoration: InputDecoration(
                      labelText: 'Title *',
                      labelStyle: TextStyle(color: textSec),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: textSec.withOpacity(0.2)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: textSec.withOpacity(0.2)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: accent),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _amountController,
                    enabled: !_isProcessing,
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: textMain),
                    decoration: InputDecoration(
                      labelText: 'Amount *',
                      labelStyle: TextStyle(color: textSec),
                      prefixText: '${currency.symbol} ',
                      prefixStyle: TextStyle(color: textSec),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: textSec.withOpacity(0.2)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: textSec.withOpacity(0.2)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: accent),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Category Selection
            _buildCategorySelector(
              cardSurface,
              textMain,
              textSec,
              accent,
              isDark,
            ),

            const SizedBox(height: 16),

            // Account Selection
            _buildAccountSelector(
              cardSurface,
              textMain,
              textSec,
              accent,
              isDark,
            ),

            const SizedBox(height: 16),

            // Date Selection
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: cardSurface,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(isDark ? 0.3 : 0.06),
                    blurRadius: 12,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Date',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: textMain,
                    ),
                  ),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: _isProcessing ? null : _selectDate,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: textSec.withOpacity(0.2)),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _formatDate(_selectedDate),
                            style: TextStyle(color: textMain, fontSize: 16),
                          ),
                          Icon(
                            Icons.calendar_today_outlined,
                            color: accent,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Note
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: cardSurface,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(isDark ? 0.3 : 0.06),
                    blurRadius: 12,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Note (Optional)',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: textMain,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _noteController,
                    enabled: !_isProcessing,
                    maxLines: 3,
                    style: TextStyle(color: textMain),
                    decoration: InputDecoration(
                      hintText: 'Add a note...',
                      hintStyle: TextStyle(color: textSec),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: textSec.withOpacity(0.2)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: textSec.withOpacity(0.2)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: accent),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Save Button
            Container(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _isProcessing ? null : _saveTransaction,
                style: ElevatedButton.styleFrom(
                  backgroundColor: accent,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: _isProcessing
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'Saving...',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      )
                    : Text(
                        'Save Changes',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildCategorySelector(
    Color cardSurface,
    Color textMain,
    Color textSec,
    Color accent,
    bool isDark,
  ) {
    final categories = _selectedType == TransactionType.expense
        ? ref.watch(expenseCategoriesProvider)
        : ref.watch(incomeCategoriesProvider);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardSurface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.3 : 0.06),
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Category',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: textMain,
                ),
              ),
              TextButton(
                onPressed: _isProcessing
                    ? null
                    : () {
                        Navigator.of(context).pushNamed('/categories');
                      },
                child: Text(
                  'Manage',
                  style: TextStyle(color: accent, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          categories.when(
            data: (categoryList) {
              return Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: textSec.withOpacity(0.2)),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedCategory,
                    hint: Text(
                      'Select a category',
                      style: TextStyle(color: textSec),
                    ),
                    style: TextStyle(color: textMain),
                    dropdownColor: cardSurface,
                    items: [
                      DropdownMenuItem<String>(
                        value: null,
                        child: Text(
                          'No Category',
                          style: TextStyle(color: textSec),
                        ),
                      ),
                      ...categoryList.map(
                        (category) => DropdownMenuItem(
                          value: (category as ExpenseCategory).name,
                          child: Text(
                            (category).name,
                            style: TextStyle(color: textMain),
                          ),
                        ),
                      ),
                    ],
                    onChanged: _isProcessing
                        ? null
                        : (value) => setState(() => _selectedCategory = value),
                  ),
                ),
              );
            },
            loading: () =>
                Center(child: CircularProgressIndicator(color: accent)),
            error: (_, __) => Text(
              'Error loading categories',
              style: TextStyle(color: textSec),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountSelector(
    Color cardSurface,
    Color textMain,
    Color textSec,
    Color accent,
    bool isDark,
  ) {
    final accountsAsync = ref.watch(accountsProvider);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardSurface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.3 : 0.06),
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Account (Optional)',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: textMain,
            ),
          ),
          const SizedBox(height: 16),
          accountsAsync.when(
            data: (accounts) {
              return Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: textSec.withOpacity(0.2)),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedAccount,
                    hint: Text(
                      'Select an account',
                      style: TextStyle(color: textSec),
                    ),
                    style: TextStyle(color: textMain),
                    dropdownColor: cardSurface,
                    items: [
                      DropdownMenuItem<String>(
                        value: null,
                        child: Text(
                          'No Account (General)',
                          style: TextStyle(color: textSec),
                        ),
                      ),
                      ...accounts.map(
                        (account) => DropdownMenuItem(
                          value: account.id,
                          child: Text(
                            account.name,
                            style: TextStyle(color: textMain),
                          ),
                        ),
                      ),
                    ],
                    onChanged: _isProcessing
                        ? null
                        : (value) => setState(() => _selectedAccount = value),
                  ),
                ),
              );
            },
            loading: () =>
                Center(child: CircularProgressIndicator(color: accent)),
            error: (_, __) => Text(
              'Error loading accounts',
              style: TextStyle(color: textSec),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _selectDate() async {
    if (!mounted || _isProcessing) return;

    final date = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );

    if (date != null && mounted && !_isProcessing) {
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

  Future<void> _saveTransaction() async {
    if (_isProcessing || !mounted) return;

    if (_titleController.text.trim().isEmpty) {
      _showSnackBar('Title is required', isError: true);
      return;
    }

    final amount = double.tryParse(_amountController.text.trim());
    if (amount == null || amount <= 0) {
      _showSnackBar('Enter a valid amount', isError: true);
      return;
    }

    setState(() => _isProcessing = true);

    try {
      final updatedTransaction = widget.transaction.copyWith(
        type: _selectedType,
        title: _titleController.text.trim(),
        amount: amount,
        category: _selectedCategory,
        account: _selectedAccount,
        date: _selectedDate,
        note: _noteController.text.trim().isEmpty
            ? null
            : _noteController.text.trim(),
      );

   await ref.read(transactionsProvider.notifier).updateTransaction(updatedTransaction);

    if (mounted) {
      // Simple success feedback and navigation
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Transaction updated successfully!'),
          backgroundColor: const Color(0xFF34C759),
          behavior: SnackBarBehavior.floating,
        ),
      );
      
      // Use Navigator.pop() consistently
      Navigator.of(context).pop();
    }
  } catch (e) {
    if (mounted) {
      setState(() => _isProcessing = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: const Color(0xFFFF3B30),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }
}

  void _showDeleteConfirmation() {
    if (!mounted || _isProcessing) return;

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardSurface = isDark ? const Color(0xFF1C1C1E) : Colors.white;
    final textMain = isDark ? Colors.white : Colors.black;
    final textSec = isDark ? const Color(0xFF888888) : const Color(0xFF666666);
    final red = const Color(0xFFFF3B30);

    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (dialogContext) => AlertDialog(
        backgroundColor: cardSurface,
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'Delete Transaction',
          style: TextStyle(
            color: textMain,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        content: Text(
          'Are you sure you want to delete "${widget.transaction.title}"? This action cannot be undone.',
          style: TextStyle(color: textSec, fontSize: 14),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(
              'Cancel',
              style: TextStyle(color: textSec, fontWeight: FontWeight.w500),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              _deleteTransaction();
            },
            child: Text(
              'Delete',
              style: TextStyle(color: red, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _deleteTransaction() async {
    if (_isProcessing || !mounted) return;

    setState(() => _isProcessing = true);

    try {
      await ref
          .read(transactionsProvider.notifier)
          .deleteTransaction(widget.transaction.id);

      if (mounted) {
        _showSnackBar('Transaction deleted successfully!');
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isProcessing = false);
        _showSnackBar('Error deleting transaction: $e', isError: true);
      }
    }
  }

  void _showSnackBar(String message, {bool isError = false}) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError
            ? const Color(0xFFFF3B30)
            : const Color(0xFF34C759),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
