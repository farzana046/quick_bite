import 'package:flutter/material.dart';

class CategoryButton extends StatelessWidget {
  final String selectedCategory;
  final Function(String) onCategorySelected;

  const CategoryButton({
    Key? key,
    required this.selectedCategory,
    required this.onCategorySelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categories = ['All', 'Burgers', 'Pizza', 'Desserts', 'Drinks'];

    return Container(
      height: 48,
      margin: const EdgeInsets.only(left: 18, right: 18, bottom: 32),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = selectedCategory == category;

          return isSelected
              ? ElevatedButton(
                  onPressed: () => onCategorySelected(category),
                  child: Text(category),
                )
              : OutlinedButton(
                  onPressed: () => onCategorySelected(category),
                  child: Text(category),
                );
        },
      ),
    );
  }
}