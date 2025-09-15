// // // import 'package:expense_project/features/accounts/accounts_provider.dart';
// // // import 'package:expense_project/features/accounts/widgets/account_card.dart';
// // // import 'package:expense_project/features/accounts/widgets/account_form.dart';
// // // import 'package:flutter/material.dart';
// // // import 'package:flutter_riverpod/flutter_riverpod.dart';
// // // import '../../../core/models/account_model.dart';

// // // class AccountsPage extends ConsumerWidget {
// // //   const AccountsPage({super.key});

// // //   @override
// // //   Widget build(BuildContext context, WidgetRef ref) {
// // //     final accAsync = ref.watch(accountsProvider);
// // //     final notifier = ref.read(accountsProvider.notifier);

// // //     void _openForm([Account? acc]) => showDialog(
// // //       context: context,
// // //       builder: (_) => AccountForm(
// // //         existing: acc,
// // //         onSubmit: (a) async {
// // //           acc == null
// // //               ? await notifier.addAccount(a)
// // //               : await notifier.updateAccount(a);
// // //         },
// // //       ),
// // //     );

// // //     return Scaffold(
// // //       appBar: AppBar(title: const Text('Accounts')),
// // //       body: accAsync.when(
// // //         loading: () => const Center(child: CircularProgressIndicator()),
// // //         error: (e, _) => Center(child: Text('Error: $e')),
// // //         data: (list) => list.isEmpty
// // //             ? const Center(child: Text('No accounts yet'))
// // //             : ListView(
// // //                 padding: const EdgeInsets.all(12),
// // //                 children: list
// // //                     .map(
// // //                       (a) => GestureDetector(
// // //                         onLongPress: () => notifier.deleteAccount(a.id),
// // //                         onTap: () => _openForm(a),
// // //                         child: AccountCard(account: a),
// // //                       ),
// // //                     )
// // //                     .toList(),
// // //               ),
// // //       ),
// // //       floatingActionButton: FloatingActionButton(
// // //         onPressed: () => _openForm(),
// // //         child: const Icon(Icons.add),
// // //       ),
// // //     );
// // //   }
// // // }

// // import 'package:expense_project/features/accounts/accounts_provider.dart';
// // import 'package:expense_project/features/accounts/widgets/account_card.dart';
// // import 'package:expense_project/features/accounts/widgets/account_form.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_riverpod/flutter_riverpod.dart';
// // import '../../../core/models/account_model.dart';

// // class AccountsPage extends ConsumerWidget {
// //   const AccountsPage({super.key});

// //   @override
// //   Widget build(BuildContext context, WidgetRef ref) {
// //     final accAsync = ref.watch(accountsProvider);
// //     final notifier = ref.read(accountsProvider.notifier);

// //     void _openForm([Account? acc]) => Navigator.push(
// //       context,
// //       PageRouteBuilder(
// //         pageBuilder: (context, animation, secondaryAnimation) => AccountForm(
// //           existing: acc,
// //           onSubmit: (a) async {
// //             acc == null
// //                 ? await notifier.addAccount(a)
// //                 : await notifier.updateAccount(a);
// //           },
// //         ),
// //         transitionsBuilder: (context, animation, secondaryAnimation, child) {
// //           return SlideTransition(
// //             position: animation.drive(
// //               Tween(
// //                 begin: const Offset(0.0, 1.0),
// //                 end: Offset.zero,
// //               ).chain(CurveTween(curve: Curves.easeOutCubic)),
// //             ),
// //             child: child,
// //           );
// //         },
// //         transitionDuration: const Duration(milliseconds: 300),
// //         barrierColor: Colors.black.withOpacity(0.3),
// //         opaque: false,
// //       ),
// //     );

