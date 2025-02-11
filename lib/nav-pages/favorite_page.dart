//fav
import 'package:flutter/material.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE3E2DF),
      body: Column(
        children: [
          // Custom Rounded AppBar
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            child: AppBar(
              backgroundColor: const Color(0xFFBC5D5D),
              elevation: 0,
              toolbarHeight: 90,
              title: const Text(
                'Liked Items',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFFE8E5E8),
                ),
              ),
              actions: const [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.grey,
                    child: Icon(
                      Icons.person,
                      size: 30,
                      color: Colors.white,
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
}