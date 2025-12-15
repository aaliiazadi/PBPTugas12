import 'menu.dart';

class CartItem {
  final MenuItem menu;
  int quantity;

  CartItem({
    required this.menu,
    this.quantity = 1,
  });

  double get lineTotal => menu.price * quantity;
}
