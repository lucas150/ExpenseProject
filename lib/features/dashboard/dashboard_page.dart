import 'package:expense_project/core/models/transaction_model.dart';
import 'package:expense_project/features/transactions/transaction_add_page.dart';
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
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final transactionsAsync = ref.watch(transactionsProvider);

    // Enhanced color scheme
    final isDark = theme.brightness == Brightness.dark;
    final bg = isDark ? const Color(0xFF000000) : const Color(0xFFFFFFFF);
    final surface = isDark
        ? const Color.fromARGB(255, 27, 26, 26)
        : const Color.fromARGB(255, 245, 245, 245);
    final text1 = isDark ? const Color(0xFFFFFFFF) : const Color(0xFF000000);
    final text2 = isDark ? const Color(0xFF888888) : const Color(0xFF666666);
    final accent = const Color(0xFF007AFF);
    final green = const Color(0xFF34C759);
    final red = const Color(0xFFFF3B30);

    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        top: false,
        minimum: const EdgeInsets.only(top: 12),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: balance(surface, text1, text2, green, red),
            ),

            const SizedBox(height: 24),
            // Header with Recent Transactions
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Recent Transactions',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: text1,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Latest activity',
                        style: TextStyle(
                          fontSize: 13,
                          color: text2.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: accent.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: accent.withOpacity(0.2),
                        width: 0.5,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.swipe_left_rounded, size: 14, color: accent),
                        const SizedBox(width: 4),
                        Text(
                          'Swipe to delete',
                          style: TextStyle(
                            fontSize: 11,
                            color: accent,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Transactions container
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: surface,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(isDark ? 0.2 : 0.06),
                      blurRadius: 12,
                      offset: const Offset(0, 2),
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: transactionsAsync.when(
                  loading: () => Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: accent,
                    ),
                  ),
                  error: (error, stack) => Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.error_outline_rounded, color: red, size: 32),
                        const SizedBox(height: 8),
                        Text(
                          'Error loading transactions',
                          style: TextStyle(color: text2, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  data: (transactions) {
                    final filtered = getFilteredTransactions(transactions);

                    if (filtered.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: accent.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Icon(
                                Icons.receipt_long_outlined,
                                color: accent,
                                size: 40,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'No transactions yet',
                              style: TextStyle(
                                color: text1,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Tap + to add your first transaction',
                              style: TextStyle(
                                color: text2.withOpacity(0.8),
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    final recentTransactions = filtered.take(5).toList();
                    final hasMoreTransactions = filtered.length > 5;

                    return Column(
                      children: [
                        // Transactions List
                        Expanded(
                          child: ListView.separated(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 16,
                            ),
                            itemCount: recentTransactions.length,
                            separatorBuilder: (context, index) => Container(
                              height: 1,
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    text2.withOpacity(0.0),
                                    text2.withOpacity(0.12),
                                    text2.withOpacity(0.0),
                                  ],
                                ),
                              ),
                            ),
                            itemBuilder: (context, index) {
                              final transaction = recentTransactions[index];
                              return enhancedTransactionRow(
                                ref,
                                transaction,
                                text1,
                                text2,
                                green,
                                red,
                                accent,
                                isDark,
                                onDelete: () =>
                                    _deleteTransaction(transaction.id),
                                onEdit: () => _editTransaction(transaction),
                              );
                            },
                          ),
                        ),

                        // Enhanced See More Button
                        if (hasMoreTransactions) ...[
                          Container(
                            margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                            child: Column(
                              children: [
                                // Elegant divider
                                Container(
                                  height: 1,
                                  margin: const EdgeInsets.only(bottom: 16),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        text2.withOpacity(0.0),
                                        text2.withOpacity(0.15),
                                        text2.withOpacity(0.0),
                                      ],
                                    ),
                                  ),
                                ),

                                // See More button
                                GestureDetector(
                                  onTap: () => context.push('/transactions'),
                                  child: Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 14,
                                    ),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          accent.withOpacity(0.1),
                                          accent.withOpacity(0.05),
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(14),
                                      border: Border.all(
                                        color: accent.withOpacity(0.2),
                                        width: 1,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'View All ${filtered.length} Transactions',
                                          style: TextStyle(
                                            color: accent,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Icon(
                                          Icons.arrow_forward_rounded,
                                          color: accent,
                                          size: 16,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    );
                  },
                ),
              ),
            ),

            // Space for FAB
            const SizedBox(height: 80),
          ],
        ),
      ),
      // Proper FAB positioning
      floatingActionButton: Container(
        margin: const EdgeInsets.only(bottom: 16),
        child: FloatingActionButton.extended(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (context) => const AddTransactionPage(),
            );
          },
          backgroundColor: accent,
          elevation: 6,
          extendedPadding: const EdgeInsets.symmetric(horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          label: Row(
            children: [
              Icon(Icons.add_rounded, size: 22, color: Colors.white),
              const SizedBox(width: 8),
              Text(
                'Add Transaction',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  // Enhanced Balance Widget (unchanged)
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
          loading: () => Container(
            height: 140,
            decoration: BoxDecoration(
              color: surface,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: const Color(0xFF007AFF),
              ),
            ),
          ),
          error: (error, stack) => Container(
            height: 140,
            decoration: BoxDecoration(
              color: surface,
              borderRadius: BorderRadius.circular(20),
            ),
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
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                    spreadRadius: 0,
                  ),
                ],
                border: Border.all(
                  color: (balance >= 0 ? green : red).withOpacity(0.1),
                  width: 1,
                ),
              ),
              child: Column(
                children: [
                  // Balance amount
                  Text(
                    '₹${balance.abs().toStringAsFixed(0)}',
                    style: TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.w300,
                      color: balance >= 0 ? green : red,
                      letterSpacing: -1.5,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    balance >= 0 ? 'Total Balance' : 'Over Budget',
                    style: TextStyle(
                      fontSize: 14,
                      color: text2,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Income/Expenses
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              '↗️ ₹${income.toStringAsFixed(0)}',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: green,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Income',
                              style: TextStyle(fontSize: 12, color: text2),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 30,
                        color: text2.withOpacity(0.2),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              '↘️ ₹${expenses.toStringAsFixed(0)}',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: red,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Expenses',
                              style: TextStyle(fontSize: 12, color: text2),
                            ),
                          ],
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

  // Helper Methods (unchanged)
  void _deleteTransaction(String transactionId) async {
    try {
      await ref
          .read(transactionsProvider.notifier)
          .deleteTransaction(transactionId);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(Icons.check_circle_rounded, color: Colors.white, size: 18),
                const SizedBox(width: 8),
                Text('Transaction deleted'),
              ],
            ),
            backgroundColor: const Color(0xFF34C759),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(Icons.error_rounded, color: Colors.white, size: 18),
                const SizedBox(width: 8),
                Text('Error deleting transaction'),
              ],
            ),
            backgroundColor: const Color(0xFFFF3B30),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  void _editTransaction(TransactionModel transaction) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) =>
          AddTransactionPage(existingTransaction: transaction),
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

// COMPLETELY FIXED Enhanced Transaction Row - No More Layout Issues
Widget enhancedTransactionRow(
  WidgetRef ref,
  TransactionModel transaction,
  Color text1,
  Color text2,
  Color green,
  Color red,
  Color accent,
  bool isDark, {
  VoidCallback? onDelete,
  VoidCallback? onEdit,
}) {
  final isExpense = transaction.type == TransactionType.expense;
  final amountColor = isExpense ? red : green;

  String capitalize(String? text) {
    if (text == null || text.isEmpty) return '';
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }

  // Build category/account text safely
  String buildSubtitle() {
    final parts = <String>[];
    if (transaction.category != null) {
      parts.add(capitalize(transaction.category));
    }
    if (transaction.account != null) {
      parts.add(transaction.account!);
    }
    return parts.join(' • ');
  }

  return Dismissible(
    key: Key(transaction.id),
    direction: DismissDirection.endToStart,
    background: Container(
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(right: 20),
      margin: const EdgeInsets.symmetric(vertical: 2),
      decoration: BoxDecoration(
        color: red,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Icon(Icons.delete_outline_rounded, color: Colors.white, size: 22),
          const SizedBox(width: 6),
          Text(
            'Delete',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ],
      ),
    ),
    confirmDismiss: (direction) async {
      final surface = isDark ? const Color(0xFF1C1C1E) : Colors.white;
      return await showDialog<bool>(
            context: ref.context,
            barrierColor: Colors.black.withOpacity(0.3),
            builder: (context) => AlertDialog(
              backgroundColor: surface,
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              title: Text(
                'Delete Transaction',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: text1,
                ),
              ),
              content: Text(
                'Delete "${transaction.title}"? This cannot be undone.',
                style: TextStyle(fontSize: 14, color: text2),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: text2, fontWeight: FontWeight.w500),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text(
                    'Delete',
                    style: TextStyle(color: red, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ) ??
          false;
    },
    onDismissed: (direction) => onDelete?.call(),
    child: GestureDetector(
      onTap: onEdit,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        margin: const EdgeInsets.symmetric(vertical: 2),
        decoration: BoxDecoration(
          color: isDark
              ? Colors.white.withOpacity(0.03)
              : Colors.black.withOpacity(0.02),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: amountColor.withOpacity(0.08), width: 1),
        ),
        child: Row(
          children: [
            // Enhanced icon
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: amountColor.withOpacity(0.12),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Center(
                child: Icon(
                  isExpense
                      ? Icons.arrow_downward_rounded
                      : Icons.arrow_upward_rounded,
                  color: amountColor,
                  size: 20,
                ),
              ),
            ),
            const SizedBox(width: 16),

            // Transaction info - COMPLETELY FIXED with proper layout
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize:
                    MainAxisSize.min, // FIXED: Don't expand vertically
                children: [
                  // Title with proper overflow handling
                  Text(
                    // transaction.title,
                    capitalize(transaction.title),
                    style: TextStyle(
                      fontSize: 16,
                      color: text1,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1, // FIXED: Limit to single line
                    overflow: TextOverflow.ellipsis, // FIXED: Handle overflow
                  ),
                  const SizedBox(height: 4),
                  // Subtitle - FIXED: Simple string approach, no complex widgets
                  if (buildSubtitle().isNotEmpty)
                    Text(
                      buildSubtitle(),
                      style: TextStyle(fontSize: 13, color: text2),
                      maxLines: 1, // FIXED: Limit to single line
                      overflow: TextOverflow.ellipsis, // FIXED: Handle overflow
                    ),
                ],
              ),
            ),

            const SizedBox(width: 12), // FIXED: Reduced space
            Flexible(
              flex: 0, // Don't expand, just fit content
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${isExpense ? '-' : '+'}₹${transaction.amount.toStringAsFixed(0)}',
                    style: TextStyle(
                      fontSize: 15, // Slightly smaller font
                      fontWeight: FontWeight.w700,
                      color: amountColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    formatSimpleDate(transaction.date),
                    style: TextStyle(
                      fontSize: 12, // Smaller date font
                      color: text2.withOpacity(0.8),
                    ),
                    maxLines: 1,
                  ),
                ],
              ),
            ),

            const SizedBox(width: 8),
            Icon(
              Icons.keyboard_arrow_right_rounded,
              color: text2.withOpacity(0.3),
              size: 18,
            ),
          ],
        ),
      ),
    ),
  );
}

String formatSimpleDate(DateTime date) {
  final now = DateTime.now();
  final diff = now.difference(date).inDays;

  if (diff == 0) return 'Today';
  if (diff == 1) return 'Yesterday';
  if (diff < 7) return '${diff}d ago';

  return '${date.day}/${date.month}';
}
