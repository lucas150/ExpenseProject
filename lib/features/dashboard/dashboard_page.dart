// import 'package:expense_project/core/models/account_model.dart';
// import 'package:expense_project/core/models/transaction_model.dart';
// import 'package:expense_project/features/accounts/accounts_provider.dart';
// import 'package:expense_project/features/transactions/transaction_add_page.dart';
// import 'package:expense_project/features/transactions/transactions_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class DashboardPage extends ConsumerWidget {
//   const DashboardPage({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final accountsAsync = ref.watch(accountsProvider);
//     final transactionsAsync = ref.watch(transactionsProvider);

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Note-Go Dashboard'),
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//       ),
//       body: RefreshIndicator(
//         onRefresh: () async {
//           ref.invalidate(accountsProvider);
//           ref.invalidate(transactionsProvider);
//         },
//         child: SingleChildScrollView(
//           physics: const AlwaysScrollableScrollPhysics(),
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Balance Overview - Only Income/Expense + Net Balance
//               _buildBalanceOverview(ref),
//               const SizedBox(height: 24),

//               // Accounts Section - Now optional
//               _buildAccountsSection(accountsAsync),
//               const SizedBox(height: 24),

//               // Recent Transactions Section - Handle null accounts
//               _buildTransactionsSection(transactionsAsync),
//             ],
//           ),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.of(context).push(
//             MaterialPageRoute(builder: (context) => const AddTransactionPage()),
//           );
//         },
//         child: const Icon(Icons.add),
//         tooltip: 'Add Transaction',
//       ),
//     );
//   }

//   // FIXED: Properly access the notifier through ref.read() or calculate directly from data
//   Widget _buildBalanceOverview(WidgetRef ref) {
//     return Consumer(
//       builder: (context, ref, child) {
//         final transactionsAsync = ref.watch(transactionsProvider);

