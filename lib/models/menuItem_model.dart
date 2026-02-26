class MenuItemModel {
  final String id;
  final String name;
  final double price;

  MenuItemModel({required this.id, required this.name, required this.price});

  factory MenuItemModel.fromMap(Map<String, dynamic> map) {
    return MenuItemModel(
      id: map['id'],
      name: map['name'],
      price: (map['price'] as num).toDouble(),
    );
  }
}
