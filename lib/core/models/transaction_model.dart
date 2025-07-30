import 'package:hive/hive.dart';

part 'transaction_model.g.dart';

@HiveType(typeId: 0)
class TransactionModel extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  TransactionType type;
  @HiveField(2)
  DateTime date;
  @HiveField(3)
  String title;
  @HiveField(4)
  double amount;
  @HiveField(5)
  String? category;
  @HiveField(6)
  String? account; // Made explicitly nullable - users can add transactions without accounts
  @HiveField(7)
  String? note;

  TransactionModel({
    required this.id,
    required this.type,
    required this.date,
    required this.title,
    required this.amount,
    this.category,
    this.account, // Optional - no default value needed
    this.note,
  });
}

// UPDATED: Removed 'savings' - only Income and Expense
@HiveType(typeId: 1)
enum TransactionType {
  @HiveField(0)
  expense,
  @HiveField(1)
  income,
  // savings removed - no longer needed
}
