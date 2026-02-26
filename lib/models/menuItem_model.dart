class MenuItemModel {
  final String id;
  final String name;
  final double price;
  final String category;

  MenuItemModel({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
  });

  factory MenuItemModel.fromMap(Map<String, dynamic> map) {
    return MenuItemModel(
      id: map['id'] as String,
      name: map['name'] as String,
      price: (map['price'] as num).toDouble(),
      category: map['category'] as String,
    );
  }
}
