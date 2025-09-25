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
  initialLocation: '/dashboard',
  routes: [
    GoRoute(path: '/onboarding', builder: (_, __) => const OnboardingPage()),

    // Each page wrapped individually - No ShellRoute
    GoRoute(
      path: '/dashboard',
      builder: (_, __) => const MinimalistMainScaffold(
        child: ModernDashboardPage(),
        currentPath: '/dashboard',
      ),
    ),

    GoRoute(
      path: '/transactions',
      builder: (_, __) => const MinimalistMainScaffold(
        child: TransactionsListPage(),
        currentPath: '/transactions',
      ),
    ),

    GoRoute(
      path: '/accounts',
      builder: (_, __) => const MinimalistMainScaffold(
        child: AccountsPage(),
        currentPath: '/accounts',
      ),
    ),

    GoRoute(
      path: '/categories',
      builder: (_, __) => const MinimalistMainScaffold(
        child: CategoriesPage(),
        currentPath: '/categories',
      ),
    ),

    GoRoute(
      path: '/bills',
      builder: (_, __) => const MinimalistMainScaffold(
        child: BillsPage(),
        currentPath: '/bills',
      ),
    ),

    GoRoute(
      path: '/analytics',
      builder: (_, __) => const MinimalistMainScaffold(
        child: AnalyticsPage(),
        currentPath: '/analytics',
      ),
    ),

    GoRoute(
      path: '/settings',
      builder: (_, __) => const MinimalistMainScaffold(
        child: ModernSettingsPage(),
        currentPath: '/settings',
      ),
    ),

    // Catch-all
    GoRoute(
      path: '/:splash(.*)',
      builder: (_, __) => const InProgressPage(title: 'Not Found'),
    ),
  ],
);

// Updated MinimalistMainScaffold - No GoRouter context dependency
class MinimalistMainScaffold extends StatefulWidget {
  final Widget child;
  final String currentPath;

  const MinimalistMainScaffold({
    super.key,
    required this.child,
    required this.currentPath,
  });

  @override
  State<MinimalistMainScaffold> createState() => _MinimalistMainScaffoldState();
}

// class _MinimalistMainScaffoldState extends State<MinimalistMainScaffold> {
//   bool _isExpanded = false;

//   static const _navigationItems = [
//     _NavItem(
//       path: '/dashboard',
//       icon: Icons.home_outlined,
//       activeIcon: Icons.home,
//       label: 'Dashboard',
//     ),
//     _NavItem(
//       path: '/transactions',
//       icon: Icons.receipt_long_outlined,
//       activeIcon: Icons.receipt_long,
//       label: 'Transactions',
//     ),
//     _NavItem(
//       path: '/accounts',
//       icon: Icons.account_balance_wallet_outlined,
//       activeIcon: Icons.account_balance_wallet,
//       label: 'Accounts',
//     ),
//     _NavItem(
//       path: '/analytics',
//       icon: Icons.analytics_outlined,
//       activeIcon: Icons.analytics,
//       label: 'Analytics',
//     ),
//     _NavItem(
//       path: '/bills',
//       icon: Icons.receipt_outlined,
//       activeIcon: Icons.receipt,
//       label: 'Bills',
//     ),
//     _NavItem(
//       path: '/categories',
//       icon: Icons.category_outlined,
//       activeIcon: Icons.category,
//       label: 'Categories',
//     ),
//     _NavItem(
//       path: '/settings',
//       icon: Icons.settings_outlined,
//       activeIcon: Icons.settings,
//       label: 'Settings',
//     ),
//   ];

//   void _toggleSidebar() {
//     HapticFeedback.selectionClick();
//     setState(() => _isExpanded = !_isExpanded);
//   }

//   void _navigateToPage(String path) {
//     if (mounted && path != widget.currentPath) {
//       context.go(path);
//       _toggleSidebar();
//     }
//   }

//   void _handleBackNavigation() {
//     if (mounted) {
//       if (widget.currentPath == '/dashboard') {
//         _showExitDialog();
//       } else {
//         context.go('/dashboard');
//       }
//     }
//   }

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
//           Column(
//             children: [
//               // Top bar with menu + title
//               SafeArea(
//                 // child: Padding(
//                 //   padding: const EdgeInsets.symmetric(
//                 //     horizontal: 8,
//                 //     vertical: 8,
//                 //   ),
//                 child: Row(
//                   children: [
//                     GestureDetector(
//                       onTap: _toggleSidebar,
//                       child: Container(
//                         width: 36,
//                         height: 36,
//                         decoration: BoxDecoration(
//                           color: accent.withOpacity(0.1),
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: Icon(Icons.menu, color: accent, size: 20),
//                       ),
//                     ),
//                     const SizedBox(width: 12),
//                     Text(
//                       'Note & Go',
//                       style: TextStyle(
//                         fontSize: 28,
//                         fontWeight: FontWeight.w200,
//                         color: textColor,
//                         letterSpacing: -0.3,
//                       ),
//                     ),

