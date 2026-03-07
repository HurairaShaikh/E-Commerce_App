import 'package:ecommerce_app/global.dart';
import 'package:ecommerce_app/product/product_detail.dart';
import 'package:flutter/material.dart';
import 'product/product.dart';

class Homes extends StatefulWidget {
  const Homes({super.key});

  @override
  State<Homes> createState() => _HomesState();
}

class _HomesState extends State<Homes> {
  final List<String> filters = ["ALL", "Adidas", "Nike", "Gucci", "Bata"];
  String selectedfilter = '';
  @override
  void initState() {
    super.initState();
    selectedfilter = filters[0];
  }

  final border = const OutlineInputBorder(
    borderRadius: BorderRadius.horizontal(left: Radius.circular(50)),
    borderSide: BorderSide(color: Color.fromRGBO(225, 225, 225, 1)),
  );
  TextEditingController searchController = TextEditingController();
  List<Map<String, Object>> get filteredProducts {
    return product.where((item) {
      final title = item["title"].toString().toLowerCase();
      final brand = item["brand"].toString().toLowerCase();
      final search = searchController.text.toLowerCase();

      return title.contains(search) &&
          (selectedfilter == "ALL" || brand == selectedfilter.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //   backgroundColor: Colors.white,
      drawer: Drawer(
        
      ),
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "Shoes\nCollection",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: searchController,
                    onChanged: (value) {
                      setState(() {});
                    },
                    decoration: InputDecoration(
                      hintText: "Search",
                      prefixIcon: const Icon(Icons.search),
                      focusedBorder: border,
                      enabledBorder: border,
                      border: border,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: filters.length,
                itemBuilder: (context, index) {
                  final filter = filters[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedfilter = filter;
                        });
                      },
                      child: Chip(
                        backgroundColor: selectedfilter == filter
                            ? Theme.of(context).colorScheme.primary
                            : const Color.fromRGBO(245, 247, 249, 1),
                        label: Text(filter),
                        labelStyle: const TextStyle(fontSize: 16),
                        side: const BorderSide(
                          color: Color.fromRGBO(245, 247, 249, 1),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredProducts.length,
                itemBuilder: (context, index) {
                  final products = filteredProducts[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Product(product: products),
                        ),
                      );
                    },
                    child: ProductDetail(
                      title: products["title"] as String,
                      price: products["price"] as double,
                      image: products["imageurl"] as String,
                      background: index.isEven
                          ? const Color.fromRGBO(216, 240, 253, 1)
                          : const Color.fromRGBO(245, 247, 249, 1),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
