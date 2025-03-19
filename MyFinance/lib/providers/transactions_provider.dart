import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/transaction.dart';
import 'package:hive/hive.dart';

final transactionBoxProvider = Provider<Box<TransactionModel>>((ref) {
  throw UnimplementedError();
});

class TransactionsNotifier extends StateNotifier<List<TransactionModel>> {
  final Box<TransactionModel> box;

  TransactionsNotifier(this.box) : super([]) {
    _loadTransactions();
    box.listenable().addListener(_loadTransactions);
  }

  void _loadTransactions() {
    state = box.values.toList();
  }

  void addTransaction(TransactionModel transaction) async {
    await box.put(transaction.id, transaction);
    _loadTransactions();
  }

  void editTransaction(String id, TransactionModel updatedTransaction) async {
    if (box.containsKey(id)) {
      await box.put(id, updatedTransaction);
      _loadTransactions();
    }
  }

  void deleteTransaction(String id) async {
    await box.delete(id);
    _loadTransactions();
  }
}

final transactionsProvider = StateNotifierProvider<TransactionsNotifier, List<TransactionModel>>(
    (ref) => TransactionsNotifier(ref.watch(transactionBoxProvider)));
