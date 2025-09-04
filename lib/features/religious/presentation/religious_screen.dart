import 'package:flutter/material.dart';
import '../../../app/theme.dart';

class ReligiousScreen extends StatelessWidget {
  const ReligiousScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Spiritual Life')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.mosque, size: 64, color: AppTheme.primaryColor),
            const SizedBox(height: 16),
            const Text('Spiritual Life Module', style: AppTextStyles.headlineSmall),
            const SizedBox(height: 8),
            Text('Coming in Phase 3', style: AppTextStyles.bodyMedium.copyWith(color: AppTheme.textSecondary)),
          ],
        ),
      ),
    );
  }
}