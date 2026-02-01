import 'package:flutter/material.dart';
import 'package:quick_bite/widgets/Name.dart';
import 'package:quick_bite/widgets/catagories.dart';
import 'package:quick_bite/widgets/search.dart';

class homePage extends StatelessWidget {
  const homePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: const [RestaurantName(), SearchWidget(), CategoryButton()],
        ),
      ),
    );
  }
}
