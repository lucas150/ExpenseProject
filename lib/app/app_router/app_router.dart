// import 'package:expense_project/features/accounts/accounts_page.dart';
// import 'package:expense_project/features/analytics/analytics_page.dart';
// import 'package:expense_project/features/bills/bills_page.dart';
// import 'package:expense_project/features/categories/categories_page.dart';
// import 'package:expense_project/features/settings/modern_settings_page.dart';
// import 'package:expense_project/features/transactions/transaction_add_page.dart';
// import 'package:expense_project/features/transactions/transactions_list_page.dart';
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';

// import '../../features/onboarding/onboarding_page.dart';
// import '../../features/dashboard/dashboard_page.dart';
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
//           pageBuilder: (context, state) =>
//               const NoTransitionPage(child: ModernDashboardPage()),
//           routes: [
//             GoRoute(
//               path: 'add', // becomes /dashboard/add
//               builder: (context, state) => const AddTransactionPage(),
//             ),
//           ],
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
//         GoRoute(
//           path: '/settings',
//           builder: (_, __) => const ModernSettingsPage(),
//         ),
//       ],
//     ),

//     /// CATCH-ALL
//     GoRoute(
//       path: '/:splash(.*)',
//       builder: (_, __) => const InProgressPage(title: 'Not Found'),
//     ),
//   ],
// );

// // ────── _MainScaffold Class (Bottom Navigation) ──────
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

//   int get _index {
//     final currentPath = GoRouterState.of(
//       context,
//     ).uri.toString().split('?').first;
//     final index = _tabs.indexOf(currentPath);
//     return index < 0 ? 0 : index;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: widget.child,
//       bottomNavigationBar: NavigationBar(
//         selectedIndex: _index,
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
import 'package:expense_project/features/dashboard/dashboard_page.dart';
import 'package:expense_project/features/onboarding/onboarding_page.dart';
import 'package:expense_project/app/widgets/in_progress_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

