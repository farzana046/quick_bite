import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_bite/services/order_serv.dart';
import '../services/cart_service.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  Future<void> _showTableSelection(BuildContext context) async {
    int selectedTable = 1;

    final cart = context.read<CartService>();
    final orderService = OrderService();

    await showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text("Select Table"),
          content: StatefulBuilder(
            builder: (context, setState) {
              return DropdownButton<int>(
                value: selectedTable,
                isExpanded: true,
                items: List.generate(
                  20,
                  (index) => DropdownMenuItem(
                    value: index + 1,
                    child: Text("Table ${index + 1}"),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    selectedTable = value!;
                  });
                },
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () async {
                await orderService.placeOrder(
                  tableNumber: selectedTable,
                  items: cart.items
                      .map(
                        (e) => {
                          'name': e.item.name,
                          'price': e.item.price,
                          'quantity': e.quantity,
                        },
                      )
                      .toList(),
                  total: cart.totalPrice,
                );

                cart.clearCart();
                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Order placed successfully!")),
                );
              },
              child: const Text("Confirm Order"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartService>();

    return Scaffold(
      appBar: AppBar(title: const Text("Cart")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (context, index) {
                final cartItem = cart.items[index];

                return ListTile(
                  title: Text(cartItem.item.name),
                  subtitle: Text(
                    "৳${cartItem.item.price} x ${cartItem.quantity} = ৳${cartItem.subtotal}",
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () => cart.decreaseQuantity(cartItem.item),
                        icon: const Icon(Icons.remove),
                      ),
                      IconButton(
                        onPressed: () => cart.increaseQuantity(cartItem.item),
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          /// TOTAL SECTION
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text(
                  "Total: ৳${cart.totalPrice}",
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: cart.items.isEmpty
                      ? null
                      : () => _showTableSelection(context),
                  child: const Text("Checkout"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
