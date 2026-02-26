import 'package:flutter/material.dart';
import 'package:quick_bite/models/order_model.dart';
import 'package:quick_bite/services/order_serv.dart';

class AdminOrdersPage extends StatefulWidget {
  const AdminOrdersPage({super.key});

  @override
  State<AdminOrdersPage> createState() => _AdminOrdersPageState();
}

class _AdminOrdersPageState extends State<AdminOrdersPage> {
  final OrderService _orderService = OrderService();
  late Future<List<OrderModel>> _ordersFuture;

  @override
  void initState() {
    super.initState();
    _loadOrders();
  }

  void _loadOrders() {
    _ordersFuture = _orderService.getOrders();
  }

  Future<void> _updateStatus(String orderId, String status) async {
    await _orderService.updateStatus(orderId, status);
    setState(() {
      _loadOrders(); // refresh list
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pending Orders")),
      body: FutureBuilder<List<OrderModel>>(
        future: _ordersFuture,
        builder: (context, snapshot) {
          // Loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // Error
          if (snapshot.hasError) {
            return const Center(child: Text("Failed to load orders"));
          }

          final orders = snapshot.data ?? [];

          // Empty
          if (orders.isEmpty) {
            return const Center(child: Text("No pending orders"));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: orders.length,
            itemBuilder: (_, index) {
              final order = orders[index];

              return Card(
                elevation: 3,
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  title: Text(
                    "Table ${order.tableNumber}",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text("৳${order.totalPrice}"),
                  trailing: DropdownButton<String>(
                    value: order.status,
                    underline: const SizedBox(),
                    items: const [
                      DropdownMenuItem(
                        value: 'pending',
                        child: Text('Pending'),
                      ),
                      DropdownMenuItem(
                        value: 'preparing',
                        child: Text('Preparing'),
                      ),
                      DropdownMenuItem(value: 'served', child: Text('Served')),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        _updateStatus(order.id, value);
                      }
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
