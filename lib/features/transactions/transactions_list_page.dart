// // import 'package:expense_project/features/transactions/transaction_add_page.dart';
// // import 'package:expense_project/features/transactions/transactions_provider.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_riverpod/flutter_riverpod.dart';
// // import '../../../core/models/transaction_model.dart';

// // class TransactionsListPage extends ConsumerWidget {
// //   const TransactionsListPage({super.key});

// //   @override
// //   Widget build(BuildContext context, WidgetRef ref) {
// //     final txAsync = ref.watch(transactionsProvider);

// //     return Scaffold(
// //       appBar: AppBar(title: const Text('All Transactions')),
// //       body: txAsync.when(
// //         loading: () => const Center(child: CircularProgressIndicator()),
// //         error: (e, _) => Center(child: Text('Error: $e')),
// //         data: (txs) => txs.isEmpty
// //             ? const Center(child: Text('No transactions yet'))
// //             : ListView.separated(
// //                 itemCount: txs.length,
// //                 separatorBuilder: (_, __) => const Divider(height: 0),
// //                 itemBuilder: (_, i) => _TxTile(tx: txs[i]),
// //               ),
// //       ),
// //       floatingActionButton: FloatingActionButton(
// //         onPressed: () => Navigator.push(
// //           context,
// //           MaterialPageRoute(builder: (_) => const AddTransactionPage()),
// //         ),
// //         child: const Icon(Icons.add),
// //       ),
// //     );
// //   }
// // }

// // class _TxTile extends ConsumerWidget {
// //   final TransactionModel tx;
// //   const _TxTile({required this.tx});

// //   @override
// //   Widget build(BuildContext context, WidgetRef ref) {
// //     final notifier = ref.read(transactionsProvider.notifier);

// //     return ListTile(
// //       leading: Icon(
// //         tx.type == TransactionType.income ? Icons.south_west : Icons.north_east,
// //         color: tx.type == TransactionType.income ? Colors.green : Colors.red,
// //       ),
// //       title: Text(tx.title),
// //       subtitle: Text(
// //         '${tx.category ?? 'Uncategorised'} • ${tx.account ?? 'No Account'}',
// //       ),
// //       trailing: Text(
// //         '₹${tx.amount.toStringAsFixed(2)}',
// //         style: const TextStyle(fontWeight: FontWeight.bold),
// //       ),
// //       onLongPress: () => showModalBottomSheet(
// //         context: context,
// //         builder: (_) => SafeArea(
// //           child: ListTile(
// //             leading: const Icon(Icons.delete),
// //             title: const Text('Delete'),
// //             onTap: () async {
// //               await notifier.deleteTransaction(tx.id);
// //               if (context.mounted) Navigator.pop(context);
// //             },
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'package:expense_project/core/models/transaction_model.dart';
// import 'package:expense_project/features/transactions/transaction_add_page.dart';
// import 'package:expense_project/features/transactions/transactions_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class TransactionsListPage extends ConsumerWidget {
//   const TransactionsListPage({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final txAsync = ref.watch(transactionsProvider);
//     final isDark = Theme.of(context).brightness == Brightness.dark;

//     // Color Theory Consistent
//     final bg = isDark ? const Color(0xFF1C1C1E) : const Color(0xFFF9F9FF);
//     final surface = isDark ? const Color(0xFF242426) : Colors.white;
//     final textMain = isDark ? Colors.white : Colors.black;
//     final textSec = isDark ? Colors.grey[400] : Colors.grey[600];
//     final primary = const Color(0xFF007AFF);
//     final green = const Color(0xFF34C759);
//     final red = const Color(0xFFFF3B30);

