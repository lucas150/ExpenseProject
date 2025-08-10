// lib/features/dashboard/widgets/modern_transaction_list.dart

import 'package:flutter/material.dart';

import '../../../core/models/transaction_model.dart';

// class ModernTransactionList extends ConsumerWidget {
// final List<TransactionModel> transactions;
//
//   const ModernTransactionList({super.key, required this.transactions});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final currency = ref.watch(currencyProvider);

//     return SliverList(
//       delegate: SliverChildBuilderDelegate((context, index) {
//         final transaction = transactions[index];
//         return Padding(
//           padding: const EdgeInsets.only(bottom: 8),
//           child: _TransactionCard(transaction: transaction, currency: currency),
//         );
//       }, childCount: transactions.length),
//     );
//   }
// }

// class _TransactionCard extends StatelessWidget {
//   final TransactionModel transaction;
//   final Currency currency;

//   const _TransactionCard({required this.transaction, required this.currency});

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final isIncome = transaction.type == TransactionType.income;
//     final color = isIncome
//         ? theme.colorScheme.primary
//         : theme.colorScheme.error;

//     return Card(
//       child: InkWell(
//         onTap: () => _editTransaction(context),
//         borderRadius: BorderRadius.circular(16),
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Row(
//             children: [
//               // Transaction Icon
//               Container(
//                 padding: const EdgeInsets.all(12),
//                 decoration: BoxDecoration(
//                   color: color.withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Icon(
//                   isIncome ? Icons.trending_up : Icons.trending_down,
//                   color: color,
//                   size: 24,
//                 ),
//               ),

//               const SizedBox(width: 16),

//               // Transaction Details
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       transaction.title,
//                       style: theme.textTheme.titleMedium?.copyWith(
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                     const SizedBox(height: 4),
//                     Row(
//                       children: [
//                         if (transaction.category != null) ...[
//                           Container(
//                             padding: const EdgeInsets.symmetric(
//                               horizontal: 8,
//                               vertical: 2,
//                             ),
//                             decoration: BoxDecoration(
//                               color: theme.colorScheme.surfaceVariant,
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             child: Text(
//                               transaction.category!,
//                               style: theme.textTheme.bodySmall?.copyWith(
//                                 color: theme.colorScheme.onSurfaceVariant,
//                               ),
//                             ),
//                           ),
//                           const SizedBox(width: 8),
//                         ],
//                         Text(
//                           _formatDate(transaction.date),
//                           style: theme.textTheme.bodySmall?.copyWith(
//                             color: theme.colorScheme.onSurfaceVariant,
//                           ),
//                         ),
//                       ],
//                     ),
//                     if (transaction.account != null) ...[
//                       const SizedBox(height: 2),
//                       Text(
//                         transaction.account!,
//                         style: theme.textTheme.bodySmall?.copyWith(
//                           color: theme.colorScheme.onSurfaceVariant,
//                         ),
//                       ),
//                     ],
//                   ],
//                 ),
//               ),

//               // Amount
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   Text(
//                     '${currency.symbol}${transaction.amount.toStringAsFixed(2)}',
//                     style: theme.textTheme.titleMedium?.copyWith(
//                       fontWeight: FontWeight.bold,
//                       color: color,
//                     ),
//                   ),
//                   Icon(
//                     Icons.edit,
//                     size: 16,
//                     color: theme.colorScheme.onSurfaceVariant,
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void _editTransaction(BuildContext context) {
//     Navigator.of(context).push(
//       MaterialPageRoute(
//         builder: (context) => EditTransactionPage(transaction: transaction),
//       ),
//     );
//   }

//   String _formatDate(DateTime date) {
//     return '${date.day}/${date.month}/${date.year}';
//   }
// }


class ModernTransactionList extends StatelessWidget {
  late final List<TransactionModel> transactions;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: transactions.length,
      separatorBuilder: (_, __) => Divider(height: 1, color: Colors.grey[300]),
      itemBuilder: (_, index) {
        final t = transactions[index];
        return ListTile(
          leading: Icon(
            t.type == TransactionType.income
                ? Icons.arrow_downward
                : Icons.arrow_upward,
          ),
          title: Text(
            t.title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          subtitle: Text('${t.category ?? ''} • ${t.account ?? ''}'),
          trailing: Text('₹${t.amount.toStringAsFixed(0)}'),
        );
      },
    );
  }
}
