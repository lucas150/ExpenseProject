
// lib/features/dashboard/widgets/transaction_filter_chips.dart
import 'package:expense_project/features/categories/categories_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/transaction_model.dart';

class TransactionFilterChips extends ConsumerWidget {
  final String selectedDateFilter;
  final String? selectedCategoryFilter;
  final TransactionType? selectedTypeFilter;
  final Function(String) onDateFilterChanged;
  final Function(String?) onCategoryFilterChanged;
  final Function(TransactionType?) onTypeFilterChanged;

  const TransactionFilterChips({
    super.key,
    required this.selectedDateFilter,
    required this.selectedCategoryFilter,
    required this.selectedTypeFilter,
    required this.onDateFilterChanged,
    required this.onCategoryFilterChanged,
    required this.onTypeFilterChanged,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expenseCategories = ref.watch(expenseCategoriesProvider);
    final incomeCategories = ref.watch(incomeCategoriesProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Date Filter Row
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                'All',
                'Today',
                'Last 7 days',
                'Last 30 days',
                'This month',
              ].map((filter) => Padding(
                padding: const EdgeInsets.only(right: 8),
                child: FilterChip(
                  label: Text(filter),
                  selected: selectedDateFilter == filter,
                  onSelected: (_) => onDateFilterChanged(filter),
                ),
              )).toList(),
            ),
          ),
          
          const SizedBox(height: 8),
          
          // Type Filter Row
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                FilterChip(
                  label: const Text('All Types'),
                  selected: selectedTypeFilter == null,
                  onSelected: (_) => onTypeFilterChanged(null),
                ),
                const SizedBox(width: 8),
                FilterChip(
                  label: const Text('Income'),
                  selected: selectedTypeFilter == TransactionType.income,
                  onSelected: (_) => onTypeFilterChanged(TransactionType.income),
                ),
                const SizedBox(width: 8),
                FilterChip(
                  label: const Text('Expense'),
                  selected: selectedTypeFilter == TransactionType.expense,
                  onSelected: (_) => onTypeFilterChanged(TransactionType.expense),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 8),
          
          // Category Filter Row
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                FilterChip(
                  label: const Text('All Categories'),
                  selected: selectedCategoryFilter == null,
                  onSelected: (_) => onCategoryFilterChanged(null),
                ),
                const SizedBox(width: 8),
                ...expenseCategories.when(
                  data: (categories) => categories.map((cat) => Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: FilterChip(
                      label: Text(cat.name),
                      selected: selectedCategoryFilter == cat.name,
                      onSelected: (_) => onCategoryFilterChanged(cat.name),
                    ),
                  )).toList(),
                  loading: () => [],
                  error: (_, __) => [],
                ),
                ...incomeCategories.when(
                  data: (categories) => categories.map((cat) => Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: FilterChip(
                      label: Text(cat.name),
                      selected: selectedCategoryFilter == cat.name,
                      onSelected: (_) => onCategoryFilterChanged(cat.name),
                    ),
                  )).toList(),
                  loading: () => [],
                  error: (_, __) => [],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
