// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AccountAdapter extends TypeAdapter<Account> {
  @override
  final int typeId = 3;

  @override
  Account read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Account(
      id: fields[0] as String,
      name: fields[1] as String,
      balance: fields[2] as double,
      type: fields[3] as String,
      role: fields[4] as AccountRole,
    );
  }

  @override
  void write(BinaryWriter writer, Account obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.balance)
      ..writeByte(3)
      ..write(obj.type)
      ..writeByte(4)
      ..write(obj.role);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AccountAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class AccountRoleAdapter extends TypeAdapter<AccountRole> {
  @override
  final int typeId = 2;

  @override
  AccountRole read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return AccountRole.transaction;
      case 1:
        return AccountRole.saving;
      case 2:
        return AccountRole.both;
      default:
        return AccountRole.transaction;
    }
  }

  @override
  void write(BinaryWriter writer, AccountRole obj) {
    switch (obj) {
      case AccountRole.transaction:
        writer.writeByte(0);
        break;
      case AccountRole.saving:
        writer.writeByte(1);
        break;
      case AccountRole.both:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AccountRoleAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
