import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SidebarScaffold extends StatefulWidget {
  final Widget child;
  const SidebarScaffold({required this.child});

  @override
  SidebarScaffoldState createState() => SidebarScaffoldState();
}

class SidebarScaffoldState extends State<SidebarScaffold> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late String _currentRoute;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateCurrentRoute();
  }

  void _updateCurrentRoute() {
    final uri = GoRouterState.of(context).uri.toString();
    setState(() {
      _currentRoute = uri;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Derive active index, e.g.
    final routeMap = {
      '/dashboard': 0,
      '/transactions': 1,
      '/accounts': 2,
      '/analytics': 3,
      '/settings': 4,
    };
    final index = routeMap.containsKey(_currentRoute)
        ? routeMap[_currentRoute]!
        : 0;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.menu, color: Theme.of(context).colorScheme.primary),
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
        ),
        title: Text(
          'Note-Go',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      drawer: Drawer(
        child: Container(
          color: Theme.of(context).colorScheme.surface,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                child: Text('Navigation', style: TextStyle(fontSize: 20)),
              ),
              _buildNavItem(
                'Dashboard',
                Icons.dashboard,
                '/dashboard',
                index == 0,
              ),
              _buildNavItem(
                'Transactions',
                Icons.list,
                '/transactions',
                index == 1,
              ),
              _buildNavItem(
                'Accounts',
                Icons.account_balance_wallet,
                '/accounts',
                index == 2,
              ),
              _buildNavItem(
                'Analytics',
                Icons.pie_chart,
                '/analytics',
                index == 3,
              ),
              _buildNavItem(
                'Settings',
                Icons.settings,
                '/settings',
                index == 4,
              ),
            ],
          ),
        ),
      ),
      body: widget.child,
    );
  }

  Widget _buildNavItem(
    String label,
    IconData icon,
    String route,
    bool selected,
  ) {
    return ListTile(
      leading: Icon(
        icon,
        color: selected ? Theme.of(context).colorScheme.primary : null,
      ),
      title: Text(
        label,
        style: TextStyle(
          color: selected ? Theme.of(context).colorScheme.primary : null,
        ),
      ),
      selected: selected,
      onTap: () {
        context.go(route);
        Navigator.of(context).pop(); // Close drawer
      },
    );
  }
}
