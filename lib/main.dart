import 'package:final_mobile_computing_prject/screens/Map_screen.dart';
import 'package:final_mobile_computing_prject/screens/homepage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: homepage(),
    );
  }
}

