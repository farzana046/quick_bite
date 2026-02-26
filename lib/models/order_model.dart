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
      id: map['id'].toString(), // DB id is int
      tableNumber: map['table_number'] as int,
      totalPrice: (map['total'] as num).toDouble(), // column is `total`
      status: map['status'].toString().toLowerCase(),
    );
  }
}
