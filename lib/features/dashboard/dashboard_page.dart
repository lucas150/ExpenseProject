import 'package:expense_project/core/models/transaction_model.dart';
import 'package:expense_project/features/transactions/transaction_add_page.dart';
import 'package:expense_project/features/transactions/transactions_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:expense_project/features/dashboard/widgets/transaction_row.dart';

class ModernDashboardPage extends ConsumerStatefulWidget {
  const ModernDashboardPage({super.key});

  @override
  ConsumerState<ModernDashboardPage> createState() =>
      _ModernDashboardPageState();
}

class _ModernDashboardPageState extends ConsumerState<ModernDashboardPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final transactionsAsync = ref.watch(transactionsProvider);

    //  color scheme - maximum simplicity
    final isDark = theme.brightness == Brightness.dark;
    final bg = isDark ? const Color(0xFF000000) : const Color(0xFFFFFFFF);
    final surface = isDark
        ? const Color.fromARGB(255, 27, 26, 26)
        : const Color.fromARGB(255, 239, 239, 239);
    final text1 = isDark ? const Color(0xFFFFFFFF) : const Color(0xFF000000);
    final text2 = isDark ? const Color(0xFF888888) : const Color(0xFF666666);
    final accent = const Color(0xFF007AFF); // Single blue accent
    final green = const Color(0xFF34C759);
    final red = const Color(0xFFFF3B30);

    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        top: false, // disables SafeArea's default top padding

        minimum: const EdgeInsets.only(top: 12), // adds exactly 12px
        child: Column(
          children: [
            // Balance
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: balance(surface, text1, text2, green, red),
            ),

            const SizedBox(height: 24),

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

            //Transactions list
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(4), // inner padding for content
                decoration: BoxDecoration(
                  color: surface, // your surface color from theme
                  borderRadius: BorderRadius.circular(16),
                ),
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
                    final filtered = getFilteredTransactions(transactions);

                    if (filtered.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.receipt_outlined,
                              color: text2,
                              size: 48,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'No transactions',
                              style: TextStyle(color: text2, fontSize: 16),
                            ),
                          ],
                        ),
                      );
                    }

                    // Show only first 5 transactions
                    final transactionsToShow = filtered.take(5).toList();
                    final hasMoreTransactions = filtered.length > 5;

                    return ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: hasMoreTransactions
                          ? transactionsToShow.length + 1
                          : transactionsToShow.length,
                      separatorBuilder: (context, index) {
                        if (index == transactionsToShow.length) {
                          return const SizedBox.shrink(); // No separator after last transaction
                        }
                        return Divider(
                          color: text2.withOpacity(0.15), // soft, barely there
                          thickness: 0.6,
                        );
                      },
                      itemBuilder: (context, index) {
                        if (index < transactionsToShow.length) {
                          final transaction = transactionsToShow[index];
                          return transactionRow(
                            ref,
                            transaction,
                            text1,
                            text2,
                            green,
                            red,
                          );
                        } else {
                          // See More button as last item
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {
                                  // Navigate to all transactions page
                                  context.push(
                                    '/transactions',
                                  ); // Adjust route as needed
                                },
                                style: TextButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'See More',
                                      style: TextStyle(
                                        color: accent,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      color: accent,
                                      size: 14,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent, // Semi-transparent overlay
            builder: (context) => const AddTransactionPage(),
          );
        },
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

  Widget balance(
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
            final filtered = getFilteredTransactions(transactions);
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
                  // Balance - focal point
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
                  // Income/Expenses - ultra-minimal
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

  List<TransactionModel> getFilteredTransactions(
    List<TransactionModel> transactions,
  ) {
    var filtered = transactions.toList();

    filtered.sort((a, b) => b.date.compareTo(a.date));

    return filtered;
  }
}
