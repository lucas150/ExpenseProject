import 'package:hive/hive.dart';
part 'bill_model.g.dart';

@HiveType(typeId: 6)
class BillModel extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  String title;
  @HiveField(2)
  double amount;
  @HiveField(3)
  DateTime dueDate;
  @HiveField(4)
  bool paid;

  BillModel({
    required this.id,
    required this.title,
    required this.amount,
    required this.dueDate,
    this.paid = false,
  });
}
