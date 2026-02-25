import 'menuItems.dart';

class CartItem {
  final MenuItem item;
  int quantity;

  CartItem({required this.item, this.quantity = 1});

  double get subtotal => item.price * quantity;
}
