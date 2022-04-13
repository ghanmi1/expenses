import 'package:flutter/material.dart';
import 'package:some_project/main.dart';
import 'package:some_project/models/transaction.dart';
import 'package:intl/intl.dart';
import 'package:some_project/widgets/chartBar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransaction;

  Chart(this.recentTransaction);

  List<Map<String, Object>> get groupTransactionValue {
    return List.generate(7, (index) {
      final weekday = DateTime.now().subtract(
        Duration(days: index),
      );
      var totalSum = 0.00;
      for (var i = 0; i < recentTransaction.length; i++) {
        if (recentTransaction[i].dateTime.day == weekday.day &&
            recentTransaction[i].dateTime.year == weekday.year &&
            recentTransaction[i].dateTime.month == weekday.month) {
          totalSum += recentTransaction[i].amount;
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

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: Mycolor1,
      margin: EdgeInsets.all(15),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: groupTransactionValue.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                data['amount'],
                data['day'],
                maxSpending == 0
                    ? 0.0
                    : (data['amount'] as double) / maxSpending,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
