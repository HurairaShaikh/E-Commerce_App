import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> cart = [];

  void addProduct(Map<String, dynamic> product) {
    final index = cart.indexWhere(
      (item) =>
          item["title"] == product["title"] && item["size"] == product["size"],
    );

    if (index != -1) {
      cart[index]["quantity"] = (cart[index]["quantity"] ?? 1) + 1;
    } else {
      final newProduct = Map<String, dynamic>.from(product);
      newProduct["quantity"] = 1;
      cart.add(newProduct);
    }

    notifyListeners();
  }

  void removeProduct(Map<String, dynamic> product) {
    cart.remove(product);
    notifyListeners();
  }

  void increaseQuantity(Map<String, dynamic> item) {
    item["quantity"] = (item["quantity"] ?? 1) + 1;
    notifyListeners();
  }

  void decreaseQuantity(Map<String, dynamic> item) {
    if ((item["quantity"] ?? 1) > 1) {
      item["quantity"] -= 1;
    } else {
      cart.remove(item);
    }
    notifyListeners();
  }

  double get totalPrice {
    double total = 0;
    for (var item in cart) {
      final price = item["price"] as double;
      final quantity = item["quantity"] as int;
      total += price * quantity;
    }
    return total;
  }

  void clearCart() {
    cart.clear();
    notifyListeners();
  }
}
