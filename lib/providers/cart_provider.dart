import 'package:flutter/foundation.dart';

import '../models/cart_item.dart';
import '../models/menu.dart';
import '../services/total_calculator.dart';

class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);

  void addToCart(MenuItem menu) {
    final existing = _items.where((item) => item.menu.id == menu.id);
    if (existing.isNotEmpty) {
      existing.first.quantity += 1;
    } else {
      _items.add(CartItem(menu: menu));
    }
    notifyListeners();
  }

  void increment(String menuId) {
    final item = _items.firstWhere((cartItem) => cartItem.menu.id == menuId);
    item.quantity += 1;
    notifyListeners();
  }

  void decrement(String menuId) {
    final item = _items.firstWhere((cartItem) => cartItem.menu.id == menuId);
    if (item.quantity > 1) {
      item.quantity -= 1;
    } else {
      _items.remove(item);
    }
    notifyListeners();
  }

  void removeItem(String menuId) {
    _items.removeWhere((item) => item.menu.id == menuId);
    notifyListeners();
  }

  double get subtotal => _items.fold(
        0,
        (sum, item) => sum + item.lineTotal,
      );

  CartTotals get totals => TotalCalculator.calculate(subtotal);

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
