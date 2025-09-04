import 'package:flutter/material.dart';
import '../../../app/theme.dart';

class FinanceScreen extends StatelessWidget {
  const FinanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Finance Management')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.account_balance_wallet, size: 64, color: AppTheme.primaryColor),
            const SizedBox(height: 16),
            const Text('Finance Management Module', style: AppTextStyles.headlineSmall),
            const SizedBox(height: 8),
            Text('Coming in Phase 2', style: AppTextStyles.bodyMedium.copyWith(color: AppTheme.textSecondary)),
          ],
        ),
      ),
    );
  }
}