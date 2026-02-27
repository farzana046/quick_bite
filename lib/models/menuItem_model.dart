class MenuItemModel {
  final String id; // ✅ UUID SAFE
  final String name;
  final double price;
  final String imageUrl;
  final String category;

  MenuItemModel({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.category,
  });

  factory MenuItemModel.fromMap(Map<String, dynamic> map) {
    return MenuItemModel(
      id: map['id'].toString(), // ✅ SAFE
      name: map['name']?.toString() ?? '',
      price: (map['price'] as num?)?.toDouble() ?? 0,
      imageUrl: map['image_url']?.toString() ?? '',
      category: map['category']?.toString() ?? 'Uncategorized',
    );
  }
}
