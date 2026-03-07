import 'package:ecommerce_app/order/order_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderHistoryPage extends StatelessWidget {
  const OrderHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final historyProvider = Provider.of<OrderHistoryProvider>(context);
    final history = historyProvider.history.reversed.toList(); // latest first

    return Scaffold(
      appBar: AppBar(title: const Text("Order History")),
      body: history.isEmpty
          ? const Center(child: Text("No orders yet"))
          : ListView.builder(
              itemCount: history.length,
              itemBuilder: (context, index) {
                final order = history[index];
                final date = order["date"] as DateTime;
                final products = order["products"] as List<dynamic>;
                final total = order["total"] as double;

                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ExpansionTile(
                    title: Text(
                      "Order on ${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
                    ),
                    subtitle: Text("Total: \$${total.toStringAsFixed(2)}"),
                    children: products
                        .map(
                          (item) => ListTile(
                            title: Text(item["title"]),
                            subtitle: Text(
                              "${item["quantity"]} x \$${item["price"].toStringAsFixed(2)}",
                            ),
                          ),
                        )
                        .toList(),
                  ),
                );
              },
            ),
    );
  }
}