final routerProvider = GoRouter(
  initialLocation: '/onboarding',
  routes: [
    GoRoute(path: '/onboarding', builder: (_, __) => const OnboardingPage()),

    /// Main shell with minimalist sidebar
    ShellRoute(
      builder: (ctx, state, child) => MinimalistMainScaffold(child: child),
      routes: [
        /// DASHBOARD
        GoRoute(
          path: '/dashboard',
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: ModernDashboardPage()),
          routes: [
            GoRoute(
              path: 'add',
              builder: (context, state) => const AddTransactionPage(),
            ),
          ],
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

        /// ACCOUNTS
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

// ---- MODEL FOR NAV ITEMS ----
class _NavItem {
  final String path;
  final IconData icon;
  final IconData activeIcon;
  final String label;
  const _NavItem({
    required this.path,
    required this.icon,
    required this.activeIcon,
    required this.label,
  });
}

// ---- MAIN SCAFFOLD WITH HIDDEN SIDEBAR ----
class MinimalistMainScaffold extends StatefulWidget {
  final Widget child;
  const MinimalistMainScaffold({super.key, required this.child});

  @override
  State<MinimalistMainScaffold> createState() => _MinimalistMainScaffoldState();
}

class _MinimalistMainScaffoldState extends State<MinimalistMainScaffold> {
  bool _isExpanded = false;

  static const _navigationItems = [
    _NavItem(
      path: '/dashboard',
      icon: Icons.home_outlined,
      activeIcon: Icons.home,
      label: 'Dashboard',
    ),
    _NavItem(
      path: '/transactions',
      icon: Icons.receipt_long_outlined,
      activeIcon: Icons.receipt_long,
      label: 'Transactions',
    ),
    _NavItem(
      path: '/accounts',
      icon: Icons.account_balance_wallet_outlined,
      activeIcon: Icons.account_balance_wallet,
      label: 'Accounts',
    ),
    _NavItem(
      path: '/analytics',
      icon: Icons.analytics_outlined,
      activeIcon: Icons.analytics,
      label: 'Analytics',
    ),
    _NavItem(
      path: '/bills',
      icon: Icons.receipt_outlined,
      activeIcon: Icons.receipt,
      label: 'Bills',
    ),
    _NavItem(
      path: '/categories',
      icon: Icons.category_outlined,
      activeIcon: Icons.category,
      label: 'Categories',
    ),
    _NavItem(
      path: '/settings',
      icon: Icons.settings_outlined,
      activeIcon: Icons.settings,
      label: 'Settings',
    ),
  ];

  String get _currentPath =>
      GoRouterState.of(context).uri.toString().split('?').first;

  void _toggleSidebar() {
    HapticFeedback.selectionClick();
    setState(() => _isExpanded = !_isExpanded);
  }

  //   @override
  //   Widget build(BuildContext context) {
  //     final theme = Theme.of(context);
  //     final isDark = theme.brightness == Brightness.dark;
  //     const accent = Color(0xFF007AFF);

  //     final bgColor = isDark ? const Color(0xFF000000) : const Color(0xFFFFFFFF);
  //     final surface = isDark ? const Color(0xFF111111) : const Color(0xFFFBFBFB);
  //     final border = isDark ? const Color(0xFF2C2C2C) : const Color(0xFFE5E5E5);
  //     final textColor = isDark ? Colors.white : Colors.black;
  //     final subText = isDark ? const Color(0xFF888888) : const Color(0xFF666666);

  //     return Scaffold(
  //       backgroundColor: bgColor,
  //       body: Stack(
  //         children: [
  //           // Main content
  //           widget.child,

  //           // Dark overlay when menu is open
  //           if (_isExpanded)
  //             GestureDetector(
  //               onTap: _toggleSidebar,
  //               child: AnimatedOpacity(
  //                 duration: const Duration(milliseconds: 200),
  //                 opacity: _isExpanded ? 1.0 : 0.0,
  //                 child: Container(color: Colors.black54),
  //               ),
  //             ),

  //           // Sidebar container
  //           AnimatedPositioned(
  //             duration: const Duration(milliseconds: 250),
  //             curve: Curves.easeInOut,
  //             left: _isExpanded ? 0 : -240,
  //             top: 0,
  //             bottom: 0,
  //             child: Container(
  //               width: 240,
  //               decoration: BoxDecoration(
  //                 color: surface,
  //                 border: Border(right: BorderSide(color: border, width: 0.5)),
  //               ),
  //               child: Column(
  //                 children: [
  //                   // Header
  //                   Container(
  //                     height: 88,
  //                     padding: const EdgeInsets.fromLTRB(16, 44, 16, 16),
  //                     child: Row(
  //                       children: [
  //                         GestureDetector(
  //                           onTap: _toggleSidebar,
  //                           child: Icon(Icons.menu, color: accent),
  //                         ),
  //                         const SizedBox(width: 12),
  //                         Text(
  //                           'Note-Go',
  //                           style: TextStyle(
  //                             color: textColor,
  //                             fontSize: 18,
  //                             fontWeight: FontWeight.w500,
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                   // Navigation items
  //                   Expanded(
  //                     child: ListView(
  //                       children: _navigationItems.map((item) {
  //                         final isActive = _currentPath == item.path;
  //                         return ListTile(
  //                           leading: Icon(
  //                             isActive ? item.activeIcon : item.icon,
  //                             color: isActive ? accent : subText,
  //                           ),
  //                           title: Text(
  //                             item.label,
  //                             overflow: TextOverflow.ellipsis,
  //                             style: TextStyle(
  //                               color: isActive ? textColor : subText,
  //                               fontWeight: isActive
  //                                   ? FontWeight.w500
  //                                   : FontWeight.w400,
  //                             ),
  //                           ),
  //                           onTap: () {
  //                             context.go(item.path);
  //                             _toggleSidebar();
  //                           },
  //                         );
  //                       }).toList(),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),

  //           // Floating top-left menu button (only when sidebar hidden)
  //           if (!_isExpanded)
  //             SafeArea(
  //               child: Padding(
  //                 padding: const EdgeInsets.all(8.0),
  //                 child: GestureDetector(
  //                   onTap: _toggleSidebar,
  //                   child: Container(
  //                     width: 36,
  //                     height: 36,
  //                     decoration: BoxDecoration(
  //                       color: accent.withOpacity(0.1),
  //                       borderRadius: BorderRadius.circular(8),
  //                     ),
  //                     child: Icon(Icons.menu, color: accent, size: 20),
  //                   ),
  //                 ),
  //               ),
  //             ),
  //         ],
  //       ),
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    const accent = Color(0xFF007AFF);

    final bgColor = isDark ? const Color(0xFF000000) : const Color(0xFFFFFFFF);
    final surface = isDark ? const Color(0xFF111111) : const Color(0xFFFBFBFB);
    final border = isDark ? const Color(0xFF2C2C2C) : const Color(0xFFE5E5E5);
    final textColor = isDark ? Colors.white : Colors.black;
    final subText = isDark ? const Color(0xFF888888) : const Color(0xFF666666);

    return Scaffold(
      backgroundColor: bgColor,
      body: Stack(
        children: [
          // Main content
          Column(
            children: [
              // Top bar with menu + title
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    // vertical: 8,
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: _toggleSidebar,
                        child: Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: accent.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(Icons.menu, color: accent, size: 20),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Note & Go',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w200,
                          color: textColor,
                          letterSpacing: -0.3,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(child: widget.child),
            ],
          ),

          // Dark overlay when menu is open
          if (_isExpanded)
            GestureDetector(
              onTap: _toggleSidebar,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: _isExpanded ? 1.0 : 0.0,
                child: Container(color: Colors.black54),
              ),
            ),

          // Sidebar container
          AnimatedPositioned(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            left: _isExpanded ? 0 : -240,
            top: 0,
            bottom: 0,
            child: Container(
              width: 240,
              decoration: BoxDecoration(
                color: surface,
                border: Border(right: BorderSide(color: border, width: 0.5)),
              ),
              child: Column(
                children: [
                  // Header
                  Container(
                    height: 88,
                    padding: const EdgeInsets.fromLTRB(16, 44, 16, 16),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: _toggleSidebar,
                          child: Icon(Icons.menu, color: accent),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Note & Go',
                          style: TextStyle(
                            color: textColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Navigation items
                  Expanded(
                    child: ListView(
                      children: _navigationItems.map((item) {
                        final isActive = _currentPath == item.path;
                        return ListTile(
                          leading: Icon(
                            isActive ? item.activeIcon : item.icon,
                            color: isActive ? accent : subText,
                          ),
                          title: Text(
                            item.label,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: isActive ? textColor : subText,
                              fontWeight: isActive
                                  ? FontWeight.w500
                                  : FontWeight.w400,
                            ),
                          ),
                          onTap: () {
                            context.go(item.path);
                            _toggleSidebar();
                          },
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
