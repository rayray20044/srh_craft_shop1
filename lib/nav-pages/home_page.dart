import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../services/product_service.dart';
import '../widgets/product_tile.dart';
import '../widgets/search_bar.dart';
import 'package:srhcraftshop/nav-pages/home-page/categories_stuff.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Product> allProducts = [];
  List<Product> filteredProducts = [];
  bool isLoading = true;
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      final products = await ProductService.fetchProducts();
      setState(() {
        allProducts = products;
        filteredProducts = products;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      debugPrint('Error fetching products: $e');
    }
  }

  void updateSearch(String query) {
    setState(() {
      searchQuery = query.toLowerCase();
      filteredProducts = allProducts
          .where((product) => product.title.toLowerCase().contains(searchQuery))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            SearchBarr(onSearch: updateSearch),
            CategoriesSection(),
            _buildFeaturedHeader(),
            _buildFeaturedProductGrid(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Hello, Rayan!',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[300],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            "FEATURED ITEMS",
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 24,
              color: Color(0xFFE41B13),
            ),
          ),
          Divider(color: Colors.red, thickness: 2),

        ],
      ),
    );
  }

  Widget _buildFeaturedProductGrid() {
    return Expanded(
      child: isLoading
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.8,
        ),
        itemCount: filteredProducts.length,
        itemBuilder: (context, index) {
          var product = filteredProducts[index];
          return ProductTile(product: product);
        },
      ),
    );
  }
}
