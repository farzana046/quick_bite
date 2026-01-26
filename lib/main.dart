import 'package:flutter/material.dart';
import 'package:quick_bite/pages/role_select.dart';
import 'package:quick_bite/pages/main_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://wyijxzsqcnchfvsuxmzh.supabase.co',
    anonKey: 'sb_publishable_Qt2LlbxggXVLtc_6-rdqKQ_abdiuKme',
  );

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
