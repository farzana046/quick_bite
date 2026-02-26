import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/order_model.dart';

class OrderService {
  final SupabaseClient supabase = Supabase.instance.client;

  /// Fetch ONLY pending orders
  /// Sorted by time, then table number
  Future<List<OrderModel>> getOrders() async {
    final response = await supabase
        .from('orders')
        .select()
        .eq('status', 'pending')
        .order('created_at', ascending: true)
        .order('table_number', ascending: true);

    return (response as List)
        .map((order) => OrderModel.fromMap(Map<String, dynamic>.from(order)))
        .toList();
  }

  /// Update order status safely
  Future<void> updateStatus(String orderId, String status) async {
    await supabase
        .from('orders')
        .update({'status': status.toLowerCase()})
        .eq('id', int.parse(orderId));
  }

  /// Place new order
  Future<void> placeOrder({
    required int tableNumber,
    required List<Map<String, dynamic>> items,
    required double total,
  }) async {
    await supabase.from('orders').insert({
      'table_number': tableNumber,
      'items': items, // JSONB
      'total': total,
      'status': 'pending',
    });
  }
}
