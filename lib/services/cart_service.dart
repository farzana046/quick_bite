import 'package:flutter/material.dart';
import '../models/cart_item.dart';
import '../models/menuItems.dart';

class CartService extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  /// ADD TO CART
  void addToCart(MenuItem menuItem) {
    final index = _items.indexWhere(
      (element) => element.item.id == menuItem.id,
    );

    if (index >= 0) {
      _items[index].quantity++;
    } else {
      _items.add(CartItem(item: menuItem));
    }

    notifyListeners();
  }

  /// INCREASE QUANTITY
  void increaseQuantity(MenuItem menuItem) {
    final index = _items.indexWhere(
      (element) => element.item.id == menuItem.id,
    );

    if (index >= 0) {
      _items[index].quantity++;
      notifyListeners();
    }
  }

  /// DECREASE QUANTITY
  void decreaseQuantity(MenuItem menuItem) {
    final index = _items.indexWhere(
      (element) => element.item.id == menuItem.id,
    );

    if (index >= 0) {
      if (_items[index].quantity > 1) {
        _items[index].quantity--;
      } else {
        _items.removeAt(index);
      }
      notifyListeners();
    }
  }

  /// REMOVE ITEM COMPLETELY
  void removeItem(MenuItem menuItem) {
    _items.removeWhere((element) => element.item.id == menuItem.id);
    notifyListeners();
  }

  /// CLEAR CART
  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  /// TOTAL PRICE
  double get totalPrice {
    return _items.fold(
      0,
      (sum, item) => sum + (item.item.price * item.quantity),
    );
  }

  /// TOTAL ITEM COUNT
  int get totalItems {
    return _items.fold(0, (sum, item) => sum + item.quantity);
  }
}
