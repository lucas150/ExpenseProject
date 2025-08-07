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
