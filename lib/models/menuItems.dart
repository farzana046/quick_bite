class MenuItem {
  final String id;
  final String name;
  final double price;
  final String imageUrl;
  final String description;
  final String category;

  MenuItem({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.description,
    required this.category,
  });

  factory MenuItem.fromJson(Map<String, dynamic> json) {
    return MenuItem(
      id: json['id'].toString(),
      name: json['name'] ?? '',
      price: (json['price'] as num).toDouble(),
      imageUrl: json['image_url'] ?? '',
      description: json['description'] ?? '',
      category: json['category'] ?? '',
    );
  }
}
