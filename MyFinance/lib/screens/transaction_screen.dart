import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/transaction.dart';
import '../providers/transactions_provider.dart';
import 'add_transaction_screen.dart';

class TransactionScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactions = ref.watch(transactionsProvider);
    
    return Scaffold(
      appBar: AppBar(title: Text('Transactions')),
      body: transactions.isEmpty
          ? Center(child: Text("No transactions yet"))
          : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                final transaction = transactions[index];
                return ListTile(
                  title: Text(transaction.title),
                  subtitle: Text(transaction.amount.toString()),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      ref.read(transactionsProvider.notifier).deleteTransaction(transaction.id);
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTransactionScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
