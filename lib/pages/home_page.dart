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

  late Future<List<MenuItem>> _menuFuture; // ✅ cached future

  String selectedCategory = "All";
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    _menuFuture = _menuService.getUserMenu(); // ✅ fetch ONCE
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF7F0),
      body: SafeArea(
        child: FutureBuilder<List<MenuItem>>(
          future: _menuFuture,
          builder: (context, snapshot) {
            // Loading
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            // Error
            if (snapshot.hasError) {
              return const Center(child: Text("Something went wrong"));
            }

            final items = snapshot.data ?? [];

            /// ✅ FILTER LOCALLY (fast, no API call)
            final filteredItems = items.where((item) {
              final matchesCategory =
                  selectedCategory == "All" ||
                  item.category == selectedCategory;

              final matchesSearch = item.name.toLowerCase().contains(
                searchQuery,
              );

              return matchesCategory && matchesSearch;
            }).toList();

            return ListView(
              padding: const EdgeInsets.only(top: 16, bottom: 24),
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
                                  right: 2,
                                  top: 2,
                                  child: Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: const BoxDecoration(
                                      color: Colors.redAccent,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Text(
                                      cart.totalItems.toString(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 11,
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

                const SizedBox(height: 18),

                /// 🔹 SEARCH (NO LAG NOW)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SearchWidget(
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value.toLowerCase();
                      });
                    },
                  ),
                ),

                const SizedBox(height: 14),

                /// 🔹 CATEGORY FILTER
                CategoryButton(
                  selectedCategory: selectedCategory,
                  onCategorySelected: (category) {
                    setState(() {
                      selectedCategory = category;
                    });
                  },
                ),

                const SizedBox(height: 14),

                /// 🔹 EMPTY STATE
                if (filteredItems.isEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    child: Column(
                      children: const [
                        Icon(Icons.search_off, size: 48, color: Colors.black38),
                        SizedBox(height: 12),
                        Text(
                          "No items found",
                          style: TextStyle(fontSize: 16, color: Colors.black54),
                        ),
                      ],
                    ),
                  ),

                /// 🔹 MENU LIST
                ...filteredItems.map(
                  (item) => Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    child: MenuCard(
                      item: item,
                      onAdd: () {
                        context.read<CartService>().addToCart(item);
                      },
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