//     return Scaffold(
//       backgroundColor: bg,
//       body: txAsync.when(
//         loading: () => Center(
//           child: CircularProgressIndicator(color: primary, strokeWidth: 2),
//         ),
//         error: (e, _) => Center(
//           child: Text('Error: $e', style: TextStyle(color: red, fontSize: 16)),
//         ),
//         data: (txs) => Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Title section without AppBar
//             SafeArea(
//               top: false,
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(),
//                 child: Row(
//                   children: [
//                     const SizedBox(width: 12),
//                     Text(
//                       'All Transactions',
//                       style: TextStyle(
//                         color: textMain,
//                         fontWeight: FontWeight.w600,
//                         fontSize: 24,
//                         letterSpacing: -1,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             // Content
//             Expanded(
//               child: txs.isEmpty
//                   ? Center(
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(
//                             Icons.receipt_long_rounded,
//                             size: 42,
//                             color: primary.withOpacity(0.18),
//                           ),
//                           const SizedBox(height: 10),
//                           Text(
//                             'No transactions yet',
//                             style: TextStyle(
//                               color: textMain,
//                               fontWeight: FontWeight.w500,
//                               fontSize: 17,
//                             ),
//                           ),
//                           const SizedBox(height: 6),
//                           Text(
//                             'Tap + to add your first transaction',
//                             style: TextStyle(color: textSec, fontSize: 14),
//                           ),
//                         ],
//                       ),
//                     )
//                   : ListView.separated(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 8,
//                         vertical: 16,
//                       ),
//                       itemCount: txs.length,
//                       separatorBuilder: (_, __) => const SizedBox(height: 10),
//                       itemBuilder: (_, i) => _TxTile(
//                         tx: txs[i],
//                         surface: surface,
//                         textMain: textMain,
//                         textSec: textSec!,
//                         green: green,
//                         red: red,
//                         primary: primary,
//                         isDark: isDark,
//                       ),
//                     ),
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         backgroundColor: primary,
//         elevation: 6,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
//         icon: Icon(Icons.add_rounded, color: Colors.white),
//         label: const Text(
//           'Add',
//           style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
//         ),
//         onPressed: () => Navigator.push(
//           context,
//           MaterialPageRoute(builder: (_) => const AddTransactionPage()),
//         ),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//     );
//   }
// }

// // Transaction Tile with minimalist elegant design
// class _TxTile extends ConsumerWidget {
//   final TransactionModel tx;
//   final Color surface, textMain, textSec, green, red, primary;
//   final bool isDark;

//   const _TxTile({
//     required this.tx,
//     required this.surface,
//     required this.textMain,
//     required this.textSec,
//     required this.green,
//     required this.red,
//     required this.primary,
//     required this.isDark,
//   });

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final notifier = ref.read(transactionsProvider.notifier);
//     final isIncome = tx.type == TransactionType.income;
//     final amountColor = isIncome ? green : red;

//     return Material(
//       color: surface,
//       borderRadius: BorderRadius.circular(16),
//       child: InkWell(
//         borderRadius: BorderRadius.circular(16),
//         onTap: () => showModalBottomSheet(
//           context: context,
//           backgroundColor: surface,
//           shape: const RoundedRectangleBorder(
//             borderRadius: BorderRadius.vertical(top: Radius.circular(26)),
//           ),
//           builder: (_) => SafeArea(
//             child: Padding(
//               padding: const EdgeInsets.all(18),
//               child: ListTile(
//                 leading: Icon(Icons.delete, color: red),
//                 title: const Text('Delete'),
//                 onTap: () async {
//                   await notifier.deleteTransaction(tx.id);
//                   if (context.mounted) Navigator.pop(context);
//                 },
//                 tileColor: surface,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//             ),
//           ),
//         ),
//         child: Container(
//           margin: const EdgeInsets.symmetric(vertical: 1.5),
//           padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(16),
//             color: surface,
//             boxShadow: [
//               BoxShadow(
//                 color: isDark
//                     ? Colors.black.withOpacity(0.09)
//                     : Colors.black.withOpacity(0.03),
//                 blurRadius: 12,
//                 offset: const Offset(0, 3),
//               ),
//             ],
//           ),
//           child: Row(
//             children: [
//               Container(
//                 width: 42,
//                 height: 42,
//                 decoration: BoxDecoration(
//                   color: amountColor.withOpacity(0.09),
//                   borderRadius: BorderRadius.circular(13),
//                 ),
//                 child: Center(
//                   child: Icon(
//                     isIncome ? Icons.south_west : Icons.north_east,
//                     color: amountColor,
//                     size: 22,
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 12),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       tx.title,
//                       style: TextStyle(
//                         color: textMain,
//                         fontWeight: FontWeight.w600,
//                         fontSize: 16,
//                         letterSpacing: -0.4,
//                       ),
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       '${tx.category ?? 'Uncategorised'} • ${tx.account ?? 'No Account'}',
//                       style: TextStyle(
//                         color: textSec,
//                         fontSize: 13.5,
//                         letterSpacing: -0.3,
//                       ),
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(width: 12),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   Text(
//                     '₹${tx.amount.toStringAsFixed(2)}',
//                     style: TextStyle(
//                       color: amountColor,
//                       fontWeight: FontWeight.w700,
//                       fontSize: 15.5,
//                       letterSpacing: -0.8,
//                     ),
//                   ),
//                   const SizedBox(height: 3),
//                   Text(
//                     formatSimpleDate(tx.date),
//                     style: TextStyle(
//                       color: textSec.withOpacity(0.8),
//                       fontSize: 12,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// String formatSimpleDate(DateTime date) {
//   final now = DateTime.now();
//   final diff = now.difference(date).inDays;
//   if (diff == 0) return 'Today';
//   if (diff == 1) return 'Yesterday';
//   if (diff < 7) return '${diff}d ago';
//   return '${date.day}/${date.month}';
// }

import 'package:expense_project/core/models/transaction_model.dart';
import 'package:expense_project/features/transactions/transaction_add_page.dart';
import 'package:expense_project/features/transactions/transactions_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class TransactionsListPage extends ConsumerStatefulWidget {
  const TransactionsListPage({super.key});

  @override
  ConsumerState<TransactionsListPage> createState() =>
      _TransactionsListPageState();
}