// //     return Scaffold(
// //       backgroundColor: Theme.of(context).colorScheme.background,
// //       appBar: AppBar(
// //         title: Text(
// //           'Accounts',
// //           style: TextStyle(
// //             fontSize: 20,
// //             fontWeight: FontWeight.w600,
// //             color: Theme.of(context).colorScheme.onBackground,
// //           ),
// //         ),
// //         elevation: 0,
// //         backgroundColor: Theme.of(context).colorScheme.background,
// //         foregroundColor: Theme.of(context).colorScheme.onBackground,
// //         centerTitle: false,
// //       ),
// //       body: accAsync.when(
// //         loading: () => Center(
// //           child: CircularProgressIndicator(
// //             strokeWidth: 2,
// //             color: Theme.of(context).colorScheme.primary,
// //           ),
// //         ),
// //         error: (e, _) => Center(
// //           child: Column(
// //             mainAxisSize: MainAxisSize.min,
// //             children: [
// //               Icon(
// //                 Icons.error_outline,
// //                 size: 48,
// //                 color: Theme.of(
// //                   context,
// //                 ).colorScheme.onBackground.withOpacity(0.4),
// //               ),
// //               const SizedBox(height: 16),
// //               Text(
// //                 'Something went wrong',
// //                 style: TextStyle(
// //                   fontSize: 16,
// //                   color: Theme.of(
// //                     context,
// //                   ).colorScheme.onBackground.withOpacity(0.6),
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //         data: (list) => list.isEmpty
// //             ? Center(
// //                 child: Column(
// //                   mainAxisSize: MainAxisSize.min,
// //                   children: [
// //                     Icon(
// //                       Icons.account_balance_wallet_outlined,
// //                       size: 64,
// //                       color: Theme.of(
// //                         context,
// //                       ).colorScheme.onBackground.withOpacity(0.3),
// //                     ),
// //                     const SizedBox(height: 24),
// //                     Text(
// //                       'No accounts yet',
// //                       style: TextStyle(
// //                         fontSize: 18,
// //                         fontWeight: FontWeight.w500,
// //                         color: Theme.of(
// //                           context,
// //                         ).colorScheme.onBackground.withOpacity(0.6),
// //                       ),
// //                     ),
// //                     const SizedBox(height: 8),
// //                     Text(
// //                       'Add your first account to get started',
// //                       style: TextStyle(
// //                         fontSize: 14,
// //                         color: Theme.of(
// //                           context,
// //                         ).colorScheme.onBackground.withOpacity(0.4),
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               )
// //             : ListView.separated(
// //                 padding: const EdgeInsets.all(24),
// //                 itemCount: list.length,
// //                 separatorBuilder: (context, index) =>
// //                     const SizedBox(height: 12),
// //                 itemBuilder: (context, index) {
// //                   final account = list[index];
// //                   return GestureDetector(
// //                     onTap: () => _openForm(account),
// //                     onLongPress: () =>
// //                         _showDeleteDialog(context, notifier, account),
// //                     child: AccountCard(account: account),
// //                   );
// //                 },
// //               ),
// //       ),
// //       floatingActionButton: FloatingActionButton.extended(
// //         onPressed: () => _openForm(),
// //         backgroundColor: Theme.of(context).colorScheme.primary,
// //         foregroundColor: Theme.of(context).colorScheme.onPrimary,
// //         elevation: 2,
// //         label: const Text(
// //           'Add Account',
// //           style: TextStyle(fontWeight: FontWeight.w500),
// //         ),
// //         icon: const Icon(Icons.add, size: 20),
// //       ),
// //     );
// //   }

// //   void _showDeleteDialog(
// //     BuildContext context,
// //     AccountsNotifier notifier,
// //     Account account,
// //   ) {
// //     showDialog(
// //       context: context,
// //       barrierColor: Colors.black26,
// //       builder: (context) => AlertDialog(
// //         backgroundColor: Theme.of(context).colorScheme.surface,
// //         elevation: 4,
// //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
// //         title: Text(
// //           'Delete Account',
// //           style: TextStyle(
// //             fontSize: 18,
// //             fontWeight: FontWeight.w600,
// //             color: Theme.of(context).colorScheme.onSurface,
// //           ),
// //         ),
// //         content: Text(
// //           'Are you sure you want to delete "${account.name}"? This action cannot be undone.',
// //           style: TextStyle(
// //             fontSize: 14,
// //             color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
// //           ),
// //         ),
// //         actions: [
// //           TextButton(
// //             onPressed: () => Navigator.of(context).pop(),
// //             child: Text(
// //               'Cancel',
// //               style: TextStyle(
// //                 color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
// //                 fontWeight: FontWeight.w500,
// //               ),
// //             ),
// //           ),
// //           TextButton(
// //             onPressed: () {
// //               Navigator.of(context).pop();
// //               notifier.deleteAccount(account.id);
// //             },
// //             child: Text(
// //               'Delete',
// //               style: TextStyle(
// //                 color: Colors.red.shade600,
// //                 fontWeight: FontWeight.w500,
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// import 'package:expense_project/features/accounts/accounts_provider.dart';
// import 'package:expense_project/features/accounts/widgets/account_card.dart';
// import 'package:expense_project/features/accounts/widgets/account_form.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../../../core/models/account_model.dart';

// class AccountsPage extends ConsumerWidget {
//   const AccountsPage({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final accAsync = ref.watch(accountsProvider);
//     final notifier = ref.read(accountsProvider.notifier);

