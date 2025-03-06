import 'package:flutter/material.dart';
import 'package:srhcraftshop/models/product_model.dart';
import 'package:srhcraftshop/widgets/product_details_page.dart';

class ProductTile extends StatelessWidget {
  final Product product; // store product details
  const ProductTile({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // open product details page when tapped
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailPage(product: product),
          ),
        );
      },
      child: Card(
        elevation: 3, // add shadow effect
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), // rounded corners
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // product image
            Container(
              height: 120,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                child: Image.network(
                  product.thumbnail ?? 'https://via.placeholder.com/150',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.network('https://via.placeholder.com/150', fit: BoxFit.cover);
                  },
                ),
              ),
            ),

            // product name and price
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.name, style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 4),
                  Text(
                    "€${product.price.toStringAsFixed(2)}", // stringing price
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}












