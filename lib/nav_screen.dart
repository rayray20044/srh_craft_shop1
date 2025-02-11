import 'package:flutter/material.dart';
import 'package:srhcraftshop/nav-pages/cart_page.dart';
import 'package:srhcraftshop/nav-pages/favorite_page.dart';
import 'package:srhcraftshop/nav-pages/home_page.dart';
import 'package:srhcraftshop/nav-pages/settings_page.dart';
import 'nav_bar.dart'; // Import your NavBar widget

class NavScreen extends StatefulWidget {
  const NavScreen({super.key});

  @override
  NavScreenState createState() => NavScreenState();
}

class NavScreenState extends State<NavScreen> {
  int _selectedIndex = 0; // Track the currently selected index


  final List<Widget> _screens = [

    const HomePage(), // Home screen
    const FavoritePage(), // Favorite screen
    const CartPage(), // Cart screen
    const SettingsPage(), // Settings screen




    // const Center(child: Text('shopping/main page ', style: TextStyle(fontSize: 24))),
    //
    //
    // const Center(child: Text('page for what people may like', style: TextStyle(fontSize: 24))),
    //
    //
    // const Center(child: Text('people buy here', style: TextStyle(fontSize: 24))),
    //
    //
    // const Center(child: Text('Settings Page test ', style: TextStyle(fontSize: 24))),
  ];


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: NavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
