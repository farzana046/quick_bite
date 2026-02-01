import 'package:flutter/material.dart';
import 'package:quick_bite/constants/big_text.dart';
import 'package:quick_bite/constants/small_text.dart';

class RestaurantName extends StatelessWidget {
  const RestaurantName({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BigText(text: 'Chakhum'),
          SmallText(text: 'A Gardening Restaurant'),
        ],
      ),
    );
  }
}
