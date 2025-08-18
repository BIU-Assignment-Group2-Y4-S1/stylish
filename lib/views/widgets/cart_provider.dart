import 'package:flutter/foundation.dart';

class CartProvider with ChangeNotifier {
  final List<Map<String, dynamic>> _items = [];

  List<Map<String, dynamic>> get items => _items;
  int get totalItems {
    num count = 0;
    for (var item in _items) {
      count += item['quantity'] ?? 1;
    }
    return count.toInt();
  }

  // Add this getter to calculate the total price of the cart
  double get totalAmount {
    double total = 0.0;
    for (var item in _items) {
      final price = item['unitPrice'] is double
          ? item['unitPrice'] as double
          : double.tryParse(item['unitPrice'].toString()) ?? 0.0;
      final quantity = item['quantity'] ?? 1;
      total += price * quantity;
    }
    return total;
  }

  // Add product or increase quantity if already exists (by name + size)
  void addItem(Map<String, dynamic> product) {
    // Find existing item index
    int index = _items.indexWhere(
      (item) =>
          item['name'] == product['name'] && item['size'] == product['size'],
    );

    if (index != -1) {
      // If found, increase quantity
      _items[index]['quantity'] = (_items[index]['quantity'] ?? 1) + 1;
    } else {
      // Else, add new with quantity = 1 (if not provided)
      product['quantity'] = product['quantity'] ?? 1;
      _items.add(product);
    }

    notifyListeners();
  }

  // Update quantity explicitly if needed
  void updateQuantity(int index, int quantity) {
    if (index >= 0 && index < _items.length) {
      if (quantity > 0) {
        _items[index]['quantity'] = quantity;
      } else {
        _items.removeAt(index); // Remove if quantity zero or less
      }
      notifyListeners();
    }
  }

  void removeItem(int index) {
    _items.removeAt(index);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
