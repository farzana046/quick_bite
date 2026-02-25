import 'package:flutter/material.dart';
import '../models/menuItems.dart';

class MenuCard extends StatelessWidget {
  final MenuItem item;
  final VoidCallback onAdd;

  const MenuCard({super.key, required this.item, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            // 🔹 Item Image (if you have imageUrl)
            if (item.imageUrl != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  item.imageUrl!,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),

            const SizedBox(width: 12),

            // 🔹 Name + Price
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "৳${item.price}",
                    style: const TextStyle(fontSize: 14, color: Colors.black),
                  ),
                ],
              ),
            ),

            // 🔹 Add to Cart Button
            IconButton(
              icon: const Icon(Icons.add_shopping_cart),
              color: Colors.green,
              onPressed: onAdd, // 🔥 THIS CONNECTS TO CART
            ),
          ],
        ),
      ),
    );
  }
}
