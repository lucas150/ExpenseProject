// import 'package:expense_project/app/theme_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class SettingsPage extends ConsumerWidget {
//   const SettingsPage({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final isDark = ref.watch(themeProvider);
//     return Scaffold(
//       appBar: AppBar(title: const Text('Settings')),
//       body: SwitchListTile(
//         title: const Text('Dark Mode'),
//         value: isDark,
//         onChanged: (v) => ref.read(themeProvider.notifier).state = v,
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:expense_project/core/services/database_service.dart';
import 'package:expense_project/core/models/transaction_model.dart';
import 'package:expense_project/core/models/account_model.dart';
import 'package:expense_project/core/models/bill_model.dart';
import 'package:expense_project/features/categories/categories_management_page.dart';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

// FIXED: Proper theme provider that triggers UI updates
final themeProvider = StateNotifierProvider<ThemeNotifier, bool>(
  (ref) => ThemeNotifier(),
);

class ThemeNotifier extends StateNotifier<bool> {
  ThemeNotifier() : super(false) {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    state = prefs.getBool('isDarkMode') ?? false;
  }

  Future<void> toggleTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final newTheme = !state;
    await prefs.setBool('isDarkMode', newTheme);
    state = newTheme; // This triggers UI rebuild
  }

  Future<void> setTheme(bool isDark) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', isDark);
    state = isDark; // This triggers UI rebuild
  }
}

// FIXED: Currency Provider with proper state updates
class Currency {
  final String code;
  final String symbol;
  final String name;

  const Currency({
    required this.code,
    required this.symbol,
    required this.name,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Currency &&
          runtimeType == other.runtimeType &&
          code == other.code;

  @override
  int get hashCode => code.hashCode;
}

class CurrencyNotifier extends StateNotifier<Currency> {
  CurrencyNotifier()
    : super(const Currency(code: 'INR', symbol: '₹', name: 'Indian Rupee')) {
    _loadCurrency();
  }

  static const availableCurrencies = [
    Currency(code: 'INR', symbol: '₹', name: 'Indian Rupee'),
    Currency(code: 'USD', symbol: '\$', name: 'US Dollar'),
    Currency(code: 'EUR', symbol: '€', name: 'Euro'),
    Currency(code: 'GBP', symbol: '£', name: 'British Pound'),
    Currency(code: 'JPY', symbol: '¥', name: 'Japanese Yen'),
  ];

  Future<void> _loadCurrency() async {
    final prefs = await SharedPreferences.getInstance();
    final currencyCode = prefs.getString('currency_code') ?? 'INR';
    final currency = availableCurrencies.firstWhere(
      (c) => c.code == currencyCode,
      orElse: () => availableCurrencies.first,
    );
    state = currency;
  }

  Future<void> setCurrency(Currency currency) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('currency_code', currency.code);
    state = currency; // This triggers UI rebuild
  }
}

final currencyProvider = StateNotifierProvider<CurrencyNotifier, Currency>(
  (ref) => CurrencyNotifier(),
);

// FIXED: Proper providers with state invalidation
final transactionsProvider =
    StateNotifierProvider<TransactionsNotifier, List<TransactionModel>>(
      (ref) => TransactionsNotifier(),
    );

class TransactionsNotifier extends StateNotifier<List<TransactionModel>> {
  TransactionsNotifier() : super([]) {
    _loadTransactions();
  }

  void _loadTransactions() {
    state = DatabaseService().transactionsBox.values.toList();
  }

  void refresh() {
    _loadTransactions();
  }
}

final accountsProvider = StateNotifierProvider<AccountsNotifier, List<Account>>(
  (ref) => AccountsNotifier(),
);

class AccountsNotifier extends StateNotifier<List<Account>> {
  AccountsNotifier() : super([]) {
    _loadAccounts();
  }

  void _loadAccounts() {
    state = DatabaseService().accountsBox.values.toList();
  }

  void refresh() {
    _loadAccounts();
  }
}

final billsProvider = StateNotifierProvider<BillsNotifier, List<BillModel>>(
  (ref) => BillsNotifier(),
);

class BillsNotifier extends StateNotifier<List<BillModel>> {
  BillsNotifier() : super([]) {
    _loadBills();
  }

  void _loadBills() {
    state = DatabaseService().billsBox.values.toList();
  }

