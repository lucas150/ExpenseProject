import 'package:expense_project/core/models/transaction_model.dart';
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
  String _timeFilter = 'month'; // Only essential filter: this month, all time

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final transactionsAsync = ref.watch(transactionsProvider);

    //  color scheme - maximum simplicity
    final isDark = theme.brightness == Brightness.dark;
    final bg = isDark ? const Color(0xFF000000) : const Color(0xFFFFFFFF);
    final surface = isDark ? const Color(0xFF111111) : const Color(0xFFFBFBFB);
    final text1 = isDark ? const Color(0xFFFFFFFF) : const Color(0xFF000000);
    final text2 = isDark ? const Color(0xFF888888) : const Color(0xFF666666);
    final accent = const Color(0xFF007AFF); // Single blue accent
    final green = const Color(0xFF34C759);
    final red = const Color(0xFFFF3B30);

    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Note & Go',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w200,
                          color: text1,
                          letterSpacing: -0.3,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        _getTimeLabel(),
                        style: TextStyle(
                          fontSize: 13,
                          color: text2,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => setState(() {
                          _timeFilter = _timeFilter == 'month'
                              ? 'all'
                              : 'month';
                        }),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: _timeFilter == 'month' ? accent : surface,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            _timeFilter == 'month' ? 'Month' : 'All',
                            style: TextStyle(
                              fontSize: 12,
                              color: _timeFilter == 'month'
                                  ? Colors.white
                                  : text2,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Settings
                      GestureDetector(
                        onTap: () => context.go('/settings'),
                        child: Icon(Icons.more_horiz, color: text2, size: 20),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Pure minimalist balance
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: _buildBalance(surface, text1, text2, green, red),
            ),

            const SizedBox(height: 24),

            // Single action button
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 20),
            //   child: GestureDetector(
            //     onTap: () => context.go('/dashboard/add'),
            //     child: Container(
            //       width: double.infinity,
            //       height: 44,
            //       decoration: BoxDecoration(
            //         color: accent,
            //         borderRadius: BorderRadius.circular(8),
            //       ),
            //       child: Center(
            //         child: Text(
            //           'Add Transaction',
            //           style: const TextStyle(
            //             color: Colors.white,
            //             fontSize: 15,
            //             fontWeight: FontWeight.w500,
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            // const SizedBox(height: 32),

            // Transactions header - minimal
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Recent Transactions',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: text1,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Clean transactions list
            Expanded(
              child: transactionsAsync.when(
                loading: () => Center(
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: accent,
                    ),
                  ),
                ),
                error: (error, stack) => Center(
                  child: Text(
                    'Error loading transactions',
                    style: TextStyle(color: text2, fontSize: 14),
                  ),
                ),
                data: (transactions) {
                  final filtered = _getFilteredTransactions(transactions);

                  if (filtered.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.receipt_outlined, color: text2, size: 48),
                          const SizedBox(height: 16),
                          Text(
                            'No transactions',
                            style: TextStyle(color: text2, fontSize: 16),
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: filtered.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 1),
                    itemBuilder: (context, index) {
                      final transaction = filtered[index];
                      return _buildCleanTransactionRow(
                        transaction,
                        text1,
                        text2,
                        green,
                        red,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go('/dashboard/add'),
        backgroundColor: accent.withOpacity(0.9), // Softer tone
        elevation: 0, // No shadow
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25), // Subtle rounding
        ),
        child: const Icon(
          Icons.add,
          size: 20,
          color: Colors.white, // Slightly smaller icon
        ),
      ),
    );
  }

  Widget _buildBalance(
    Color surface,
    Color text1,
    Color text2,
    Color green,
    Color red,
  ) {
    return Consumer(
      builder: (context, ref, child) {
        final transactionsAsync = ref.watch(transactionsProvider);

        return transactionsAsync.when(
          loading: () => SizedBox(
            height: 120,
            child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
          ),
          error: (error, stack) => SizedBox(
            height: 120,
            child: Center(
              child: Text('Error', style: TextStyle(color: text2)),
            ),
          ),
          data: (transactions) {
            final filtered = _getFilteredTransactions(transactions);
            final income = filtered
                .where((t) => t.type == TransactionType.income)
                .fold(0.0, (sum, t) => sum + t.amount);
            final expenses = filtered
                .where((t) => t.type == TransactionType.expense)
                .fold(0.0, (sum, t) => sum + t.amount);
            final balance = income - expenses;

            return Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: surface,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  // Balance
                  Text(
                    '₹${balance.abs().toStringAsFixed(0)}',
                    style: TextStyle(
                      fontSize: 38,
                      fontWeight: FontWeight.w200,
                      color: balance >= 0 ? green : red,
                      letterSpacing: -1,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    balance >= 0 ? 'Balance' : 'Over budget',
                    style: TextStyle(fontSize: 13, color: text2),
                  ),
                  const SizedBox(height: 20),
                  // Income/Expenses
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          '↑ ₹${income.toStringAsFixed(0)}',
                          style: TextStyle(fontSize: 14, color: text2),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          '↓ ₹${expenses.toStringAsFixed(0)}',
                          style: TextStyle(fontSize: 14, color: text2),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildCleanTransactionRow(
    TransactionModel transaction,
    Color text1,
    Color text2,
    Color green,
    Color red,
  ) {
    final isExpense = transaction.type == TransactionType.expense;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Row(
        children: [
          // indicator
          Container(
            width: 3,
            height: 24,
            decoration: BoxDecoration(
              color: isExpense ? red : green,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 16),
          // Transaction info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.title,
                  style: TextStyle(
                    fontSize: 15,
                    color: text1,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  transaction.category ?? '',
                  style: TextStyle(fontSize: 12, color: text2),
                ),
              ],
            ),
          ),
          // Amount and date
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${isExpense ? '-' : '+'}₹${transaction.amount.toStringAsFixed(0)}',
                style: TextStyle(
                  fontSize: 15,
                  color: isExpense ? red : green,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                _formatSimpleDate(transaction.date),
                style: TextStyle(fontSize: 11, color: text2),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _getTimeLabel() {
    if (_timeFilter == 'month') {
      final now = DateTime.now();
      final months = [
        'January',
        'February',
        'March',
        'April',
        'May',
        'June',
        'July',
        'August',
        'September',
        'October',
        'November',
        'December',
      ];
      return months[now.month - 1];
    }
    return 'All time';
  }

  String _formatSimpleDate(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date).inDays;

    if (diff == 0) return 'Today';
    if (diff == 1) return 'Yesterday';
    if (diff < 7) return '${diff}d';

    return '${date.day}/${date.month}';
  }

  List<TransactionModel> _getFilteredTransactions(
    List<TransactionModel> transactions,
  ) {
    var filtered = transactions.toList();

    // Only one filter - time-based
    if (_timeFilter == 'month') {
      final now = DateTime.now();
      final monthStart = DateTime(now.year, now.month, 1);
      filtered = filtered.where((t) => t.date.isAfter(monthStart)).toList();
    }

    // Sort by date
    filtered.sort((a, b) => b.date.compareTo(a.date));

    return filtered;
  }
}
