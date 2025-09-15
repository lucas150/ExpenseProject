// // // import 'package:flutter/material.dart';
// // // import '../../../core/models/account_model.dart';

// // // class AccountCard extends StatelessWidget {
// // //   final Account account;
// // //   const AccountCard({super.key, required this.account});

// // //   @override
// // //   Widget build(BuildContext context) => Card(
// // //     child: ListTile(
// // //       leading: const Icon(Icons.account_balance_wallet),
// // //       title: Text(account.name),
// // //       subtitle: Text(account.type),
// // //       trailing: Text(
// // //         '₹${account.balance.toStringAsFixed(2)}',
// // //         style: const TextStyle(fontWeight: FontWeight.bold),
// // //       ),
// // //     ),
// // //   );
// // // }

// // import 'package:flutter/material.dart';
// // import '../../../core/models/account_model.dart';

// // class AccountCard extends StatelessWidget {
// //   final Account account;
// //   const AccountCard({super.key, required this.account});

// //   IconData _getAccountIcon(String type) {
// //     switch (type.toLowerCase()) {
// //       case 'cash':
// //         return Icons.payments_outlined;
// //       case 'bank':
// //         return Icons.account_balance_outlined;
// //       case 'wallet':
// //         return Icons.account_balance_wallet_outlined;
// //       default:
// //         return Icons.account_balance_wallet_outlined;
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     final isPositive = account.balance >= 0;

// //     return Container(
// //       padding: const EdgeInsets.all(20),
// //       decoration: BoxDecoration(
// //         color: Theme.of(context).colorScheme.surface,
// //         borderRadius: BorderRadius.circular(12),
// //         border: Border.all(
// //           color: Theme.of(context).colorScheme.onSurface.withOpacity(0.08),
// //           width: 1,
// //         ),
// //       ),
// //       child: Row(
// //         children: [
// //           // Icon with subtle background
// //           Container(
// //             width: 44,
// //             height: 44,
// //             decoration: BoxDecoration(
// //               color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
// //               borderRadius: BorderRadius.circular(22),
// //             ),
// //             child: Icon(
// //               _getAccountIcon(account.type),
// //               size: 22,
// //               color: Theme.of(context).colorScheme.primary,
// //             ),
// //           ),

// //           const SizedBox(width: 16),

// //           // Account info
// //           Expanded(
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 Text(
// //                   account.name,
// //                   style: TextStyle(
// //                     fontSize: 16,
// //                     fontWeight: FontWeight.w600,
// //                     color: Theme.of(context).colorScheme.onSurface,
// //                   ),
// //                 ),
// //                 const SizedBox(height: 2),
// //                 Text(
// //                   account.type,
// //                   style: TextStyle(
// //                     fontSize: 13,
// //                     color: Theme.of(
// //                       context,
// //                     ).colorScheme.onSurface.withOpacity(0.5),
// //                     fontWeight: FontWeight.w400,
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),

// //           // Balance
// //           Text(
// //             '₹${account.balance.abs().toStringAsFixed(account.balance % 1 == 0 ? 0 : 2)}',
// //             style: TextStyle(
// //               fontSize: 16,
// //               fontWeight: FontWeight.w600,
// //               color: isPositive
// //                   ? Theme.of(context).colorScheme.onSurface
// //                   : Colors.red.shade600,
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import '../../../core/models/account_model.dart';

// class AccountCard extends StatelessWidget {
//   final Account account;
//   final Color surface;
//   final Color text1;
//   final Color text2;
//   final Color accent;

//   const AccountCard({
//     super.key,
//     required this.account,
//     required this.surface,
//     required this.text1,
//     required this.text2,
//     required this.accent,
//   });

//   IconData _getAccountIcon(String type) {
//     switch (type.toLowerCase()) {
//       case 'cash':
//         return Icons.payments_outlined;
//       case 'bank':
//         return Icons.account_balance_outlined;
//       case 'wallet':
//         return Icons.account_balance_wallet_outlined;
//       default:
//         return Icons.account_balance_wallet_outlined;
//     }
//   }

