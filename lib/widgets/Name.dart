import 'package:flutter/material.dart';
import 'package:quick_bite/constants/big_text.dart';
import 'package:quick_bite/constants/small_text.dart';

class RestaurantName extends StatelessWidget {
  const RestaurantName({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Restaurant Name
          BigText(
            text: 'Chakhum',
            size: 30,
            color: Colors.orangeAccent,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              letterSpacing: 0.6, // 👈 premium feel
            ),
          ),

          const SizedBox(height: 4),

          // Tagline
          SmallText(text: 'A Gardening Restaurant', color: Colors.black54),
        ],
      ),
    );
  }
}