  void refresh() {
    _loadBills();
  }
}

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDarkMode = ref.watch(themeProvider);
    final currency = ref.watch(currencyProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: theme.colorScheme.surface,
        foregroundColor: theme.colorScheme.onSurface,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          // Refresh all providers
          ref.read(transactionsProvider.notifier).refresh();
          ref.read(accountsProvider.notifier).refresh();
          ref.read(billsProvider.notifier).refresh();
        },
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // App Preferences Section
            _SettingsSection(
              title: 'App Preferences',
              children: [
                _SettingsTile(
                  leading: Icon(
                    isDarkMode ? Icons.dark_mode : Icons.light_mode,
                    color: theme.colorScheme.primary,
                  ),
                  title: 'Dark Mode',
                  subtitle: isDarkMode
                      ? 'Dark theme enabled'
                      : 'Light theme enabled',
                  trailing: Switch(
                    value: isDarkMode,
                    onChanged: (_) {
                      ref.read(themeProvider.notifier).toggleTheme();
                    },
                  ),
                ),
                _SettingsTile(
                  leading: Icon(
                    Icons.monetization_on,
                    color: theme.colorScheme.primary,
                  ),
                  title: 'Currency',
                  subtitle: '${currency.name} (${currency.symbol})',
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => _showCurrencySelector(context, ref),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Data Management Section
            _SettingsSection(
              title: 'Data Management',
              children: [
                _SettingsTile(
                  leading: Icon(
                    Icons.category,
                    color: theme.colorScheme.primary,
                  ),
                  title: 'Manage Categories',
                  subtitle: 'Add, edit, or delete transaction categories',
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const CategoriesManagementPage(),
                    ),
                  ),
                ),
                _SettingsTile(
                  leading: Icon(
                    Icons.account_balance_wallet,
                    color: theme.colorScheme.primary,
                  ),
                  title: 'Manage Accounts',
                  subtitle: 'Add, edit, or delete accounts',
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => _navigateToAccounts(context),
                ),
                _SettingsTile(
                  leading: Icon(Icons.backup, color: theme.colorScheme.primary),
                  title: 'Backup & Restore',
                  subtitle: 'Export or import your data',
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => _showBackupOptions(context, ref),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Statistics Section
            _SettingsSection(
              title: 'Statistics',
              children: [
                Consumer(
                  builder: (context, ref, child) {
                    final transactions = ref.watch(transactionsProvider);
                    final accounts = ref.watch(accountsProvider);

                    return Column(
                      children: [
                        _SettingsTile(
                          leading: Icon(
                            Icons.receipt_long,
                            color: theme.colorScheme.secondary,
                          ),
                          title: 'Total Transactions',
                          subtitle:
                              '${transactions.length} transactions recorded',
                        ),
                        _SettingsTile(
                          leading: Icon(
                            Icons.account_balance,
                            color: theme.colorScheme.secondary,
                          ),
                          title: 'Accounts',
                          subtitle: '${accounts.length} accounts configured',
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),

            const SizedBox(height: 24),

            // About Section
            _SettingsSection(
              title: 'About',
              children: [
                _SettingsTile(
                  leading: Icon(Icons.info, color: theme.colorScheme.tertiary),
                  title: 'Version',
                  subtitle: '1.0.0 - Note-Go Expense Tracker',
                ),
                _SettingsTile(
                  leading: Icon(
                    Icons.privacy_tip,
                    color: theme.colorScheme.tertiary,
                  ),
                  title: 'Privacy Policy',
                  subtitle: 'Your data stays on your device',
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => _showPrivacyPolicy(context),
                ),
                _SettingsTile(
                  leading: Icon(Icons.help, color: theme.colorScheme.tertiary),
                  title: 'Help & Support',
                  subtitle: 'Tips and support information',
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => _showHelpSupport(context),
                ),
              ],
            ),

            const SizedBox(height: 32),

            // Danger Zone
            Card(
              color: theme.colorScheme.errorContainer.withOpacity(0.3),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.warning, color: theme.colorScheme.error),
                        const SizedBox(width: 8),
                        Text(
                          'Danger Zone',
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: theme.colorScheme.error,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    _SettingsTile(
                      leading: Icon(
                        Icons.delete_forever,
                        color: theme.colorScheme.error,
                      ),
                      title: 'Clear All Data',
                      subtitle:
                          'Delete all transactions, accounts, and reset settings',
                      onTap: () => _showClearDataConfirmation(context, ref),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToAccounts(BuildContext context) {
    // Navigate to accounts page - replace with your actual accounts page
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Accounts page not implemented yet'),
        action: SnackBarAction(label: 'OK', onPressed: () {}),
      ),
    );
  }

  void _showCurrencySelector(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Currency',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ...CurrencyNotifier.availableCurrencies.map((currency) {
              return Consumer(
                builder: (context, ref, child) {
                  final currentCurrency = ref.watch(currencyProvider);
                  final isSelected = currentCurrency.code == currency.code;

                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: isSelected
                          ? Theme.of(context).colorScheme.primaryContainer
                          : Theme.of(context).colorScheme.surfaceVariant,
                      child: Text(
                        currency.symbol,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: isSelected
                              ? Theme.of(context).colorScheme.onPrimaryContainer
                              : Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                    title: Text(currency.name),
                    subtitle: Text(currency.code),
                    trailing: isSelected
                        ? Icon(
                            Icons.check,
                            color: Theme.of(context).colorScheme.primary,
                          )
                        : null,
                    onTap: () async {
                      await ref
                          .read(currencyProvider.notifier)
                          .setCurrency(currency);
                      if (context.mounted) {
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Currency changed to ${currency.name} (${currency.symbol})',
                            ),
                            backgroundColor: Colors.green,
                          ),
                        );
                      }
                    },
                  );
                },
              );
            }),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  void _showBackupOptions(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Backup & Restore',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Export creates a .json file. Import accepts .json files only.',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.file_download, color: Colors.green),
              title: const Text('Export Data'),
              subtitle: const Text('Save all data as JSON file'),
              onTap: () {
                Navigator.of(context).pop();
                _exportData(context, ref);
              },
            ),
            ListTile(
              leading: const Icon(Icons.file_upload, color: Colors.blue),
              title: const Text('Import Data'),
              subtitle: const Text('Restore from JSON backup file'),
              onTap: () {
                Navigator.of(context).pop();
                _importData(context, ref);
              },
            ),
          ],
        ),
      ),
    );
  }

