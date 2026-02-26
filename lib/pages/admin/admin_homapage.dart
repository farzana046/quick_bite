import 'package:flutter/material.dart';
import 'package:quick_bite/pages/admin/admin_menupage.dart';
import 'package:quick_bite/pages/admin/admin_order.dart';

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Admin Panel")),
      body: Column(
        children: [
          ListTile(
            title: const Text("Manage Orders"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AdminOrdersPage()),
              );
            },
          ),
          ListTile(
            title: const Text("Manage Menu"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AdminMenuPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
