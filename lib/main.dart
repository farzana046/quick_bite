import 'package:flutter/material.dart';
import 'package:quick_bite/constants/appcolors.dart';
import 'package:quick_bite/pages/admin/admin_login.dart';
import 'package:quick_bite/pages/home_page.dart';
import 'package:quick_bite/themes/theme_input.dart';
import 'package:quick_bite/themes/themecolor.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'pages/role_select.dart';

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
      title: 'Chakhum',
      theme: ThemeData(
        colorScheme: ThemeColors.colorScheme,
        inputDecorationTheme: ThemeInput.inputDecoration,
        scaffoldBackgroundColor: AppColors.bg,
        shadowColor: AppColors.primary,
        cardColor: AppColors.error,
      ),

      home: const RoleSelect(),

      routes: {
        // role selection
        '/role-select': (context) => const RoleSelect(),

        // customer flow
        '/customer-home': (context) => const homePage(),

        // admin flow (login only for now)
        '/admin-login': (context) => const AdminLoginPage(),
      },
    );
  }
}
