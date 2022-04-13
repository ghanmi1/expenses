import 'package:flutter/foundation.dart';

class Transaction {
  final DateTime dateTime;
  final String id;
  final double amount;
  final String title;

  Transaction(
      {@required this.amount,
      @required this.dateTime,
      @required this.id,
      @required this.title});
}
