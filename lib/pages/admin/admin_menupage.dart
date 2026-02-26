import 'package:flutter/material.dart';
import 'package:quick_bite/models/menuItem_model.dart';
import 'package:quick_bite/pages/admin/edit_menu.dart';
import 'package:quick_bite/services/menu_service.dart';

class AdminMenuPage extends StatefulWidget {
  const AdminMenuPage({super.key});

  @override
  State<AdminMenuPage> createState() => _AdminMenuPageState();
}

class _AdminMenuPageState extends State<AdminMenuPage> {
  final MenuService _menuService = MenuService();
  late Future<List<MenuItemModel>> _menu;

  @override
  void initState() {
    super.initState();
    _menu = _menuService.getMenu();
  }

  void refresh() {
    setState(() {
      _menu = _menuService.getMenu();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Menu Management")),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const EditMenuItemPage()),
          );
          refresh();
        },
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder<List<MenuItemModel>>(
        future: _menu,
        builder: (_, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final menu = snapshot.data!;

          return ListView.builder(
            itemCount: menu.length,
            itemBuilder: (_, index) {
              final item = menu[index];

              return ListTile(
                title: Text(item.name),
                subtitle: Text("৳${item.price}"),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () async {
                    await _menuService.deleteMenuItem(item.id);
                    refresh();
                  },
                ),
                onTap: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => EditMenuItemPage(item: item),
                    ),
                  );
                  refresh();
                },
              );
            },
          );
        },
      ),
    );
  }
}