//         return Card(
//           child: Padding(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Financial Overview',
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.grey[700],
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 transactionsAsync.when(
//                   loading: () =>
//                       const Center(child: CircularProgressIndicator()),
//                   error: (error, stack) => Text('Error: $error'),
//                   data: (transactions) {
//                     // Calculate totals directly from the data since we have access to it
//                     final totalIncome = transactions
//                         .where((t) => t.type == TransactionType.income)
//                         .fold(0.0, (sum, t) => sum + t.amount);

//                     final totalExpense = transactions
//                         .where((t) => t.type == TransactionType.expense)
//                         .fold(0.0, (sum, t) => sum + t.amount);

//                     final netBalance = totalIncome - totalExpense;

//                     return Row(
//                       children: [
//                         Expanded(
//                           child: _buildBalanceCard(
//                             'Income',
//                             totalIncome,
//                             Colors.green,
//                             Icons.trending_up,
//                           ),
//                         ),
//                         const SizedBox(width: 8),
//                         Expanded(
//                           child: _buildBalanceCard(
//                             'Expenses',
//                             totalExpense,
//                             Colors.red,
//                             Icons.trending_down,
//                           ),
//                         ),
//                         const SizedBox(width: 8),
//                         Expanded(
//                           child: _buildBalanceCard(
//                             'Net Balance',
//                             netBalance,
//                             netBalance >= 0 ? Colors.green : Colors.red,
//                             Icons.account_balance,
//                           ),
//                         ),
//                       ],
//                     );
//                   },
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildBalanceCard(
//     String title,
//     double amount,
//     Color color,
//     IconData icon,
//   ) {
//     return Container(
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: color.withOpacity(0.1),
//         borderRadius: BorderRadius.circular(8),
//         border: Border.all(color: color.withOpacity(0.3)),
//       ),
//       child: Column(
//         children: [
//           Icon(icon, color: color, size: 24),
//           const SizedBox(height: 8),
//           Text(
//             title,
//             style: TextStyle(
//               fontSize: 12,
//               color: Colors.grey[600],
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//           const SizedBox(height: 4),
//           Text(
//             '₹${amount.toStringAsFixed(0)}',
//             style: TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//               color: color,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildAccountsSection(AsyncValue<List<Account>> accountsAsync) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               'Accounts (Optional)',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.grey[700],
//               ),
//             ),
//             TextButton(
//               onPressed: () {
//                 // Navigate to accounts page or add account
//                 // TODO: Implement navigation to accounts page
//               },
//               child: const Text('Manage'),
//             ),
//           ],
//         ),
//         const SizedBox(height: 8),
//         accountsAsync.when(
//           loading: () => const Center(child: CircularProgressIndicator()),
//           error: (error, stack) => Text('Error loading accounts: $error'),
//           data: (accounts) {
//             if (accounts.isEmpty) {
//               return Card(
//                 child: Padding(
//                   padding: const EdgeInsets.all(16),
//                   child: Column(
//                     children: [
//                       const Text('No accounts created yet.'),
//                       const SizedBox(height: 8),
//                       Text(
//                         'You can track expenses without accounts, or add accounts to organize your money better.',
//                         style: TextStyle(color: Colors.grey[600], fontSize: 12),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             }
//             return Column(
//               children: accounts
//                   .map(
//                     (account) => Card(
//                       child: ListTile(
//                         leading: CircleAvatar(
//                           backgroundColor: account.type == 'Cash'
//                               ? Colors.green
//                               : Colors.blue,
//                           child: Icon(
//                             account.type == 'Cash'
//                                 ? Icons.money
//                                 : Icons.account_balance,
//                             color: Colors.white,
//                           ),
//                         ),
//                         title: Text(account.name),
//                         subtitle: Text(account.type),
//                         trailing: Text(
//                           '₹${account.balance.toStringAsFixed(2)}',
//                           style: const TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 16,
//                           ),
//                         ),
//                       ),
//                     ),
//                   )
//                   .toList(),
//             );
//           },
//         ),
//       ],
//     );
//   }

//   Widget _buildTransactionsSection(
//     AsyncValue<List<TransactionModel>> transactionsAsync,
//   ) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               'Recent Transactions',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.grey[700],
//               ),
//             ),
//             TextButton(
//               onPressed: () {
//                 // Navigate to transactions page
//                 // TODO: Implement navigation to transactions page
//               },
//               child: const Text('View All'),
//             ),
//           ],
//         ),
//         const SizedBox(height: 8),
//         transactionsAsync.when(
//           loading: () => const Center(child: CircularProgressIndicator()),
//           error: (error, stack) => Text('Error loading transactions: $error'),
//           data: (transactions) {
//             if (transactions.isEmpty) {
//               return const Card(
//                 child: Padding(
//                   padding: EdgeInsets.all(16),
//                   child: Text(
//                     'No transactions found. Add your first transaction!',
//                   ),
//                 ),
//               );
//             }
//             final recentTransactions = transactions.take(5).toList();
//             return Column(
//               children: recentTransactions
//                   .map(
//                     (transaction) => Card(
//                       child: ListTile(
//                         leading: CircleAvatar(
//                           backgroundColor: _getTransactionColor(
//                             transaction.type,
//                           ),
//                           child: Icon(
//                             _getTransactionIcon(transaction.type),
//                             color: Colors.white,
//                           ),
//                         ),
//                         title: Text(transaction.title),
//                         subtitle: Text(
//                           // Handle null account gracefully
//                           '${transaction.category ?? 'Uncategorized'} • ${transaction.account ?? 'No Account'} • ${_formatDate(transaction.date)}',
//                         ),
//                         trailing: Text(
//                           '₹${transaction.amount.toStringAsFixed(2)}',
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 16,
//                             color: _getTransactionColor(transaction.type),
//                           ),
//                         ),
//                       ),
//                     ),
//                   )
//                   .toList(),
//             );
//           },
//         ),
//       ],
//     );
//   }

//   Color _getTransactionColor(TransactionType type) {
//     switch (type) {
//       case TransactionType.income:
//         return Colors.green;
//       case TransactionType.expense:
//         return Colors.red;
//     }
//   }

//   IconData _getTransactionIcon(TransactionType type) {
//     switch (type) {
//       case TransactionType.income:
//         return Icons.arrow_downward;
//       case TransactionType.expense:
//         return Icons.arrow_upward;
//     }
//   }

//   String _formatDate(DateTime date) {
//     return '${date.day}/${date.month}/${date.year}';
//   }
// }

// // import 'package:flutter/material.dart';
// // import 'package:flutter_riverpod/flutter_riverpod.dart';

// // class DashboardPage extends ConsumerWidget {
// //   const DashboardPage({super.key});

// //   @override
// //   Widget build(BuildContext context, WidgetRef ref) {
// //     // This is a placeholder for the actual dashboard content
// //     return Scaffold(
// //       appBar: AppBar(title: const Text('Dashboard')),
// //       body: Center(
// //         child: Text(
// //           'Welcome to the Dashboard!',
// //           style: Theme.of(context).textTheme.headlineMedium,
// //         ),
// //       ),
// //       floatingActionButton: FloatingActionButton(
// //         onPressed: () {
// //           // Placeholder for action
// //         },
// //         child: const Icon(Icons.add),
// //       ),
// //     );
// //   }
// // }

// lib/features/dashboard/pages/modern_dashboard_page.dart
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../../../core/models/transaction_model.dart';
// import '../../../core/models/account_model.dart';
// import '../../transactions/providers/transactions_provider.dart';
// import '../../accounts/providers/accounts_provider.dart';
// import '../../categories/providers/categories_provider.dart';
// import '../widgets/balance_overview_card.dart';
// import '../widgets/transaction_filter_chips.dart';
// import '../widgets/modern_transaction_list.dart';
// import '../widgets/quick_add_transaction.dart';

import 'package:expense_project/core/models/transaction_model.dart';
import 'package:expense_project/features/accounts/accounts_provider.dart';
import 'package:expense_project/features/dashboard/widgets/balance_overview_card.dart';
import 'package:expense_project/features/dashboard/widgets/modern_transaction_list.dart';
import 'package:expense_project/features/dashboard/widgets/quick_add_transaction.dart';
import 'package:expense_project/features/dashboard/widgets/transaction_filter_chips.dart';
import 'package:expense_project/features/transactions/transactions_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ModernDashboardPage extends ConsumerStatefulWidget {
  const ModernDashboardPage({super.key});

  @override
  ConsumerState<ModernDashboardPage> createState() =>
      _ModernDashboardPageState();
}

class _ModernDashboardPageState extends ConsumerState<ModernDashboardPage> {
  String _selectedDateFilter = 'All';
  String? _selectedCategoryFilter;
  TransactionType? _selectedTypeFilter;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final transactionsAsync = ref.watch(transactionsProvider);
    final accountsAsync = ref.watch(accountsProvider);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: CustomScrollView(
        slivers: [
          // Modern App Bar
          SliverAppBar.large(
            title: Text(
              'Note-Go',
              style: theme.textTheme.headlineLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: theme.colorScheme.surface,
            foregroundColor: theme.colorScheme.onSurface,
            elevation: 0,
            actions: [
              IconButton(
                icon: const Icon(Icons.settings_outlined),
                onPressed: () => context.go('/settings'),
              ),
            ],
          ),

          // Balance Overview
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: BalanceOverviewCard(),
            ),
          ),

          // Filter Chips
          SliverToBoxAdapter(
            child: TransactionFilterChips(
              selectedDateFilter: _selectedDateFilter,
              selectedCategoryFilter: _selectedCategoryFilter,
              selectedTypeFilter: _selectedTypeFilter,
              onDateFilterChanged: (filter) =>
                  setState(() => _selectedDateFilter = filter),
              onCategoryFilterChanged: (filter) =>
                  setState(() => _selectedCategoryFilter = filter),
              onTypeFilterChanged: (filter) =>
                  setState(() => _selectedTypeFilter = filter),
            ),
          ),

          // Quick Add Transaction
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: QuickAddTransaction(),
            ),
          ),

          // Transactions List
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: transactionsAsync.when(
              loading: () => const SliverFillRemaining(
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (error, stack) => SliverFillRemaining(
                child: Center(child: Text('Error: $error')),
              ),
              data: (transactions) {
                final filteredTransactions = _filterTransactions(transactions);

                if (filteredTransactions.isEmpty) {
                  return const SliverFillRemaining(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.receipt_long_outlined,
                            size: 64,
                            color: Colors.grey,
                          ),
                          SizedBox(height: 16),
                          Text(
                            'No transactions found',
                            style: TextStyle(fontSize: 18),
                          ),
                          Text('Start by adding your first transaction'),
                        ],
                      ),
                    ),
                  );
                }

                return ModernTransactionList(
                  transactions: filteredTransactions,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  List<TransactionModel> _filterTransactions(
    List<TransactionModel> transactions,
  ) {
    var filtered = transactions.toList();

    // Date filter
    if (_selectedDateFilter != 'All') {
      final now = DateTime.now();
      final filterDate = _getFilterDate(now, _selectedDateFilter);
      filtered = filtered.where((t) => t.date.isAfter(filterDate)).toList();
    }

    // Category filter
    if (_selectedCategoryFilter != null) {
      filtered = filtered
          .where((t) => t.category == _selectedCategoryFilter)
          .toList();
    }

    // Type filter
    if (_selectedTypeFilter != null) {
      filtered = filtered.where((t) => t.type == _selectedTypeFilter).toList();
    }

    return filtered;
  }

  DateTime _getFilterDate(DateTime now, String filter) {
    switch (filter) {
      case 'Today':
        return DateTime(now.year, now.month, now.day);
      case 'Last 7 days':
        return now.subtract(const Duration(days: 7));
      case 'Last 30 days':
        return now.subtract(const Duration(days: 30));
      case 'This month':
        return DateTime(now.year, now.month, 1);
      default:
        return DateTime(2020); // All time
    }
  }
}
