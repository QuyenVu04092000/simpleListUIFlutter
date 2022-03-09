import 'package:flutter/material.dart';
class Transaction {
  late String content;
  late double amount;
  late DateTime createdDate;
  // constructor
  Transaction({required this.content, required this.amount,required this.createdDate});

  @override
  String toString() {
    // TODO: implement toString
    return 'content: $content, amount: $amount';
  }
}