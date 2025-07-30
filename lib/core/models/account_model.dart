import 'package:hive/hive.dart';

part 'account_model.g.dart';

@HiveType(typeId: 2)
enum AccountRole {
  @HiveField(0)
  transaction,
  @HiveField(1)
  saving,
  @HiveField(2)
  both,
}

@HiveType(typeId: 3)
class Account extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final double balance;
  @HiveField(3)
  final String type;
  @HiveField(4)
  final AccountRole role;

  Account({
    required this.id,
    required this.name,
    required this.balance,
    required this.type,
    required this.role,
  });
}
