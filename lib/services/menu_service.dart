import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/menuItem_model.dart';
import '../models/menuItems.dart';

class MenuService {
  final SupabaseClient supabase = Supabase.instance.client;

  /// 🔹 ADMIN MENU
  Future<List<MenuItemModel>> getMenu() async {
    final response = await supabase.from('menu_items').select();
    final List data = response as List;

    return data
        .map((item) => MenuItemModel.fromMap(Map<String, dynamic>.from(item)))
        .toList();
  }

  /// 🔹 USER MENU
  Future<List<MenuItem>> getUserMenu() async {
    final response = await supabase.from('menu_items').select();
    final List data = response as List;

    return data
        .map((item) => MenuItem.fromJson(Map<String, dynamic>.from(item)))
        .toList();
  }

  /// 🔹 ADD MENU ITEM
  Future<void> addMenuItem({
    required String name,
    required double price,
    required String imageUrl,
    required String category,
  }) async {
    await supabase.from('menu_items').insert({
      'name': name,
      'price': price,
      'image_url': imageUrl,
      'category': category,
    });
  }

  /// 🔹 UPDATE MENU ITEM
  Future<void> updateMenuItem({
    required String id, // ✅ STRING
    required String name,
    required double price,
    required String imageUrl,
    required String category,
  }) async {
    await supabase
        .from('menu_items')
        .update({
          'name': name,
          'price': price,
          'image_url': imageUrl,
          'category': category,
        })
        .eq('id', id);
  }

  /// 🔹 DELETE MENU ITEM
  Future<void> deleteMenuItem(String id) async {
    await supabase.from('menu_items').delete().eq('id', id);
  }
}
