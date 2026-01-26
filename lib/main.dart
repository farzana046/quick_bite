import 'package:flutter/material.dart';
import 'package:quick_bite/Screens/role_select.dart';
import 'package:quick_bite/Screens/main_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: mainPage(),
    );
  }
}
