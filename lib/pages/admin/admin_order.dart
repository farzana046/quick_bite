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
  late Future<List<OrderModel>> _orders;

  @override
  void initState() {
    super.initState();
    _orders = _orderService.getOrders();
  }

  void refresh() {
    setState(() {
      _orders = _orderService.getOrders();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Orders")),
      body: FutureBuilder<List<OrderModel>>(
        future: _orders,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final orders = snapshot.data!;

          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (_, index) {
              final order = orders[index];

              return Card(
                child: ListTile(
                  title: Text("Table ${order.tableNumber}"),
                  subtitle: Text("৳${order.totalPrice}"),
                  trailing: DropdownButton<String>(
                    value: order.status,
                    items: ["pending", "preparing", "served"]
                        .map(
                          (status) => DropdownMenuItem(
                            value: status,
                            child: Text(status),
                          ),
                        )
                        .toList(),
                    onChanged: (value) async {
                      await _orderService.updateStatus(order.id, value!);
                      refresh();
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
