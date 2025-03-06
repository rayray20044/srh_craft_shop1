import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../services/product_service.dart';
import '../widgets/product_tile.dart';
import 'package:srhcraftshop/nav-pages/home-page/categories_stuff.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Product> allProducts = []; // stores all products fetched from API
  List<Product> filteredProducts = []; // stores products filtered by search
  bool isLoading = true; // if data is still loading
  String searchQuery = ''; // stores the search query entered by the user

  @override
  void initState() {
    super.initState();
    fetchProducts(); // fetches products when the page loads
  }

  // function to fetch products from API
  Future<void> fetchProducts() async {
    try {
      final fetchedProducts = await ProductService.fetchProducts();
      setState(() {
        allProducts = fetchedProducts; // stores all fetched products
        filteredProducts = allProducts; // initially, all products are displayed
        isLoading = false; // sets loading to false when data is ready
      });
    } catch (e) {
      setState(() {
        isLoading = false; // stops loading if fetching fails
      });
    }
  }

  // function to update the displayed products based on search input
  void updateSearch(String query) {
    setState(() {
      searchQuery = query.toLowerCase();
      filteredProducts = allProducts
          .where((product) => product.name.toLowerCase().contains(searchQuery)) // filters products based on search
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          _buildAppBar(context), //  app bar
          _buildCategoriesHeader(), //  categories header
          CategoriesSection(), // displays category
          _buildFeaturedHeader(), // featured items header
          Expanded(
            child: _buildFeaturedProductGrid(), // fearured prodcts in a grid
          ),
        ],
      ),
    );
  }

  // custom app bar with search functionality
  Widget _buildAppBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 10,
        left: 20,
        right: 20,
        bottom: 20,
      ),
      decoration: BoxDecoration(
        color: Color(0xFFBC5D5D),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          //back button row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/'); // navigates  to home screen
                },
                child: Icon(Icons.arrow_back, color: Colors.white),
              ),
            ],
          ),
          SizedBox(height: 10),

          // greeting text
          Text(
            'Welcome!',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400, color: Colors.white),
          ),
          SizedBox(height: 15),

          //search bar
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Icon(Icons.search, color: Colors.grey),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    onChanged: updateSearch, //search result irl
                    decoration: InputDecoration(
                      hintText: 'Search what you need',
                      border: InputBorder.none,
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // function to build the categories section header
  Widget _buildCategoriesHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    );
  }

  // function to build the featured items section header
  Widget _buildFeaturedHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "FEATURED ITEMS", // title of the section
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 20,
              color: Color(0xFFEA6C6C), // sets text color
            ),
          ),
          Divider(color: Colors.red, thickness: 2), // red divider line
        ],
      ),
    );
  }

  //function for the grid layout products
  Widget _buildFeaturedProductGrid() {
    return isLoading
        ? Center(child: CircularProgressIndicator())
        : GridView.builder(
      padding: EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.7,
      ),
      itemCount: filteredProducts.length,
      itemBuilder: (context, index) {
        var product = filteredProducts[index];
        return ProductTile(product: product);
      },
    );
  }
}
