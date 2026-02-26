import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_bite/constants/appcolors.dart';
import 'package:quick_bite/models/menuItems.dart';
import 'package:quick_bite/services/cart_service.dart';
import 'package:quick_bite/services/menu_service.dart';
import '../widgets/Name.dart';
import '../widgets/search.dart';
import '../widgets/catagories.dart';
import '../widgets/menu_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final MenuService _menuService = MenuService();
  String selectedCategory = "All";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: FutureBuilder<List<MenuItem>>(
          /// 🔥 FIX #1: USE USER MENU
          future: _menuService.getUserMenu(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            }

            final items = snapshot.data ?? [];

            /// 🔹 FILTER BY CATEGORY
            final filteredItems = selectedCategory == "All"
                ? items
                : items
                      .where((item) => item.category == selectedCategory)
                      .toList();

            return ListView(
              padding: const EdgeInsets.symmetric(vertical: 16),
              children: [
                /// 🔹 TOP BAR
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const RestaurantName(),
                      Consumer<CartService>(
                        builder: (context, cart, child) {
                          return Stack(
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.shopping_cart,
                                  color: AppColors.primary,
                                  size: 28,
                                ),
                                onPressed: () {
                                  Navigator.pushNamed(context, '/cart');
                                },
                              ),
                              if (cart.totalItems > 0)
                                Positioned(
                                  right: 4,
                                  top: 4,
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
                                        fontWeight: FontWeight.bold,
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
                ),

                const SizedBox(height: 16),

                /// 🔹 SEARCH
                SearchWidget(onChanged: () {}),

                const SizedBox(height: 10),

                /// 🔹 CATEGORY FILTER
                CategoryButton(
                  selectedCategory: selectedCategory,
                  onCategorySelected: (category) {
                    setState(() {
                      selectedCategory = category;
                    });
                  },
                ),

                const SizedBox(height: 10),

                if (filteredItems.isEmpty)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Center(child: Text("No items found")),
                  ),

                /// 🔹 MENU LIST
                ...filteredItems.map(
                  (item) => MenuCard(
                    item: item, // 🔥 FIX #2: CORRECT MODEL
                    onAdd: () {
                      /// 🔥 FIX #3: ADD TO CART WORKS
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
