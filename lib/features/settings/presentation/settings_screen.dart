import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../app/theme.dart';
import '../../../app/providers.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(appSettingsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Theme section
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Appearance', style: AppTextStyles.labelLarge),
                  const SizedBox(height: 12),
                  ListTile(
                    leading: const Icon(Icons.palette_outlined),
                    title: const Text('Theme'),
                    subtitle: Text(_getThemeLabel(settings.themeMode)),
                    trailing: DropdownButton<String>(
                      value: settings.themeMode,
                      onChanged: (value) {
                        if (value != null) {
                          ref.read(appSettingsProvider.notifier).updateThemeMode(value);
                        }
                      },
                      items: const [
                        DropdownMenuItem(value: 'system', child: Text('System')),
                        DropdownMenuItem(value: 'light', child: Text('Light')),
                        DropdownMenuItem(value: 'dark', child: Text('Dark')),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Notifications section
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Notifications', style: AppTextStyles.labelLarge),
                  const SizedBox(height: 12),
                  SwitchListTile(
                    secondary: const Icon(Icons.notifications_outlined),
                    title: const Text('Enable Notifications'),
                    subtitle: const Text('Receive reminders and alerts'),
                    value: settings.notificationsEnabled,
                    onChanged: (value) {
                      ref.read(appSettingsProvider.notifier).updateNotifications(value);
                    },
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Tasks section
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Tasks', style: AppTextStyles.labelLarge),
                  const SizedBox(height: 12),
                  ListTile(
                    leading: const Icon(Icons.flag_outlined),
                    title: const Text('Daily Task Goal'),
                    subtitle: Text('${settings.dailyTaskGoal} tasks per day'),
                    trailing: IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () => _showTaskGoalDialog(context, ref, settings.dailyTaskGoal),
                    ),
                  ),
                  SwitchListTile(
                    secondary: const Icon(Icons.done_all_outlined),
                    title: const Text('Show Completed Tasks'),
                    subtitle: const Text('Display completed tasks in lists'),
                    value: settings.showCompletedTasks,
                    onChanged: (value) {
                      // TODO: Implement show completed tasks toggle
                    },
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 16),
          
          // About section
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('About', style: AppTextStyles.labelLarge),
                  const SizedBox(height: 12),
                  ListTile(
                    leading: const Icon(Icons.info_outlined),
                    title: const Text('App Version'),
                    subtitle: const Text('1.0.0 (Phase 1)'),
                  ),
                  ListTile(
                    leading: const Icon(Icons.favorite_outlined),
                    title: const Text('Made with ❤️'),
                    subtitle: const Text('Personal life management with Islamic values'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getThemeLabel(String themeMode) {
    switch (themeMode) {
      case 'light':
        return 'Light';
      case 'dark':
        return 'Dark';
      default:
        return 'System';
    }
  }

  void _showTaskGoalDialog(BuildContext context, WidgetRef ref, int currentGoal) {
    int newGoal = currentGoal;
    
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Daily Task Goal'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('How many tasks do you want to complete daily?'),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: newGoal > 1 ? () => setState(() => newGoal--) : null,
                    icon: const Icon(Icons.remove),
                  ),
                  Text(
                    newGoal.toString(),
                    style: AppTextStyles.headlineMedium.copyWith(
                      color: AppTheme.primaryColor,
                    ),
                  ),
                  IconButton(
                    onPressed: newGoal < 20 ? () => setState(() => newGoal++) : null,
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                ref.read(appSettingsProvider.notifier).updateDailyTaskGoal(newGoal);
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}