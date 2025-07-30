import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/transaction_model.dart';
import '../../../core/services/database_service.dart';

final transactionsProvider =
    AsyncNotifierProvider<TransactionsNotifier, List<TransactionModel>>(
      TransactionsNotifier.new,
    );

class TransactionsNotifier extends AsyncNotifier<List<TransactionModel>> {
  @override
  Future<List<TransactionModel>> build() async {
    final box = DatabaseService().transactionsBox;
    return box.values.toList()..sort((a, b) => b.date.compareTo(a.date));
  }

  Future<void> addTransaction(TransactionModel transaction) async {
    state = const AsyncValue.loading();
    try {
      final box = DatabaseService().transactionsBox;
      await box.put(transaction.id, transaction);

      final updatedList = box.values.toList()
        ..sort((a, b) => b.date.compareTo(a.date));
      state = AsyncValue.data(updatedList);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> updateTransaction(TransactionModel transaction) async {
    state = const AsyncValue.loading();
    try {
      final box = DatabaseService().transactionsBox;
      await box.put(transaction.id, transaction);

      final updatedList = box.values.toList()
        ..sort((a, b) => b.date.compareTo(a.date));
      state = AsyncValue.data(updatedList);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> deleteTransaction(String id) async {
    state = const AsyncValue.loading();
    try {
      final box = DatabaseService().transactionsBox;
      await box.delete(id);

      final updatedList = box.values.toList()
        ..sort((a, b) => b.date.compareTo(a.date));
      state = AsyncValue.data(updatedList);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  // Calculate total income
  double get totalIncome {
    final transactions = state.value ?? [];
    return transactions
        .where((t) => t.type == TransactionType.income)
        .fold(0.0, (sum, t) => sum + t.amount);
  }

  // Calculate total expense
  double get totalExpense {
    final transactions = state.value ?? [];
    return transactions
        .where((t) => t.type == TransactionType.expense)
        .fold(0.0, (sum, t) => sum + t.amount);
  }

  // THIS IS THE MISSING GETTER - Net balance calculation (income - expenses)
  double get netBalance => totalIncome - totalExpense;

  // Group transactions by account, handling null accounts gracefully
  Map<String, List<TransactionModel>> get transactionsByAccount {
    final transactions = state.value ?? [];
    final grouped = <String, List<TransactionModel>>{};

    for (var transaction in transactions) {
      final accountName =
          transaction.account ?? 'No Account'; // Handle null accounts
      grouped.putIfAbsent(accountName, () => []).add(transaction);
    }

    return grouped;
  }

  // Get transactions for current month
  List<TransactionModel> get currentMonthTransactions {
    final transactions = state.value ?? [];
    final now = DateTime.now();
    return transactions
        .where((t) => t.date.year == now.year && t.date.month == now.month)
        .toList();
  }

  // Get expense transactions only
  List<TransactionModel> get expenseTransactions {
    final transactions = state.value ?? [];
    return transactions
        .where((t) => t.type == TransactionType.expense)
        .toList();
  }

  // Get income transactions only
  List<TransactionModel> get incomeTransactions {
    final transactions = state.value ?? [];
    return transactions.where((t) => t.type == TransactionType.income).toList();
  }
}
