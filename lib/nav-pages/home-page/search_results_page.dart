import 'package:flutter/material.dart';
import 'package:srhcraftshop/models/product_model.dart';
import 'package:srhcraftshop/widgets/product_tile.dart';

class SearchResultsPage extends StatelessWidget {
  final String searchQuery; // words for search
  final List<Product> searchResults; // list of products for  search

  const SearchResultsPage({
    super.key,
    required this.searchQuery,
    required this.searchResults,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Results for "$searchQuery"'),
      ),
      body: searchResults.isEmpty

      // if no products match the search
          ? const Center(child: Text('No products found.'))
      // if found display in a grid
          : GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 0.7,
        ),
        itemCount: searchResults.length,
        itemBuilder: (context, index) {
          return ProductTile(product: searchResults[index]); //display each product
        },
      ),
    );
  }
}
