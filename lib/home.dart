import 'package:ecommerce_app/Authentication/log_out.dart';
import 'package:ecommerce_app/cart/cart.dart';
import 'package:ecommerce_app/home2.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int page = 0;
  List<Widget> currentpage = const [Homes(), Cartpage(), LogOut()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: IndexedStack(index: page, children: currentpage),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          setState(() {
            page = value;
          });
        },
        currentIndex: page,
        iconSize: 30,
        selectedFontSize: 0,
        unselectedFontSize: 0,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ""),
        ],
      ),
    );
  }
}
