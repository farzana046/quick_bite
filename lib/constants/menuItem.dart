class MenuItem {
  final String id;
  final String name;
  final String? description;
  final double price;
  final String? imageUrl;
  final bool isAvailable;

  MenuItem({
    required this.id,
    required this.name,
    this.description,
    required this.price,
    this.imageUrl,
    required this.isAvailable,
  });

  factory MenuItem.fromMap(Map<String, dynamic> map) {
    return MenuItem(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      price: (map['price'] as num).toDouble(),
      imageUrl: map['image_url'],
      isAvailable: map['is_available'] ?? true,
    );
  }
}
