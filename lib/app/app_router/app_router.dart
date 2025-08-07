// import 'package:expense_project/features/dashboard/dashboard_page.dart';
// import 'package:expense_project/features/transactions/transaction_add_page.dart';
// import 'package:expense_project/features/transactions/transactions_list_page.dart';
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import '../../features/onboarding/onboarding_page.dart';
// import '../../features/dashboard/dashboard_page.dart';
// import '../../features/accounts/accounts_page.dart';
// import '../../features/categories/categories_page.dart';
// import '../../features/bills/bills_page.dart';
// import '../../features/analytics/analytics_page.dart';
// import '../../features/settings/settings_page.dart';

// // ────── Feature imports ──────

// import '../widgets/in_progress_page.dart';

// final routerProvider = GoRouter(
//   initialLocation: '/onboarding',
//   routes: [
//     GoRoute(path: '/onboarding', builder: (_, __) => const OnboardingPage()),

//     /// Main shell – bottom-nav layout
//     ShellRoute(
//       builder: (ctx, state, child) => _MainScaffold(child: child),
//       routes: [
//         /// DASHBOARD
//         GoRoute(
//           path: '/dashboard',
//           pageBuilder: (_, __) =>
//               const NoTransitionPage(child: DashboardPage()),
//         ),

//         /// TRANSACTIONS
//         GoRoute(
//           path: '/transactions',
//           builder: (_, __) => const TransactionsListPage(),
//           routes: [
//             GoRoute(
//               path: 'add',
//               builder: (_, __) => const AddTransactionPage(),
//             ),
//             // future: '/transactions/:id/edit'
//           ],
//         ),

//         /// ACCOUNTS (optional)
//         GoRoute(path: '/accounts', builder: (_, __) => const AccountsPage()),

//         /// CATEGORIES
//         GoRoute(
//           path: '/categories',
//           builder: (_, __) => const CategoriesPage(),
//         ),

//         /// BILLS
//         GoRoute(path: '/bills', builder: (_, __) => const BillsPage()),

//         /// ANALYTICS
//         GoRoute(path: '/analytics', builder: (_, __) => const AnalyticsPage()),

//         /// SETTINGS
//         GoRoute(path: '/settings', builder: (_, __) => const SettingsPage()),
//       ],
//     ),

//     /// CATCH-ALL
//     GoRoute(
//       path: '/:splash(.*)',
//       builder: (_, __) => const InProgressPage(title: 'Not Found'),
//     ),
//   ],
// );

// // import 'package:flutter/material.dart';
// // import 'package:go_router/go_router.dart';

// class _MainScaffold extends StatefulWidget {
//   final Widget child;
//   const _MainScaffold({required this.child});

//   @override
//   State<_MainScaffold> createState() => _MainScaffoldState();
// }

// class _MainScaffoldState extends State<_MainScaffold> {
//   static const _tabs = [
//     '/dashboard',
//     '/transactions',
//     '/accounts',
//     '/analytics',
//     '/settings',
//   ];

//   int get _index =>
//       _tabs.indexOf(GoRouterState.of(context).uri.toString().split('?').first);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: widget.child,
//       bottomNavigationBar: NavigationBar(
//         selectedIndex: _index < 0 ? 0 : _index,
//         onDestinationSelected: (i) => context.go(_tabs[i]),
//         destinations: const [
//           NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
//           NavigationDestination(icon: Icon(Icons.list), label: 'Txns'),
//           NavigationDestination(
//             icon: Icon(Icons.account_balance_wallet),
//             label: 'Accounts',
//           ),
//           NavigationDestination(icon: Icon(Icons.bar_chart), label: 'Stats'),
//           NavigationDestination(icon: Icon(Icons.settings), label: 'Settings'),
//         ],
//       ),
//     );
//   }
// }

import 'package:expense_project/features/accounts/accounts_page.dart';
import 'package:expense_project/features/analytics/analytics_page.dart';
import 'package:expense_project/features/bills/bills_page.dart';
import 'package:expense_project/features/categories/categories_page.dart';
import 'package:expense_project/features/settings/modern_settings_page.dart';
import 'package:expense_project/features/transactions/transaction_add_page.dart';
import 'package:expense_project/features/transactions/transactions_list_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// ────── Feature imports ──────
import '../../features/onboarding/onboarding_page.dart';
import '../../features/dashboard/dashboard_page.dart';

import '../widgets/in_progress_page.dart';

final routerProvider = GoRouter(
  initialLocation: '/onboarding',
  routes: [
    GoRoute(path: '/onboarding', builder: (_, __) => const OnboardingPage()),

    /// Main shell – bottom-nav layout
    ShellRoute(
      builder: (ctx, state, child) => _MainScaffold(child: child),
      routes: [
        /// DASHBOARD
        GoRoute(
          path: '/dashboard',
          pageBuilder: (_, __) =>
              const NoTransitionPage(child: ModernDashboardPage()),
        ),

        /// TRANSACTIONS
        GoRoute(
          path: '/transactions',
          builder: (_, __) => const TransactionsListPage(),
          routes: [
            GoRoute(
              path: 'add',
              builder: (_, __) => const AddTransactionPage(),
            ),
          ],
        ),

        /// ACCOUNTS (optional)
        GoRoute(path: '/accounts', builder: (_, __) => const AccountsPage()),

        /// CATEGORIES
        GoRoute(
          path: '/categories',
          builder: (_, __) => const CategoriesPage(),
        ),

        /// BILLS
        GoRoute(path: '/bills', builder: (_, __) => const BillsPage()),

        /// ANALYTICS
        GoRoute(path: '/analytics', builder: (_, __) => const AnalyticsPage()),

        /// SETTINGS
        GoRoute(
          path: '/settings',
          builder: (_, __) => const ModernSettingsPage(),
        ),
      ],
    ),

    /// CATCH-ALL
    GoRoute(
      path: '/:splash(.*)',
      builder: (_, __) => const InProgressPage(title: 'Not Found'),
    ),
  ],
);

// ────── _MainScaffold Class (Bottom Navigation) ──────
class _MainScaffold extends StatefulWidget {
  final Widget child;
  const _MainScaffold({required this.child});

  @override
  State<_MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<_MainScaffold> {
  static const _tabs = [
    '/dashboard',
    '/transactions',
    '/accounts',
    '/analytics',
    '/settings',
  ];

  int get _index {
    final currentPath = GoRouterState.of(
      context,
    ).uri.toString().split('?').first;
    final index = _tabs.indexOf(currentPath);
    return index < 0 ? 0 : index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => context.go(_tabs[i]),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.list), label: 'Txns'),
          NavigationDestination(
            icon: Icon(Icons.account_balance_wallet),
            label: 'Accounts',
          ),
          NavigationDestination(icon: Icon(Icons.bar_chart), label: 'Stats'),
          NavigationDestination(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}