class _TransactionsListPageState extends ConsumerState<TransactionsListPage> {
  String _selectedFilter = 'All Time';
  DateTimeRange? _customDateRange;

  @override
  Widget build(BuildContext context) {
    final txAsync = ref.watch(transactionsProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Color Theory Consistent with Dashboard
    final bg = isDark ? const Color(0xFF000000) : const Color(0xFFFFFFFF);
    final surface = isDark ? const Color(0xFF111111) : const Color(0xFFFBFBFB);
    final cardSurface = isDark ? const Color(0xFF1C1C1E) : Colors.white;
    final textMain = isDark ? Colors.white : Colors.black;
    final textSec = isDark ? const Color(0xFF888888) : const Color(0xFF666666);
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
            // Page title and filter section (NO DUPLICATE HEADER)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  Text(
                    'All Transactions',
                    style: TextStyle(
                      color: textMain,
                      fontWeight: FontWeight.w700,
                      fontSize: 24,
                      letterSpacing: -0.8,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Filter chips
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildFilterChip(
                          'All Time',
                          surface,
                          textMain,
                          textSec,
                          accent,
                        ),
                        const SizedBox(width: 8),
                        _buildFilterChip(
                          'Last 7 Days',
                          surface,
                          textMain,
                          textSec,
                          accent,
                        ),
                        const SizedBox(width: 8),
                        _buildFilterChip(
                          'Last 30 Days',
                          surface,
                          textMain,
                          textSec,
                          accent,
                        ),
                        const SizedBox(width: 8),
                        _buildFilterChip(
                          'This Month',
                          surface,
                          textMain,
                          textSec,
                          accent,
                        ),
                        const SizedBox(width: 8),
                        _buildFilterChip(
                          'Custom',
                          surface,
                          textMain,
                          textSec,
                          accent,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Content
            Expanded(
              child: txAsync.when(
                loading: () => Center(
                  child: CircularProgressIndicator(
                    color: accent,
                    strokeWidth: 2,
                  ),
                ),
                error: (e, _) => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error_outline_rounded, size: 48, color: red),
                      const SizedBox(height: 16),
                      Text(
                        'Error loading transactions',
                        style: TextStyle(color: red, fontSize: 16),
                      ),
                    ],
                  ),
                ),
                data: (txs) {
                  final filteredTxs = _filterTransactions(txs);

                  if (filteredTxs.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: accent.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Icon(
                              Icons.receipt_long_outlined,
                              size: 48,
                              color: accent,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            _selectedFilter == 'All Time'
                                ? 'No transactions yet'
                                : 'No transactions found',
                            style: TextStyle(
                              color: textMain,
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _selectedFilter == 'All Time'
                                ? 'Tap + to add your first transaction'
                                : 'Try adjusting your filter criteria',
                            style: TextStyle(color: textSec, fontSize: 14),
                          ),
                        ],
                      ),
                    );
                  }

                  return Column(
                    children: [
                      // Transaction count and summary
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: _buildTransactionSummary(
                          filteredTxs,
                          textMain,
                          textSec,
                          green,
                          red,
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Transactions list
                      Expanded(
                        child: ListView.separated(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          itemCount: filteredTxs.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 12),
                          itemBuilder: (_, i) => _TxTile(
                            tx: filteredTxs[i],
                            surface: cardSurface,
                            textMain: textMain,
                            textSec: textSec,
                            green: green,
                            red: red,
                            accent: accent,
                            isDark: isDark,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),

            const SizedBox(height: 80), // Space for FAB
          ],
        ),
      ),
      floatingActionButton: Container(
        margin: const EdgeInsets.only(bottom: 16),
        child: FloatingActionButton.extended(
          backgroundColor: accent,
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          icon: Icon(Icons.add_rounded, color: Colors.white, size: 22),
          label: const Text(
            'Add Transaction',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
          onPressed: () => showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) => const AddTransactionPage(),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildFilterChip(
    String label,
    Color surface,
    Color textMain,
    Color textSec,
    Color accent,
  ) {
    final isSelected = _selectedFilter == label;

    return GestureDetector(
      onTap: () async {
        if (label == 'Custom') {
          final dateRange = await showDateRangePicker(
            context: context,
            firstDate: DateTime(2020),
            lastDate: DateTime.now(),
            initialDateRange: _customDateRange,
          );
          if (dateRange != null) {
            setState(() {
              _customDateRange = dateRange;
              _selectedFilter = label;
            });
          }
        } else {
          setState(() {
            _selectedFilter = label;
            _customDateRange = null;
          });
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? accent.withOpacity(0.15) : surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? accent : textSec.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? accent : textSec,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildTransactionSummary(
    List<TransactionModel> transactions,
    Color textMain,
    Color textSec,
    Color green,
    Color red,
  ) {
    final income = transactions
        .where((t) => t.type == TransactionType.income)
        .fold(0.0, (sum, t) => sum + t.amount);
    final expenses = transactions
        .where((t) => t.type == TransactionType.expense)
        .fold(0.0, (sum, t) => sum + t.amount);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: textMain.withOpacity(0.03),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: textSec.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Text(
                  '${transactions.length}',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: textMain,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Transactions',
                  style: TextStyle(fontSize: 12, color: textSec),
                ),
              ],
            ),
          ),
          Container(width: 1, height: 40, color: textSec.withOpacity(0.2)),
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
                const SizedBox(height: 4),
                Text('Income', style: TextStyle(fontSize: 12, color: textSec)),
              ],
            ),
          ),
          Container(width: 1, height: 40, color: textSec.withOpacity(0.2)),
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
                const SizedBox(height: 4),
                Text(
                  'Expenses',
                  style: TextStyle(fontSize: 12, color: textSec),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<TransactionModel> _filterTransactions(
    List<TransactionModel> transactions,
  ) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    switch (_selectedFilter) {
      case 'Last 7 Days':
        final sevenDaysAgo = today.subtract(const Duration(days: 7));
        return transactions
            .where((tx) => tx.date.isAfter(sevenDaysAgo))
            .toList();

      case 'Last 30 Days':
        final thirtyDaysAgo = today.subtract(const Duration(days: 30));
        return transactions
            .where((tx) => tx.date.isAfter(thirtyDaysAgo))
            .toList();

      case 'This Month':
        final firstDayOfMonth = DateTime(now.year, now.month, 1);
        return transactions
            .where(
              (tx) => tx.date.isAfter(
                firstDayOfMonth.subtract(const Duration(days: 1)),
              ),
            )
            .toList();

      case 'Custom':
        if (_customDateRange != null) {
          return transactions
              .where(
                (tx) =>
                    tx.date.isAfter(
                      _customDateRange!.start.subtract(const Duration(days: 1)),
                    ) &&
                    tx.date.isBefore(
                      _customDateRange!.end.add(const Duration(days: 1)),
                    ),
              )
              .toList();
        }
        return transactions;

      default:
        return transactions;
    }
  }
}

// Enhanced Transaction Tile with Edit Support
class _TxTile extends ConsumerWidget {
  final TransactionModel tx;
  final Color surface, textMain, textSec, green, red, accent;
  final bool isDark;

  const _TxTile({
    required this.tx,
    required this.surface,
    required this.textMain,
    required this.textSec,
    required this.green,
    required this.red,
    required this.accent,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(transactionsProvider.notifier);
    final isIncome = tx.type == TransactionType.income;
    final amountColor = isIncome ? green : red;

    return Dismissible(
      key: Key(tx.id),
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
        return await showDialog<bool>(
              context: context,
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
                    color: textMain,
                  ),
                ),
                content: Text(
                  'Delete "${tx.title}"? This cannot be undone.',
                  style: TextStyle(fontSize: 14, color: textSec),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        color: textSec,
                        fontWeight: FontWeight.w500,
                      ),
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
      onDismissed: (direction) async {
        await notifier.deleteTransaction(tx.id);
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  Icon(
                    Icons.check_circle_rounded,
                    color: Colors.white,
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  Text('Transaction deleted'),
                ],
              ),
              backgroundColor: green,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              duration: Duration(seconds: 2),
            ),
          );
        }
      },
      child: GestureDetector(
        onTap: () => showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (context) => AddTransactionPage(existingTransaction: tx),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: surface,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(isDark ? 0.3 : 0.06),
                blurRadius: 12,
                offset: const Offset(0, 2),
              ),
            ],
            border: Border.all(color: amountColor.withOpacity(0.1), width: 1),
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: amountColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Center(
                  child: Icon(
                    isIncome
                        ? Icons.arrow_upward_rounded
                        : Icons.arrow_downward_rounded,
                    color: amountColor,
                    size: 22,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tx.title,
                      style: TextStyle(
                        color: textMain,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        letterSpacing: -0.4,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${tx.category ?? 'Uncategorised'} • ${tx.account ?? 'No Account'}',
                      style: TextStyle(
                        color: textSec,
                        fontSize: 13.5,
                        letterSpacing: -0.3,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${isIncome ? '+' : '-'}₹${tx.amount.toStringAsFixed(0)}',
                    style: TextStyle(
                      color: amountColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      letterSpacing: -0.8,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    formatSimpleDate(tx.date),
                    style: TextStyle(
                      color: textSec.withOpacity(0.8),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.keyboard_arrow_right_rounded,
                color: textSec.withOpacity(0.3),
                size: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String formatSimpleDate(DateTime date) {
  final now = DateTime.now();
  final diff = now.difference(date).inDays;
  if (diff == 0) return 'Today';
  if (diff == 1) return 'Yesterday';
  if (diff < 7) return '${diff}d ago';
  return '${date.day}/${date.month}/${date.year}';
}
