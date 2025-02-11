import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  const NavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  final int selectedIndex; // Track the currently selected index
  final Function(int) onItemTapped; // Callback function for item tap

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFE3E2DF), // Match the background color
      child: Theme(
        data: ThemeData(
          splashColor: Colors.transparent, // Remove splash effect
          highlightColor: Colors.transparent, // Remove highlight effect
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ), // Rounded top edges only
          child: BottomNavigationBar(
            currentIndex: selectedIndex, // Set the current index
            selectedItemColor: const Color(0xFFF6ECF6), // Color of the selected item
            unselectedItemColor: const Color(0x77353333), // Color of unselected items
            elevation: 0, // Remove the shadow effect
            onTap: onItemTapped, // Function that handles item tap
            type: BottomNavigationBarType.shifting, // Enable expanding behavior
            selectedLabelStyle: const TextStyle(
              fontSize: 12,
              height: 1.5, // Space between icon and label
            ),
            unselectedLabelStyle: const TextStyle(
              fontSize: 10,
              height: 1.5, // Space between icon and label
            ),
            items: const [
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(top: 10), // Space above the icon
                  child: Icon(Icons.home),
                ),
                label: 'Home',
                backgroundColor: Color(0xFF999999), // Background for selected item
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(top: 20), // Space above the icon
                  child: Icon(Icons.favorite),
                ),
                label: 'Liked',
                backgroundColor: Color(0xFF999999), // Background for selected item
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(top: 10), // Space above the icon
                  child: Icon(Icons.shopping_cart),
                ),
                label: 'Cart',
                backgroundColor: Color(0xFF999999), // Background for selected item
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(top: 10), // Space above the icon
                  child: Icon(Icons.settings),
                ),
                label: 'Settings',
                backgroundColor: Color(0xFF999999), // Background for selected item
              ),
            ],
          ),
        ),
      ),
    );
  }
}





