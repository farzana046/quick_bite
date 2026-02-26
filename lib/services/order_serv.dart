import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/order_model.dart';

class OrderService {
  final supabase = Supabase.instance.client;

  Future<List<OrderModel>> getOrders() async {
    final response = await supabase
        .from('orders')
        .select()
        .order('created_at', ascending: false);

    // Force convert safely
    final List data = response as List;

    return data
        .map((order) => OrderModel.fromMap(Map<String, dynamic>.from(order)))
        .toList();
  }

  Future<void> updateStatus(String orderId, String status) async {
    await supabase.from('orders').update({'status': status}).eq('id', orderId);
  }

  Future<void> placeOrder({
    required int tableNumber,
    required List<Map<String, dynamic>> items,
    required double total,
  }) async {
    await supabase.from('orders').insert({
      'table_number': tableNumber,
      'items': items, // make sure this column is JSONB
      'total': total,
      'status': 'pending',
      'created_at': DateTime.now().toIso8601String(),
    });
  }
}
