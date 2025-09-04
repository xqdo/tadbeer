import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/utils/hive_service.dart';
import 'app/theme.dart';
import 'app/router.dart';
import 'app/providers.dart';

void main() async {
  // Ensure Flutter widgets are initialized
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Hive database
  await HiveService.init();
  
  // Run the app
  runApp(const ProviderScope(child: TadbeerApp()));
}

class TadbeerApp extends ConsumerWidget {
  const TadbeerApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(appSettingsProvider);
    
    return MaterialApp.router(
      title: 'Tadbeer - Personal Life Management',
      
      // Theme configuration
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: settings.themeModeEnum,
      
      // Router configuration
      routerConfig: appRouter,
      
      // Remove debug banner
      debugShowCheckedModeBanner: false,
    );
  }
}