//     // Match your exact color theme
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//     const accent = Color(0xFF007AFF);
//     final surface = isDark ? const Color(0xFF1C1C1E) : Colors.white;
//     final bgColor = isDark ? const Color(0xFF000000) : const Color(0xFFFFFFFF);
//     final text1 = isDark ? Colors.white : Colors.black;
//     final text2 = isDark ? Colors.grey[500]! : Colors.grey[700]!;

//     void _openForm([Account? acc]) => Navigator.push(
//       context,
//       PageRouteBuilder(
//         pageBuilder: (context, animation, secondaryAnimation) => AccountForm(
//           existing: acc,
//           onSubmit: (a) async {
//             acc == null
//                 ? await notifier.addAccount(a)
//                 : await notifier.updateAccount(a);
//           },
//         ),
//         transitionsBuilder: (context, animation, secondaryAnimation, child) {
//           return SlideTransition(
//             position: animation.drive(
//               Tween(
//                 begin: const Offset(0.0, 1.0),
//                 end: Offset.zero,
//               ).chain(CurveTween(curve: Curves.easeOutCubic)),
//             ),
//             child: child,
//           );
//         },
//         transitionDuration: const Duration(milliseconds: 300),
//         barrierColor: Colors.black.withOpacity(0.3),
//         opaque: false,
//       ),
//     );

//     return Scaffold(
//       backgroundColor: bgColor,
//       body: accAsync.when(
//         loading: () => Center(
//           child: CircularProgressIndicator(strokeWidth: 2, color: accent),
//         ),
//         error: (e, _) => Center(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Icon(
//                 Icons.error_outline,
//                 size: 48,
//                 color: text2.withOpacity(0.4),
//               ),
//               const SizedBox(height: 16),
//               Text(
//                 'Something went wrong',
//                 style: TextStyle(fontSize: 16, color: text2.withOpacity(0.6)),
//               ),
//             ],
//           ),
//         ),
//         data: (list) => list.isEmpty
//             ? Center(
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Icon(
//                       Icons.account_balance_wallet_outlined,
//                       size: 64,
//                       color: text2.withOpacity(0.3),
//                     ),
//                     const SizedBox(height: 24),
//                     Text(
//                       'No accounts yet',
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.w500,
//                         color: text1.withOpacity(0.8),
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     Text(
//                       'Add your first account to get started',
//                       style: TextStyle(
//                         fontSize: 14,
//                         color: text2.withOpacity(0.6),
//                       ),
//                     ),
//                     const SizedBox(height: 32),
//                     // Add account button inline
//                     GestureDetector(
//                       onTap: () => _openForm(),
//                       child: Container(
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 24,
//                           vertical: 12,
//                         ),
//                         decoration: BoxDecoration(
//                           color: accent,
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             Icon(Icons.add, color: Colors.white, size: 20),
//                             const SizedBox(width: 8),
//                             Text(
//                               'Add Account',
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               )
//             : Column(
//                 children: [
//                   // Balance header
//                   Container(
//                     margin: const EdgeInsets.fromLTRB(20, 0, 20, 16),
//                     padding: const EdgeInsets.all(20),
//                     decoration: BoxDecoration(
//                       color: surface,
//                       borderRadius: BorderRadius.circular(16),
//                       border: Border.all(
//                         color: accent.withOpacity(0.1),
//                         width: 1,
//                       ),
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               'Total Balance',
//                               style: TextStyle(
//                                 fontSize: 14,
//                                 color: text2,
//                                 fontWeight: FontWeight.w400,
//                               ),
//                             ),
//                             const SizedBox(height: 4),
//                             Text(
//                               '₹${notifier.totalBalance.toStringAsFixed(2)}',
//                               style: TextStyle(
//                                 fontSize: 24,
//                                 fontWeight: FontWeight.w600,
//                                 color: text1,
//                               ),
//                             ),
//                           ],
//                         ),
//                         GestureDetector(
//                           onTap: () => _openForm(),
//                           child: Container(
//                             padding: const EdgeInsets.all(12),
//                             decoration: BoxDecoration(
//                               color: accent.withOpacity(0.1),
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             child: Icon(Icons.add, color: accent, size: 20),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),

//                   // Accounts list
//                   Expanded(
//                     child: ListView.separated(
//                       padding: const EdgeInsets.symmetric(horizontal: 20),
//                       itemCount: list.length,
//                       separatorBuilder: (context, index) =>
//                           const SizedBox(height: 8),
//                       itemBuilder: (context, index) {
//                         final account = list[index];
//                         return GestureDetector(
//                           onTap: () => _openForm(account),
//                           onLongPress: () => _showDeleteDialog(
//                             context,
//                             notifier,
//                             account,
//                             surface,
//                             text1,
//                             text2,
//                             accent,
//                           ),
//                           child: AccountCard(
//                             account: account,
//                             surface: surface,
//                             text1: text1,
//                             text2: text2,
//                             accent: accent,
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//       ),
//     );
//   }

