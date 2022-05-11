import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Transaction {
  DateTime dateTime;
  final String id;
  final double amount;
  final String title;

  Transaction(
      {@required this.amount,
      @required this.dateTime,
      @required this.id,
      @required this.title});
}

class UserTransaction with ChangeNotifier {
  List<Transaction> _transactions = [
    Transaction(
        amount: 56, dateTime: DateTime.now(), id: 't1', title: 'new shoes'),
    Transaction(
        amount: 56, dateTime: DateTime.now(), id: 't2', title: 'new Tshirt'),
    Transaction(
        amount: 56, dateTime: DateTime.now(), id: 't3', title: 'new shoes'),
    Transaction(
        amount: 56, dateTime: DateTime.now(), id: 't4', title: 'new Tshirt'),
    Transaction(
        amount: 56, dateTime: DateTime.now(), id: 't5', title: 'new shoes'),
    Transaction(
        amount: 56, dateTime: DateTime.now(), id: 't6', title: 'new Tshirt'),
    Transaction(
        amount: 56, dateTime: DateTime.now(), id: 't7', title: 'new shoes'),
    Transaction(
        amount: 56, dateTime: DateTime.now(), id: 't8', title: 'new Tshirt'),
  ];

  List<Transaction> get transaction {
    return [..._transactions];
  }

  List<Transaction> get recentTransactions {
    return _transactions.where((tx) {
      return tx.dateTime.isAfter(
        DateTime.now().subtract(Duration(days: 7)),
      );
    }).toList();
  }

  void addTransaction(Transaction transaction) {
    final newTrx = Transaction(
        amount: transaction.amount,
        dateTime: transaction.dateTime,
        id: DateTime.now().toString(),
        title: transaction.title);
    _transactions.insert(0, newTrx);
    notifyListeners();
  }

  void deleteTransaction(String id) {
    _transactions.removeWhere((element) {
      return element.id == id;
    });
    notifyListeners();
  }

  List<Map<String, Object>> get groupTransactionValue {
    return List.generate(7, (index) {
      final weekday = DateTime.now().subtract(
        Duration(days: index),
      );
      var totalSum = 0.00;
      for (var i = 0; i < _transactions.length; i++) {
        if (_transactions[i].dateTime.day == weekday.day &&
            _transactions[i].dateTime.year == weekday.year &&
            _transactions[i].dateTime.month == weekday.month) {
          totalSum += _transactions[i].amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekday).substring(0, 1),
        'amount': totalSum
      };
    }).reversed.toList();
  }

  double get maxSpending {
    return groupTransactionValue.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }
}
