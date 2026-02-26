class OrderModel {
  final String id;
  final int tableNumber;
  final double totalPrice;
  final String status;

  OrderModel({
    required this.id,
    required this.tableNumber,
    required this.totalPrice,
    required this.status,
  });

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id'],
      tableNumber: map['table_number'],
      totalPrice: (map['total_price'] as num).toDouble(),
      status: map['status'],
    );
  }
}
