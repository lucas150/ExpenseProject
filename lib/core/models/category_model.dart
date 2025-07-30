import 'package:hive/hive.dart';

part 'category_model.g.dart';

@HiveType(typeId: 4)
class ExpenseCategory extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  List<String> subcategories;

  ExpenseCategory({required this.name, this.subcategories = const []});
}

@HiveType(typeId: 5)
class IncomeCategory extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  List<String> subcategories;

  IncomeCategory({required this.name, this.subcategories = const []});
}
