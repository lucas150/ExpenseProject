import 'package:expense_project/core/models/bill_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/transaction_model.dart';
import '../models/account_model.dart';
import '../models/category_model.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  factory DatabaseService() => _instance;
  DatabaseService._internal();

  late Box<TransactionModel> _transactionsBox;
  late Box<Account> _accountsBox;
  late Box<ExpenseCategory> _expenseCategoriesBox;
  late Box<IncomeCategory> _incomeCategoriesBox;
  late Box<BillModel> _billsBox;

  Box<TransactionModel> get transactionsBox => _transactionsBox;
  Box<Account> get accountsBox => _accountsBox;
  Box<ExpenseCategory> get expenseCategoriesBox => _expenseCategoriesBox;
  Box<IncomeCategory> get incomeCategoriesBox => _incomeCategoriesBox;
  Box<BillModel> get billsBox => _billsBox;

  Future<void> init() async {
    await Hive.initFlutter();

    // Register adapters
    Hive.registerAdapter(TransactionModelAdapter());
    Hive.registerAdapter(TransactionTypeAdapter());
    Hive.registerAdapter(AccountAdapter());
    Hive.registerAdapter(AccountRoleAdapter());
    Hive.registerAdapter(ExpenseCategoryAdapter());
    Hive.registerAdapter(IncomeCategoryAdapter());
    Hive.registerAdapter(BillModelAdapter());

    // Open boxes
    _transactionsBox = await Hive.openBox<TransactionModel>('transactions');
    _accountsBox = await Hive.openBox<Account>('accounts');
    _billsBox = await Hive.openBox<BillModel>('bills');

    _expenseCategoriesBox = await Hive.openBox<ExpenseCategory>(
      'expense_categories',
    );
    _incomeCategoriesBox = await Hive.openBox<IncomeCategory>(
      'income_categories',
    );

    // Seed categories (always useful) but make accounts optional
    await _seedDefaultData();
  }

  Future<void> _seedDefaultData() async {
    // CHANGED: Don't automatically create accounts - let users add them when they want
    // This allows users to start tracking expenses immediately without account setup

    // Still seed categories as they're always useful for organization
    if (_expenseCategoriesBox.isEmpty) {
      final categories = [
        ExpenseCategory(
          name: 'Food & Dining',
          subcategories: ['Restaurant', 'Groceries', 'Coffee'],
        ),
        ExpenseCategory(
          name: 'Transportation',
          subcategories: ['Fuel', 'Public Transport', 'Taxi'],
        ),
        ExpenseCategory(
          name: 'Shopping',
          subcategories: ['Clothing', 'Electronics', 'Books'],
        ),
        ExpenseCategory(
          name: 'Bills & Utilities',
          subcategories: ['Electricity', 'Internet', 'Phone'],
        ),
        ExpenseCategory(
          name: 'Entertainment',
          subcategories: ['Movies', 'Games', 'Sports'],
        ),
        ExpenseCategory(name: 'Other', subcategories: ['Miscellaneous']),
      ];

      for (var category in categories) {
        await _expenseCategoriesBox.put(category.name, category);
      }
    }

    if (_incomeCategoriesBox.isEmpty) {
      final categories = [
        IncomeCategory(
          name: 'Salary',
          subcategories: ['Base Salary', 'Bonus', 'Overtime'],
        ),
        IncomeCategory(
          name: 'Business',
          subcategories: ['Sales', 'Consulting', 'Freelance'],
        ),
        IncomeCategory(
          name: 'Investments',
          subcategories: ['Dividends', 'Interest', 'Capital Gains'],
        ),
        IncomeCategory(
          name: 'Other',
          subcategories: ['Gifts', 'Refunds', 'Cashback'],
        ),
      ];

      for (var category in categories) {
        await _incomeCategoriesBox.put(category.name, category);
      }
    }
  }

  // Helper method to add a sample account when user wants one
  Future<void> addSampleAccount() async {
    if (_accountsBox.isEmpty) {
      await _accountsBox.put(
        'wallet',
        Account(
          id: 'wallet',
          name: 'My Wallet',
          balance: 0.0,
          type: 'Cash',
          role: AccountRole.both,
        ),
      );
    }
  }

  Future<void> close() async {
    await _transactionsBox.close();
    await _accountsBox.close();
    await _expenseCategoriesBox.close();
    await _incomeCategoriesBox.close();
    await _billsBox.close();
  }
}
