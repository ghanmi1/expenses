import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../main.dart';

import 'package:some_project/providers.dart/User_Transaction.dart';
import '../widgets/chartBar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransaction;

  Chart(this.recentTransaction);

  @override
  Widget build(BuildContext context) {
    final trans = Provider.of<UserTransaction>(context);
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: Mycolor1,
      margin: EdgeInsets.all(15),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: trans.groupTransactionValue.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                data['amount'],
                data['day'],
                trans.maxSpending == 0
                    ? 0.0
                    : (data['amount'] as double) / trans.maxSpending,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
