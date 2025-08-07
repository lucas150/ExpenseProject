import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/category_model.dart';
import '../../../core/services/database_service.dart';

final expenseCategoriesProvider =
    AsyncNotifierProvider<ExpenseCatNotifier, List<ExpenseCategory>>(
      ExpenseCatNotifier.new,
    );
final incomeCategoriesProvider =
    AsyncNotifierProvider<IncomeCatNotifier, List<IncomeCategory>>(
      IncomeCatNotifier.new,
    );

class ExpenseCatNotifier extends AsyncNotifier<List<ExpenseCategory>> {
  @override
  Future<List<ExpenseCategory>> build() async =>
      DatabaseService().expenseCategoriesBox.values.toList();

  Future<void> add(String name) async {
    final box = DatabaseService().expenseCategoriesBox;
    final cat = ExpenseCategory(name: name);
    await box.put(name, cat);
    state = AsyncValue.data(box.values.toList());
  }

  Future<void> addCategory(
    String name, [
    List<String> subcategories = const [],
  ]) async {
    final box = DatabaseService().expenseCategoriesBox;
    final cat = ExpenseCategory(name: name, subcategories: subcategories);
    await box.put(name, cat);
    state = AsyncValue.data(box.values.toList());
  }

  Future<void> editCategory(
    String oldName,
    String newName, [
    List<String>? subcategories,
  ]) async {
    final box = DatabaseService().expenseCategoriesBox;
    await box.delete(oldName);
    final updated = ExpenseCategory(
      name: newName,
      subcategories: subcategories ?? [],
    );
    await box.put(newName, updated);
    state = AsyncValue.data(box.values.toList());
  }

  Future<void> deleteCategory(String name) async {
    final box = DatabaseService().expenseCategoriesBox;
    await box.delete(name);
    state = AsyncValue.data(box.values.toList());
  }
}

class IncomeCatNotifier extends AsyncNotifier<List<IncomeCategory>> {
  @override
  Future<List<IncomeCategory>> build() async =>
      DatabaseService().incomeCategoriesBox.values.toList();

  Future<void> add(String name) async {
    final box = DatabaseService().incomeCategoriesBox;
    final cat = IncomeCategory(name: name);
    await box.put(name, cat);
    state = AsyncValue.data(box.values.toList());
  }

  Future<void> addCategory(
    String name, [
    List<String> subcategories = const [],
  ]) async {
    final box = DatabaseService().incomeCategoriesBox;
    final cat = IncomeCategory(name: name);
    await box.put(name, cat);
    state = AsyncValue.data(box.values.toList());
  }

  Future<void> editCategory(
    String oldName,
    String newName, [
    List<String>? subcategories,
  ]) async {
    final box = DatabaseService().incomeCategoriesBox;
    await box.delete(oldName);
    final updated = IncomeCategory(
      name: newName,
      subcategories: subcategories ?? [],
    );
    await box.put(newName, updated);
    state = AsyncValue.data(box.values.toList());
  }

  Future<void> deleteCategory(String name) async {
    final box = DatabaseService().incomeCategoriesBox;
    await box.delete(name);
    state = AsyncValue.data(box.values.toList());
  }
}
