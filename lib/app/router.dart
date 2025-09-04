import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/tasks/presentation/tasks_screen.dart';
import '../features/time/presentation/time_screen.dart';
import '../features/finance/presentation/finance_screen.dart';
import '../features/religious/presentation/religious_screen.dart';
import '../features/settings/presentation/settings_screen.dart';
import 'main_scaffold.dart';

/// App router configuration using GoRouter
final GoRouter appRouter = GoRouter(
  initialLocation: '/tasks',
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return MainScaffold(child: child);
      },
      routes: [
        GoRoute(
          path: '/tasks',
          name: 'tasks',
          builder: (context, state) => const TasksScreen(),
        ),
        GoRoute(
          path: '/time',
          name: 'time',
          builder: (context, state) => const TimeScreen(),
        ),
        GoRoute(
          path: '/finance',
          name: 'finance',
          builder: (context, state) => const FinanceScreen(),
        ),
        GoRoute(
          path: '/religious',
          name: 'religious',
          builder: (context, state) => const ReligiousScreen(),
        ),
        GoRoute(
          path: '/settings',
          name: 'settings',
          builder: (context, state) => const SettingsScreen(),
        ),
      ],
    ),
  ],
  errorBuilder: (context, state) => const Scaffold(
    body: Center(
      child: Text('Page not found'),
    ),
  ),
);

/// Navigation destinations for bottom navigation
class NavigationDestination {
  final String path;
  final String label;
  final IconData icon;
  final IconData selectedIcon;

  const NavigationDestination({
    required this.path,
    required this.label,
    required this.icon,
    required this.selectedIcon,
  });
}

/// Main navigation destinations
const List<NavigationDestination> navigationDestinations = [
  NavigationDestination(
    path: '/tasks',
    label: 'Tasks',
    icon: Icons.task_outlined,
    selectedIcon: Icons.task,
  ),
  NavigationDestination(
    path: '/time',
    label: 'Time',
    icon: Icons.schedule_outlined,
    selectedIcon: Icons.schedule,
  ),
  NavigationDestination(
    path: '/finance',
    label: 'Finance',
    icon: Icons.account_balance_wallet_outlined,
    selectedIcon: Icons.account_balance_wallet,
  ),
  NavigationDestination(
    path: '/religious',
    label: 'Spiritual',
    icon: Icons.mosque_outlined,
    selectedIcon: Icons.mosque,
  ),
];