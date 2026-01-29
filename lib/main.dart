import 'package:flutter/material.dart';
import 'package:quick_bite/pages/admin/admin_login.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'pages/role_select.dart';
import 'pages/main_page.dart';
import 'pages/splash_screen.dart';

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(), // 👈 Splash Screen First
      routes: {
        '/admin-login': (context) => const AdminLoginPage(),
        '/admin-home': (context) => const mainPage(),
      },
    );
  }
}
