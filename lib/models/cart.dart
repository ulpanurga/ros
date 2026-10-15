import 'package:flutter/foundation.dart';
import 'product.dart';

class CartItem {
  final Product product;
  final String size;
  int qty;
  CartItem(this.product, this.size, this.qty);
}

class Cart extends ChangeNotifier {
  Cart._();
  static final Cart instance = Cart._();

  final List<CartItem> items = [];

  void add(Product p, String size) {
    final index = items.indexWhere((i) => i.product.id == p.id && i.size == size);
    if (index >= 0) {
      items[index].qty++;
    } else {
      items.add(CartItem(p, size, 1));
    }
    notifyListeners();
  }

  void remove(CartItem item) {
    items.remove(item);
    notifyListeners();
  }

  void clear() {
    items.clear();
    notifyListeners();
  }

  double get total =>
      items.fold(0, (sum, i) => sum + i.product.finalPrice * i.qty);
}