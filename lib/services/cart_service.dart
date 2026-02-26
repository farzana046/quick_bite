import 'package:flutter/material.dart';
import '../models/cart_item.dart';
import '../models/menuItems.dart';

class CartService extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  void addToCart(MenuItem menuItem) {
    final index = _items.indexWhere((e) => e.item.id == menuItem.id);

    if (index >= 0) {
      _items[index].quantity++;
    } else {
      _items.add(CartItem(item: menuItem));
    }
    notifyListeners();
  }

  void increaseQuantity(MenuItem menuItem) {
    final index = _items.indexWhere((e) => e.item.id == menuItem.id);
    if (index >= 0) {
      _items[index].quantity++;
      notifyListeners();
    }
  }

  void decreaseQuantity(MenuItem menuItem) {
    final index = _items.indexWhere((e) => e.item.id == menuItem.id);

    if (index >= 0) {
      if (_items[index].quantity > 1) {
        _items[index].quantity--;
      } else {
        _items.removeAt(index);
      }
      notifyListeners();
    }
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  double get totalPrice => _items.fold(0, (sum, item) => sum + item.subtotal);

  int get totalItems => _items.fold(0, (sum, item) => sum + item.quantity);
}
