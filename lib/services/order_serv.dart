import 'package:supabase_flutter/supabase_flutter.dart';

class OrderService {
  final supabase = Supabase.instance.client;

  Future<void> placeOrder({
    required int tableNumber,
    required List<Map<String, dynamic>> items,
    required double total,
  }) async {
    await supabase.from('orders').insert({
      'table_number': tableNumber,
      'items': items,
      'total': total,
      'status': 'Pending',
    });
  }

  Stream<List<Map<String, dynamic>>> streamOrders() {
    return supabase.from('orders').stream(primaryKey: ['id']);
  }

  Future<void> updateOrderStatus(int id, String status) async {
    await supabase.from('orders').update({'status': status}).eq('id', id);
  }
}
