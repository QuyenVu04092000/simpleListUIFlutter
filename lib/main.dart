import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'MyApp.dart';

void main() {
  runApp(MaterialApp(
    title: 'Transaction app',
    theme: ThemeData(
      primaryColor: Colors.green[300]
    ),
    home: MyApp(),
  ));
}