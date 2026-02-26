import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/menuItem_model.dart';
import '../models/menuItems.dart';

class MenuService {
  final supabase = Supabase.instance.client;

  /// 🔹 ADMIN MENU (unchanged)
  Future<List<MenuItemModel>> getMenu() async {
    final response = await supabase.from('menu_items').select();
    final List data = response as List;

    return data
        .map((item) => MenuItemModel.fromMap(Map<String, dynamic>.from(item)))
        .toList();
  }

  /// 🔹 USER MENU (NEW & CLEAN)
  Future<List<MenuItem>> getUserMenu() async {
    final response = await supabase.from('menu_items').select();
    final List data = response as List;

    return data
        .map((item) => MenuItem.fromJson(Map<String, dynamic>.from(item)))
        .toList();
  }

  /// ADMIN CRUD (unchanged)
  Future<void> addMenuItem(String name, double price) async {
    await supabase.from('menu_items').insert({'name': name, 'price': price});
  }

  Future<void> updateMenuItem(String id, String name, double price) async {
    await supabase
        .from('menu_items')
        .update({'name': name, 'price': price})
        .eq('id', id);
  }

  Future<void> deleteMenuItem(String id) async {
    await supabase.from('menu_items').delete().eq('id', id);
  }
}
