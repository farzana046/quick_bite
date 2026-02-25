import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_bite/pages/cart_page.dart';
import 'package:quick_bite/services/cart_service.dart';
import 'package:quick_bite/constants/appcolors.dart';
import 'package:quick_bite/pages/admin/admin_login.dart';
import 'package:quick_bite/pages/staff/staff_login.dart';
import 'package:quick_bite/pages/home_page.dart';
import 'package:quick_bite/pages/role_select.dart';
import 'package:quick_bite/themes/theme_input.dart';
import 'package:quick_bite/themes/themecolor.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://wyijxzsqcnchfvsuxmzh.supabase.co',
    anonKey: 'sb_publishable_Qt2LlbxggXVLtc_6-rdqKQ_abdiuKme',
  );

  runApp(
    ChangeNotifierProvider(create: (_) => CartService(), child: const MyApp()),
  );
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
        '/role-select': (context) => const RoleSelect(),
        '/admin-login': (context) => const AdminLoginPage(),
        '/staff-login': (context) => const StaffLoginPage(),
        '/admin-home': (context) => HomePage(),
        '/staff-home': (context) => HomePage(),
        '/customer-home': (context) => HomePage(),
        '/cart': (context) => const CartPage(),
      },
    );
  }
}
