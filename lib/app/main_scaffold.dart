import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'router.dart';

/// Main scaffold with bottom navigation bar
class MainScaffold extends StatelessWidget {
  final Widget child;

  const MainScaffold({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final String currentPath = GoRouterState.of(context).uri.path;
    final int selectedIndex = _getSelectedIndex(currentPath);

    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) {
          final destination = navigationDestinations[index];
          context.go(destination.path);
        },
        destinations: navigationDestinations.map((destination) {
          return NavigationDestination(
            icon: Icon(destination.icon),
            selectedIcon: Icon(destination.selectedIcon),
            label: destination.label,
          );
        }).toList(),
      ),
      floatingActionButton: _buildFloatingActionButton(context, currentPath),
    );
  }

  /// Get the selected index based on current path
  int _getSelectedIndex(String path) {
    for (int i = 0; i < navigationDestinations.length; i++) {
      if (path.startsWith(navigationDestinations[i].path)) {
        return i;
      }
    }
    return 0; // Default to tasks
  }

  /// Build floating action button based on current page
  Widget? _buildFloatingActionButton(BuildContext context, String path) {
    switch (path) {
      case '/tasks':
        return FloatingActionButton(
          onPressed: () {
            // TODO: Show add task dialog
            _showComingSoon(context, 'Add Task');
          },
          tooltip: 'Add Task',
          child: const Icon(Icons.add),
        );
      case '/time':
        return FloatingActionButton(
          onPressed: () {
            // TODO: Start time tracking
            _showComingSoon(context, 'Start Timer');
          },
          tooltip: 'Start Timer',
          child: const Icon(Icons.play_arrow),
        );
      case '/finance':
        return FloatingActionButton(
          onPressed: () {
            // TODO: Add transaction
            _showComingSoon(context, 'Add Transaction');
          },
          tooltip: 'Add Transaction',
          child: const Icon(Icons.add),
        );
      case '/religious':
        return FloatingActionButton(
          onPressed: () {
            // TODO: Quick prayer or dhikr
            _showComingSoon(context, 'Quick Dhikr');
          },
          tooltip: 'Quick Dhikr',
          child: const Icon(Icons.favorite),
        );
      default:
        return null;
    }
  }

  /// Show coming soon dialog for unimplemented features
  void _showComingSoon(BuildContext context, String feature) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Coming Soon'),
        content: Text('$feature feature will be implemented in the next phase.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}