//   void _showDeleteDialog(
//     BuildContext context,
//     AccountsNotifier notifier,
//     Account account,
//     Color surface,
//     Color text1,
//     Color text2,
//     Color accent,
//   ) {
//     showDialog(
//       context: context,
//       barrierColor: Colors.black26,
//       builder: (context) => AlertDialog(
//         backgroundColor: surface,
//         elevation: 8,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//         title: Text(
//           'Delete Account',
//           style: TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.w600,
//             color: text1,
//           ),
//         ),
//         content: Text(
//           'Are you sure you want to delete "${account.name}"? This action cannot be undone.',
//           style: TextStyle(fontSize: 14, color: text2),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(),
//             child: Text(
//               'Cancel',
//               style: TextStyle(color: text2, fontWeight: FontWeight.w500),
//             ),
//           ),
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//               notifier.deleteAccount(account.id);
//             },
//             child: Text(
//               'Delete',
//               style: TextStyle(
//                 color: const Color(0xFFFF3B30), // iOS red
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:expense_project/features/accounts/accounts_provider.dart';
import 'package:expense_project/features/accounts/widgets/account_card.dart';
import 'package:expense_project/features/accounts/widgets/account_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/account_model.dart';

class AccountsPage extends ConsumerWidget {
  const AccountsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accAsync = ref.watch(accountsProvider);
    final notifier = ref.read(accountsProvider.notifier);

    // Match your exact color theme
    final isDark = Theme.of(context).brightness == Brightness.dark;
    const accent = Color(0xFF007AFF);
    final surface = isDark ? const Color(0xFF1C1C1E) : Colors.white;
    final bgColor = isDark ? const Color(0xFF000000) : const Color(0xFFFFFFFF);
    final text1 = isDark ? Colors.white : Colors.black;
    final text2 = isDark ? Colors.grey[500]! : Colors.grey[700]!;

    void _openForm([Account? acc]) => Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => AccountForm(
          existing: acc,
          onSubmit: (a) async {
            acc == null
                ? await notifier.addAccount(a)
                : await notifier.updateAccount(a);
          },
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: animation.drive(
              Tween(
                begin: const Offset(0.0, 1.0),
                end: Offset.zero,
              ).chain(CurveTween(curve: Curves.easeOutCubic)),
            ),
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 300),
        barrierColor: Colors.black.withOpacity(0.3),
        opaque: false,
      ),
    );

    return Scaffold(
      backgroundColor: bgColor,
      body: accAsync.when(
        loading: () => Center(
          child: CircularProgressIndicator(strokeWidth: 2, color: accent),
        ),
        error: (e, _) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.error_outline,
                size: 48,
                color: text2.withOpacity(0.4),
              ),
              const SizedBox(height: 16),
              Text(
                'Something went wrong',
                style: TextStyle(fontSize: 16, color: text2.withOpacity(0.6)),
              ),
            ],
          ),
        ),
        data: (list) => list.isEmpty
            ? Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.account_balance_wallet_outlined,
                      size: 64,
                      color: text2.withOpacity(0.3),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'No accounts yet',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: text1.withOpacity(0.8),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Add your first account to get started',
                      style: TextStyle(
                        fontSize: 14,
                        color: text2.withOpacity(0.6),
                      ),
                    ),
                    const SizedBox(height: 32),
                    // Add account button inline
                    GestureDetector(
                      onTap: () => _openForm(),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: accent,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.add, color: Colors.white, size: 20),
                            const SizedBox(width: 8),
                            Text(
                              'Add Account',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Column(
                children: [
                  // Balance header with swipe hint
                  Container(
                    margin: const EdgeInsets.fromLTRB(20, 0, 20, 8),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: surface,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: accent.withOpacity(0.1),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Total Balance',
                              style: TextStyle(
                                fontSize: 14,
                                color: text2,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '₹${notifier.totalBalance.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                color: text1,
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () => _openForm(),
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: accent.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(Icons.add, color: accent, size: 20),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Swipe hint
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Icon(
                          Icons.swipe_left,
                          size: 16,
                          color: text2.withOpacity(0.5),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'Swipe left to delete accounts',
                          style: TextStyle(
                            fontSize: 12,
                            color: text2.withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Accounts list
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        final account = list[index];
                        return AccountCard(
                          account: account,
                          surface: surface,
                          text1: text1,
                          text2: text2,
                          accent: accent,
                          onTap: () => _openForm(account),
                          onDelete: () => notifier.deleteAccount(account.id),
                        );
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
