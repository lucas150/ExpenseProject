import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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

  int get _index =>
      _tabs.indexOf(GoRouterState.of(context).uri.toString().split('?').first);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index < 0 ? 0 : _index,
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