//                     // Back button for non-dashboard pages
//                     if (widget.currentPath != '/dashboard') ...[
//                       const Spacer(),
//                       GestureDetector(
//                         onTap: _handleBackNavigation,
//                         child: Container(
//                           width: 36,
//                           height: 36,
//                           decoration: BoxDecoration(
//                             color: accent.withOpacity(0.1),
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           child: Icon(
//                             Icons.arrow_back_ios_new,
//                             color: accent,
//                             size: 18,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ],
//                 ),
//                 // ),
//               ),
//               Expanded(child: widget.child),
//             ],
//           ),

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
//                           'Note & Go',
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
//                         final isActive = widget.currentPath == item.path;
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
//                           onTap: () => _navigateToPage(item.path),
//                         );
//                       }).toList(),
//                     ),
//                   ),

//                   // Exit button at bottom for dashboard
//                   if (widget.currentPath == '/dashboard')
//                     Container(
//                       padding: const EdgeInsets.all(16),
//                       child: ListTile(
//                         leading: Icon(Icons.exit_to_app, color: subText),
//                         title: Text(
//                           'Exit App',
//                           style: TextStyle(
//                             color: subText,
//                             fontWeight: FontWeight.w400,
//                           ),
//                         ),
//                         onTap: _showExitDialog,
//                       ),
//                     ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void _showExitDialog() async {
//     if (!mounted) return;

//     final shouldExit = await showDialog<bool>(
//       context: context,
//       barrierDismissible: true,
//       builder: (dialogContext) => AlertDialog(
//         title: const Text('Exit App'),
//         content: const Text('Are you sure you want to exit?'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.of(dialogContext).pop(false),
//             child: const Text('Cancel'),
//           ),
//           TextButton(
//             onPressed: () => Navigator.of(dialogContext).pop(true),
//             style: TextButton.styleFrom(foregroundColor: Colors.red),
//             child: const Text('Exit'),
//           ),
//         ],
//       ),
//     );

//     if (shouldExit == true && mounted) {
//       SystemNavigator.pop();
//     }
//   }
// }

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

// Updated MinimalistMainScaffold with proper header layout
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

  // void _toggleSidebar() {
  //   HapticFeedback.selectionClick();
  //   setState(() => _isExpanded = !_isExpanded);
  // }

  // void _navigateToPage(String path) {
  //   if (mounted && path != widget.currentPath) {
  //     context.go(path);
  //     _toggleSidebar();
  //   }
  // }

  // void _handleBackNavigation() {
  //   if (mounted) {
  //     if (widget.currentPath == '/dashboard') {
  //       _showExitDialog();
  //     } else {
  //       context.go('/dashboard');
  //     }
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
              // ✅ FIXED: Proper header layout with back button on left
              // SafeArea(
              //   child: Padding(
              //     padding: const EdgeInsets.symmetric(
              //       horizontal: 8,
              //       vertical: 8,
              //     ),
              //     child: Row(
              //       children: [
              //         // Left side: Back button OR Menu button
              //         if (widget.currentPath != '/dashboard') ...[
              //           // ✅ Back button on LEFT for non-dashboard pages
              //           GestureDetector(
              //             onTap: _handleBackNavigation,
              //             child: Container(
              //               width: 36,
              //               height: 36,
              //               decoration: BoxDecoration(
              //                 color: accent.withOpacity(0.1),
              //                 borderRadius: BorderRadius.circular(8),
              //               ),
              //               child: Icon(
              //                 Icons.arrow_back_ios_new,
              //                 color: accent,
              //                 size: 18,
              //               ),
              //             ),
              //           ),
              //           const SizedBox(width: 8),
              //         ] else ...[
              //           // ✅ Menu button on LEFT for dashboard
              //           GestureDetector(
              //             onTap: _toggleSidebar,
              //             child: Container(
              //               width: 36,
              //               height: 36,
              //               decoration: BoxDecoration(
              //                 color: accent.withOpacity(0.1),
              //                 borderRadius: BorderRadius.circular(8),
              //               ),
              //               child: Icon(Icons.menu, color: accent, size: 20),
              //             ),
              //           ),
              //           const SizedBox(width: 8),
              //         ],

              //         // Center: App title
              //         Expanded(
              //           child: Center(
              //             child: Text(
              //               'Note & Go',
              //               style: TextStyle(
              //                 fontSize: 28,
              //                 fontWeight: FontWeight.w200,
              //                 color: textColor,
              //                 letterSpacing: -0.3,
              //               ),
              //             ),
              //           ),
              //         ),

              //         // Right side: Menu button for non-dashboard pages
              //         if (widget.currentPath != '/dashboard') ...[
              //           const SizedBox(width: 8),
              //           GestureDetector(
              //             onTap: _toggleSidebar,
              //             child: Container(
              //               width: 36,
              //               height: 36,
              //               decoration: BoxDecoration(
              //                 color: accent.withOpacity(0.1),
              //                 borderRadius: BorderRadius.circular(8),
              //               ),
              //               child: Icon(Icons.menu, color: accent, size: 20),
              //             ),
              //           ),
              //         ] else ...[
              //           // ✅ Empty space to keep title centered on dashboard
              //           const SizedBox(
              //             width: 44,
              //           ), // Match button width + padding
              //         ],
              //       ],
              //     ),
              //   ),
              // ),
              // Alternative: Back button + Menu on left, Title on right
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 8,
                  ),
                  child: Row(
                    children: [
                      // Left side: Back button (if not dashboard)
                      if (widget.currentPath != '/dashboard') ...[
                        GestureDetector(
                          onTap: _handleBackNavigation,
                          child: Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: accent.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              Icons.arrow_back_ios_new,
                              color: accent,
                              size: 18,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                      ],

                      // Menu button (always visible)
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

                      // Title (takes remaining space)
                      Expanded(
                        child: Text(
                          'Note & Go',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w200,
                            color: textColor,
                            letterSpacing: -0.3,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Expanded(child: widget.child),
            ],
          ),

          // Rest of your existing code (sidebar, overlay, etc.) stays the same
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

          // Sidebar container - same as before
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
                        final isActive = widget.currentPath == item.path;
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
                          onTap: () => _navigateToPage(item.path),
                        );
                      }).toList(),
                    ),
                  ),

                  // Exit button at bottom for dashboard
                  if (widget.currentPath == '/dashboard')
                    Container(
                      padding: const EdgeInsets.all(16),
                      child: ListTile(
                        leading: Icon(Icons.exit_to_app, color: subText),
                        title: Text(
                          'Exit App',
                          style: TextStyle(
                            color: subText,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        onTap: _showExitDialog,
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

  // ... rest of your existing methods stay the same
  void _showExitDialog() async {
    if (!mounted) return;

    final shouldExit = await showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Exit App'),
        content: const Text('Are you sure you want to exit?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Exit'),
          ),
        ],
      ),
    );

    if (shouldExit == true && mounted) {
      SystemNavigator.pop();
    }
  }

  void _navigateToPage(String path) {
    if (mounted && path != widget.currentPath) {
      context.go(path);
      _toggleSidebar();
    }
  }

  // void _handleBackNavigation() {
  //   if (mounted) {
  //     if (widget.currentPath == '/dashboard') {
  //       _showExitDialog();
  //     } else {
  //       context.go('/dashboard');
  //     }
  //   }
  // }
  void _handleBackNavigation() {
    print('Current path: ${widget.currentPath}');
    print('Can GoRouter pop: ${GoRouter.of(context).canPop()}');
    print('Can Navigator pop: ${Navigator.of(context).canPop()}');

    if (!mounted) return;

    try {
      // ✅ Check if GoRouter has navigation history
      if (GoRouter.of(context).canPop()) {
        GoRouter.of(context).pop(); // Go to actual previous page
        return;
      }

      // ✅ Check Navigator stack as fallback
      if (Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
        return;
      }

      // ✅ Only go to dashboard if no history exists
      if (widget.currentPath != '/dashboard') {
        context.go('/dashboard');
      } else {
        _showExitDialog();
      }
    } catch (e) {
      // Fallback to dashboard
      context.go('/dashboard');
    }
  }

  void _toggleSidebar() {
    HapticFeedback.selectionClick();
    setState(() => _isExpanded = !_isExpanded);
  }
}
