class OrderModel {
  final String id;
  final int tableNumber;
  final double totalPrice;
  final String status;
  final List<Map<String, dynamic>> items; // ✅ FIXED TYPE

  OrderModel({
    required this.id,
    required this.tableNumber,
    required this.totalPrice,
    required this.status,
    required this.items,
  });

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id'].toString(),
      tableNumber: map['table_number'] ?? 0,
      totalPrice: (map['total_price'] as num?)?.toDouble() ?? 0,
      status: map['status'] ?? 'pending',

      // ✅ SAFE JSON → LIST CONVERSION
      items:
          (map['items'] as List?)
              ?.map((e) => Map<String, dynamic>.from(e))
              .toList() ??
          [],
    );
  }
}
