import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  const NavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  final int selectedIndex; // track selected index
  final Function(int) onItemTapped; // callback function for item tap

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFE3E2DF),
      child: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          child: BottomNavigationBar(
            currentIndex: selectedIndex, // set active tab
            selectedItemColor: const Color(0xFFF6ECF6), // selected item
            unselectedItemColor: const Color(0x77353333), //  unselected items
            elevation: 0,
            onTap: onItemTapped, // function to handle tab change
            type: BottomNavigationBarType.shifting, // items change color when selected
            selectedLabelStyle: const TextStyle(
              fontSize: 12,
              height: 1.5,
            ),
            unselectedLabelStyle: const TextStyle(
              fontSize: 10,
              height: 1.5,
            ),
            items: const [
              // home tab
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Icon(Icons.home),
                ),
                label: 'Home',
                backgroundColor: Color(0xFF999999),
              ),
              // liked tab
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Icon(Icons.favorite),
                ),
                label: 'Liked',
                backgroundColor: Color(0xFF999999),
              ),
              // cart tab
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Icon(Icons.shopping_cart),
                ),
                label: 'Cart',
                backgroundColor: Color(0xFF999999),
              ),
              // settings tab
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Icon(Icons.settings),
                ),
                label: 'Settings',
                backgroundColor: Color(0xFF999999),
              ),
            ],
          ),
        ),
      ),
    );
  }
}






