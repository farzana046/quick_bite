import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_bite/models/menuItems.dart';
import 'package:quick_bite/services/cart_service.dart';

class ProductDetailsPage extends StatelessWidget {
  final MenuItem item;

  const ProductDetailsPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF7F0),
      appBar: AppBar(elevation: 0, title: Text(item.name)),
      body: Column(
        children: [
          /// IMAGE
          if (item.imageUrl.isNotEmpty)
            ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
              child: Image.network(
                item.imageUrl,
                height: 260,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  height: 260,
                  color: Colors.black12,
                  alignment: Alignment.center,
                  child: const Text("Image not available"),
                ),
              ),
            ),

          /// DETAILS
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// NAME
                  Text(
                    item.name,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  /// PRICE
                  Text(
                    "৳${item.price}",
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.orange,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 16),

                  /// DESCRIPTION
                  Text(
                    item.description.isNotEmpty
                        ? item.description
                        : "No description available.",
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.black87,
                      height: 1.5,
                    ),
                  ),

                  const Spacer(),

                  /// ADD TO CART BUTTON
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        gradient: const LinearGradient(
                          colors: [Color(0xFFFFA726), Color(0xFFFF8F00)],
                        ),
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        onPressed: () {
                          context.read<CartService>().addToCart(item);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Added to cart")),
                          );
                        },
                        child: const Text(
                          "Add to Cart",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.4,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
