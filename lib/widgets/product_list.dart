import 'dart:convert';  // Import dart:convert for jsonDecode
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;  // Import the http package
import 'package:srhcraftshop/models/product_model.dart';
import 'package:srhcraftshop/widgets/product_tile.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  late Future<List<Product>> productList;

  @override
  void initState() {
    super.initState();
    productList = fetchProducts();
  }

  // Fetch all products
  Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse('https://dummyjson.com/products'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return (data['products'] as List)
          .map((product) => Product.fromJson(product))
          .toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
      future: productList,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No products available.'));
        }

        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,  // Number of products per row
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            return ProductTile(product: snapshot.data![index]);
          },
        );
      },
    );
  }
}

