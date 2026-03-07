import 'package:ecommerce_app/cart/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce_app/payments/pay.dart';

class Cartpage extends StatefulWidget {
  const Cartpage({super.key});

  @override
  State<Cartpage> createState() => _CartpageState();
}

class _CartpageState extends State<Cartpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CART", style: Theme.of(context).textTheme.titleMedium),
        centerTitle: true,
      ),
      body: Consumer<CartProvider>(
        builder: (context, cartProvider, child) {
          final cart = cartProvider.cart;
          if (cart.isEmpty) {
            return const Center(child: Text("Your cart is empty"));
          }
          return ListView.builder(
            itemCount: cart.length,
            itemBuilder: (context, index) {
              final cartitem = cart[index];
              final price = cartitem["price"] as double;
              final quantity = cartitem["quantity"] as int;
              return ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage(cartitem["imageurl"] as String),
                ),
                title: Text("${cartitem["title"]}"),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: quantity == 1
                          ? null
                          : () {
                              cartProvider.decreaseQuantity(cartitem);
                            },
                      child: const Icon(
                        Icons.remove,
                        size: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      quantity.toString(),
                      style: const TextStyle(fontSize: 14),
                    ),
                    InkWell(
                      onTap: () {
                        cartProvider.increaseQuantity(cartitem);
                      },
                      child: const Icon(
                        Icons.add,
                        size: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Text(
                      "\$${(price * quantity).toStringAsFixed(2)}", // subtotal
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                trailing: IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text(
                          "DELETE PRODUCT",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        content: const Text(
                          "Are you sure you want to remove the product?",
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text(
                              "NO",
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              cartProvider.removeProduct(cartitem);
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              "YES",
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  icon: const Icon(Icons.delete, color: Colors.red),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: Consumer<CartProvider>(
        builder: (context, cartProvider, child) {
          return Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: Colors.grey)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total: \$${cartProvider.totalPrice.toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      await Pay().makepayment(
                        cartProvider.totalPrice.toInt() * 100,
                        "usd",
                      );

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "Payment Sucessful",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          backgroundColor: Theme.of(
                            context,
                          ).colorScheme.primary,
                        ),
                      );
                      cartProvider.clearCart();
                      setState(() {});
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "Payment Failed",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          backgroundColor: Theme.of(
                            context,
                          ).colorScheme.primary,
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                  ),
                  child: Text(
                    "Checkout",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
