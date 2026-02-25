import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_bite/models/menuItems.dart';
import 'package:quick_bite/services/cart_service.dart';
import 'package:quick_bite/services/menu_service.dart';
import '../widgets/Name.dart';
import '../widgets/search.dart';
import '../widgets/catagories.dart';
import '../widgets/menu_card.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final MenuService _menuService = MenuService();
  final String selectedCategory = "All";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Menu"),
        actions: [
          Consumer<CartService>(
            builder: (context, cart, child) {
              return Stack(
                children: [
                  IconButton(
                    icon: const Icon(Icons.shopping_cart),
                    onPressed: () {
                      Navigator.pushNamed(context, '/cart');
                    },
                  ),

                  if (cart.totalItems > 0)
                    Positioned(
                      right: 5,
                      top: 5,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          cart.totalItems.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),

      body: SafeArea(
        child: StreamBuilder<List<MenuItem>>(
          stream: _menuService.streamMenuItems(selectedCategory),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            }

            final items = snapshot.data ?? [];

            if (items.isEmpty) {
              return const Center(child: Text("No items found"));
            }

            return ListView(
              children: [
                const RestaurantName(),
                const SearchWidget(),
                const CategoryButton(),
                const SizedBox(height: 10),
                ...items.map(
                  (item) => MenuCard(
                    item: item,
                    onAdd: () {
                      context.read<CartService>().addToCart(item);
                    },
                  ),
                ),
                const SizedBox(height: 20),
              ],
            );
          },
        ),
      ),
    );
  }
}
