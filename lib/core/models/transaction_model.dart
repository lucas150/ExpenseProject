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
  TransactionModel copyWith({
    String? id,
    TransactionType? type,
    DateTime? date,
    String? title,
    double? amount,
    String? category,
    String? account,
    String? note,
  }) {
    return TransactionModel(
      id: id ?? this.id,
      type: type ?? this.type,
      date: date ?? this.date,
      title: title ?? this.title,
      amount: amount ?? this.amount,
      category: category ?? this.category,
      account: account ?? this.account,
      note: note ?? this.note,
    );
  }
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
