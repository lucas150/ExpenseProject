import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/account_model.dart';
import '../../../core/services/database_service.dart';

final accountsProvider = AsyncNotifierProvider<AccountsNotifier, List<Account>>(
  AccountsNotifier.new,
);

class AccountsNotifier extends AsyncNotifier<List<Account>> {
  @override
  Future<List<Account>> build() async {
    final box = DatabaseService().accountsBox;
    return box.values.toList();
  }

  Future<void> addAccount(Account account) async {
    state = const AsyncValue.loading();
    try {
      final box = DatabaseService().accountsBox;
      await box.put(account.id, account);

      final updatedList = box.values.toList();
      state = AsyncValue.data(updatedList);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> updateAccount(Account account) async {
    state = const AsyncValue.loading();
    try {
      final box = DatabaseService().accountsBox;
      await box.put(account.id, account);

      final updatedList = box.values.toList();
      state = AsyncValue.data(updatedList);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> deleteAccount(String id) async {
    state = const AsyncValue.loading();
    try {
      final box = DatabaseService().accountsBox;
      await box.delete(id);

      final updatedList = box.values.toList();
      state = AsyncValue.data(updatedList);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  double get totalBalance {
    final accounts = state.value ?? [];
    return accounts.fold(0.0, (sum, account) => sum + account.balance);
  }
}
