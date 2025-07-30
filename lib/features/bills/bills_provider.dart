import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/bill_model.dart';
import '../../../core/services/database_service.dart';

final billsProvider =
    AsyncNotifierProvider<BillsNotifier, List<BillModel>>(BillsNotifier.new);

class BillsNotifier extends AsyncNotifier<List<BillModel>> {
  @override
  Future<List<BillModel>> build() async =>
      DatabaseService().billsBox.values.toList();

  Future<void> add(BillModel bill) async {
    final box = DatabaseService().billsBox;
    await box.put(bill.id, bill);
    state = AsyncValue.data(box.values.toList());
  }

  Future<void> togglePaid(BillModel bill) async {
    bill.paid = !bill.paid;
    await bill.save();
    state = AsyncValue.data(DatabaseService().billsBox.values.toList());
  }
}