  // FIXED: Export function with proper async handling
  Future<void> _exportData(BuildContext context, WidgetRef ref) async {
    try {
      // Show loading as overlay instead of dialog
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
          child: Card(
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Exporting data...'),
                ],
              ),
            ),
          ),
        ),
      );

      final db = DatabaseService();
      final exportData = {
        'version': '1.0',
        'exportDate': DateTime.now().toIso8601String(),
        'appName': 'Note-Go Expense Tracker',
        'transactions': db.transactionsBox.values
            .map(
              (t) => {
                'id': t.id,
                'type': t.type.index,
                'date': t.date.toIso8601String(),
                'title': t.title,
                'amount': t.amount,
                'category': t.category,
                'account': t.account,
                'note': t.note,
              },
            )
            .toList(),
        'accounts': db.accountsBox.values
            .map(
              (a) => {
                'id': a.id,
                'name': a.name,
                'balance': a.balance,
                'type': a.type,
                'role': a.role.index,
              },
            )
            .toList(),
        'expenseCategories': db.expenseCategoriesBox.values
            .map((c) => {'name': c.name, 'subcategories': c.subcategories})
            .toList(),
        'incomeCategories': db.incomeCategoriesBox.values
            .map((c) => {'name': c.name, 'subcategories': c.subcategories})
            .toList(),
        'bills': db.billsBox.values
            .map(
              (b) => {
                'id': b.id,
                'title': b.title,
                'amount': b.amount,
                'dueDate': b.dueDate.toIso8601String(),
                'paid': b.paid,
              },
            )
            .toList(),
      };

      final jsonString = const JsonEncoder.withIndent('  ').convert(exportData);
      final directory = await getApplicationDocumentsDirectory();
      final fileName =
          'note_go_backup_${DateTime.now().millisecondsSinceEpoch}.json';
      final file = File('${directory.path}/$fileName');
      await file.writeAsString(jsonString);

      // FIXED: Proper context handling
      if (context.mounted) {
        Navigator.of(
          context,
          rootNavigator: true,
        ).pop(); // Close loading dialog

        // Share the file
        await Share.shareXFiles([
          XFile(file.path),
        ], text: 'Note-Go Data Backup');

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('✅ Data exported: $fileName'),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        Navigator.of(
          context,
          rootNavigator: true,
        ).pop(); // Close loading dialog
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('❌ Export failed: $e'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 5),
          ),
        );
      }
    }
  }

  Future<void> _importData(BuildContext context, WidgetRef ref) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['json'],
        dialogTitle: 'Select Note-Go backup file',
      );

      if (result == null || result.files.single.path == null) return;

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
          child: Card(
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Importing data...'),
                ],
              ),
            ),
          ),
        ),
      );

      final file = File(result.files.single.path!);
      final jsonString = await file.readAsString();
      final data = jsonDecode(jsonString) as Map<String, dynamic>;

      // Validate the backup file
      if (data['version'] == null || data['transactions'] == null) {
        throw Exception('Invalid backup file format');
      }

      final db = DatabaseService();

      // Clear existing data
      await db.transactionsBox.clear();
      await db.accountsBox.clear();
      await db.billsBox.clear();

      // Import transactions
      if (data['transactions'] != null) {
        for (final txData in data['transactions']) {
          final tx = TransactionModel(
            id: txData['id'],
            type: TransactionType.values[txData['type']],
            date: DateTime.parse(txData['date']),
            title: txData['title'],
            amount: (txData['amount'] as num).toDouble(),
            category: txData['category'],
            account: txData['account'],
            note: txData['note'],
          );
          await db.transactionsBox.put(tx.id, tx);
        }
      }

      // Import accounts
      if (data['accounts'] != null) {
        for (final accData in data['accounts']) {
          final acc = Account(
            id: accData['id'],
            name: accData['name'],
            balance: (accData['balance'] as num).toDouble(),
            type: accData['type'],
            role: AccountRole.values[accData['role']],
          );
          await db.accountsBox.put(acc.id, acc);
        }
      }

      // Import bills
      if (data['bills'] != null) {
        for (final billData in data['bills']) {
          final bill = BillModel(
            id: billData['id'],
            title: billData['title'],
            amount: (billData['amount'] as num).toDouble(),
            dueDate: DateTime.parse(billData['dueDate']),
            paid: billData['paid'],
          );
          await db.billsBox.put(bill.id, bill);
        }
      }

      // FIXED: Proper provider refresh
      ref.read(transactionsProvider.notifier).refresh();
      ref.read(accountsProvider.notifier).refresh();
      ref.read(billsProvider.notifier).refresh();

      if (context.mounted) {
        Navigator.of(
          context,
          rootNavigator: true,
        ).pop(); // Close loading dialog
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '✅ Data imported successfully! ${data['transactions']?.length ?? 0} transactions restored.',
            ),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        Navigator.of(
          context,
          rootNavigator: true,
        ).pop(); // Close loading dialog
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('❌ Import failed: $e'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 5),
          ),
        );
      }
    }
  }

  void _showPrivacyPolicy(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Privacy Policy'),
        content: const SingleChildScrollView(
          child: Text(
            'Note-Go respects your privacy:\n\n'
            '• All data is stored locally on your device\n'
            '• No data is sent to external servers\n'
            '• Export/import gives you full control\n'
            '• No personal information is collected\n'
            '• No analytics or tracking\n\n'
            'Your financial privacy is our top priority.',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showHelpSupport(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Help & Support'),
        content: const SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '💡 Quick Tips:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text('• Add transactions from the dashboard'),
              Text('• Use categories to organize spending'),
              Text('• Export data regularly for backup'),
              Text('• Switch themes in preferences'),
              Text('• Swipe to edit transactions'),
              SizedBox(height: 16),
              Text(
                '🚀 Features:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text('• Multi-currency support'),
              Text('• Category management'),
              Text('• Data export/import (.json)'),
              Text('• Local-only storage'),
              Text('• Dark/light theme'),
              SizedBox(height: 16),
              Text(
                '📄 Import Format:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text('Only JSON files exported from Note-Go are supported.'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showClearDataConfirmation(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('⚠️ Clear All Data'),
        content: const Text(
          'This will permanently delete:\n\n'
          '• All transactions\n'
          '• All accounts\n'
          '• All bills\n'
          '• Reset app settings\n\n'
          'Categories will be preserved for future use.\n\n'
          '❌ This action cannot be undone!',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              _clearAllData(context, ref);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text(
              'Clear All',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  // FIXED: Clear data with immediate UI refresh
  Future<void> _clearAllData(BuildContext context, WidgetRef ref) async {
    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
          child: Card(
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Clearing data...'),
                ],
              ),
            ),
          ),
        ),
      );

      final db = DatabaseService();

      // Clear all data
      await db.transactionsBox.clear();
      await db.accountsBox.clear();
      await db.billsBox.clear();

      // Reset settings
      await ref.read(themeProvider.notifier).setTheme(false);
      const defaultCurrency = Currency(
        code: 'INR',
        symbol: '₹',
        name: 'Indian Rupee',
      );
      await ref.read(currencyProvider.notifier).setCurrency(defaultCurrency);

      // FIXED: Force immediate refresh of all providers
      ref.read(transactionsProvider.notifier).refresh();
      ref.read(accountsProvider.notifier).refresh();
      ref.read(billsProvider.notifier).refresh();

      // Small delay to ensure UI updates
      await Future.delayed(const Duration(milliseconds: 500));

      if (context.mounted) {
        Navigator.of(
          context,
          rootNavigator: true,
        ).pop(); // Close loading dialog
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('✅ All data cleared successfully!'),
            backgroundColor: Colors.orange,
            duration: Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        Navigator.of(
          context,
          rootNavigator: true,
        ).pop(); // Close loading dialog
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('❌ Failed to clear data: $e'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 5),
          ),
        );
      }
    }
  }
}

class _SettingsSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _SettingsSection({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, bottom: 8),
          child: Text(
            title,
            style: theme.textTheme.titleSmall?.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(children: children),
        ),
      ],
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final Widget? leading;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  const _SettingsTile({
    this.leading,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: leading,
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      subtitle: subtitle != null ? Text(subtitle!) : null,
      trailing: trailing,
      onTap: onTap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    );
  }
}
