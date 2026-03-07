import 'package:flutter/material.dart';

class OrderHistoryProvider extends ChangeNotifier {
 final List<Map<String, dynamic>> _history = [];

  List<Map<String, dynamic>> get history => _history;

  void addOrder(List<Map<String, dynamic>> order) {
    _history.add({
      "products": List.from(order), // copy of cart
      "date": DateTime.now(),
      "total": order.fold<double>(
          0, (sum, item) => sum + (item["price"] as double) * (item["quantity"] as int)),
    });
    notifyListeners();
  }
}