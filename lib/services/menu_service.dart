import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:quick_bite/models/menuItems.dart';

class MenuService {
  // Create Supabase client instance
  final supabase = Supabase.instance.client;

  // Fetch items by category
  Stream<List<MenuItem>> streamMenuItems(String category) {
    return supabase
        .from('menu_items')
        .stream(primaryKey: ['id'])
        .eq('category', category) // filtering
        .map((data) => data.map((item) => MenuItem.fromJson(item)).toList());
  }
}
