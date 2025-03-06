import 'package:flutter/material.dart';
import 'package:srhcraftshop/nav-pages/cart_page.dart';
import 'package:srhcraftshop/nav-pages/favorite_page.dart';
import 'package:srhcraftshop/nav-pages/home_page.dart';
import 'package:srhcraftshop/nav-pages/settings_page.dart';
import 'nav_bar.dart';

class NavScreen extends StatefulWidget {
  const NavScreen({super.key});

  @override
  NavScreenState createState() => NavScreenState();
}

class NavScreenState extends State<NavScreen> {
  int _selectedIndex = 0; // track selected index

  // list of pages for navigation
  final List<Widget> _screens = [
    const HomePage(),
    const FavoritePage(),
    const CartPage(),
    const SettingsPage(),
  ];

  // function to change index when tab is tapped
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex], // show selected page
      bottomNavigationBar: NavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped, // handle tab change
      ),
    );
  }
}