//   String _getAccountEmoji(String type) {
//     switch (type.toLowerCase()) {
//       case 'cash':
//         return '💵';
//       case 'bank':
//         return '🏦';
//       case 'wallet':
//         return '👛';
//       default:
//         return '💳';
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final isPositive = account.balance >= 0;

//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: surface,
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(color: accent.withOpacity(0.1), width: 1),
//       ),
//       child: Row(
//         children: [
//           // Account icon/emoji
//           Container(
//             width: 48,
//             height: 48,
//             decoration: BoxDecoration(
//               color: accent.withOpacity(0.1),
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Center(
//               child: Text(
//                 _getAccountEmoji(account.type),
//                 style: const TextStyle(fontSize: 24),
//               ),
//             ),
//           ),

//           const SizedBox(width: 16),

//           // Account info
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   account.name,
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                     color: text1,
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   account.type,
//                   style: TextStyle(
//                     fontSize: 13,
//                     color: text2.withOpacity(0.8),
//                     fontWeight: FontWeight.w400,
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           // Balance
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: [
//               Text(
//                 '₹${account.balance.abs().toStringAsFixed(account.balance % 1 == 0 ? 0 : 2)}',
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w600,
//                   color: isPositive ? text1 : const Color(0xFFFF3B30),
//                 ),
//               ),
//               if (!isPositive) const SizedBox(height: 2),
//               if (!isPositive)
//                 Container(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 6,
//                     vertical: 2,
//                   ),
//                   decoration: BoxDecoration(
//                     color: const Color(0xFFFF3B30).withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(4),
//                   ),
//                   child: Text(
//                     'Overdrawn',
//                     style: TextStyle(
//                       fontSize: 10,
//                       color: const Color(0xFFFF3B30),
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import '../../../core/models/account_model.dart';

class AccountCard extends StatelessWidget {
  final Account account;
  final Color surface;
  final Color text1;
  final Color text2;
  final Color accent;
  final VoidCallback? onDelete;
  final VoidCallback? onTap;

  const AccountCard({
    super.key,
    required this.account,
    required this.surface,
    required this.text1,
    required this.text2,
    required this.accent,
    this.onDelete,
    this.onTap,
  });

  String _getAccountEmoji(String type) {
    switch (type.toLowerCase()) {
      case 'cash':
        return '💵';
      case 'bank':
        return '🏦';
      case 'wallet':
        return '👛';
      default:
        return '💳';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(account.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          color: const Color(0xFFFF3B30),
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(Icons.delete_outline, color: Colors.white, size: 24),
            SizedBox(width: 8),
            Text(
              'Delete',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 16,
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
                  'Delete Account',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: text1,
                  ),
                ),
                content: Text(
                  'Are you sure you want to delete "${account.name}"? This action cannot be undone.',
                  style: TextStyle(fontSize: 14, color: text2),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        color: text2,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: Text(
                      'Delete',
                      style: TextStyle(
                        color: const Color(0xFFFF3B30),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ) ??
            false;
      },
      onDismissed: (direction) => onDelete?.call(),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.symmetric(vertical: 4),
          decoration: BoxDecoration(
            color: surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: accent.withOpacity(0.1), width: 1),
          ),
          child: Row(
            children: [
              // Account icon/emoji
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: accent.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    _getAccountEmoji(account.type),
                    style: const TextStyle(fontSize: 24),
                  ),
                ),
              ),

              const SizedBox(width: 16),

              // Account info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      account.name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: text1,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      account.type,
                      style: TextStyle(
                        fontSize: 13,
                        color: text2.withOpacity(0.8),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),

              // Balance
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '₹${account.balance.abs().toStringAsFixed(account.balance % 1 == 0 ? 0 : 2)}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: account.balance >= 0
                          ? text1
                          : const Color(0xFFFF3B30),
                    ),
                  ),
                  if (account.balance < 0) ...[
                    const SizedBox(height: 2),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF3B30).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'Overdrawn',
                        style: TextStyle(
                          fontSize: 10,
                          color: const Color(0xFFFF3B30),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ],
              ),

              // Subtle hint arrow
              const SizedBox(width: 8),
              Icon(
                Icons.keyboard_arrow_right,
                color: text2.withOpacity(0.3),
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
