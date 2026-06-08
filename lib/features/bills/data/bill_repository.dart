import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/mock/mock_network.dart';
import '../../saved_billers/data/saved_biller.dart';
import 'fetched_bill.dart';

abstract interface class BillRepository {
  Future<FetchedBill> fetchBill(String billerId, String account);
  Future<List<FetchedBill>> fetchDueBills(List<SavedBiller> saved);
}

class FakeBillRepository implements BillRepository {
  FakeBillRepository(this._network);

  final MockNetwork _network;

  static const _customers = [
    'Ramesh Kumar',
    'Priya Sharma',
    'Amit Patel',
    'Sunita Reddy',
    'Vikram Singh',
  ];

  static int _seedOf(String billerId, String account) =>
      '$billerId|$account'.codeUnits.fold(0, (sum, unit) => sum + unit);

  static FetchedBill _billFor(String billerId, String account) {
    final seed = _seedOf(billerId, account);
    final today = DateTime.now();
    return FetchedBill(
      billerId: billerId,
      account: account,
      customerName: _customers[seed % _customers.length],
      amountPaise: (seed % 4500 + 200) * 100,
      dueDate: DateTime(today.year, today.month, today.day)
          .add(Duration(days: seed % 15 - 3)),
      billNumber: 'BILL-${seed.toRadixString(16).toUpperCase()}-$seed',
    );
  }

  @override
  Future<FetchedBill> fetchBill(String billerId, String account) async {
    await _network.delay();
    return _billFor(billerId, account);
  }

  @override
  Future<List<FetchedBill>> fetchDueBills(List<SavedBiller> saved) async {
    await _network.delay(6);
    return [for (final s in saved) _billFor(s.billerId, s.account)];
  }
}

final billRepositoryProvider = Provider<BillRepository>(
  (ref) => FakeBillRepository(ref.watch(mockNetworkProvider)),
);
