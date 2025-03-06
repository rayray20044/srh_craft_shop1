import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'login_screen.dart';
import 'nav_screen.dart';
import 'nav-pages/cart_page.dart';
import 'nav-pages/order_review_page.dart';
import 'provider/cart_provider.dart';
import 'provider/favorite_provider.dart';

void main() {
  runApp(const MyApp()); // start app
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()), // provides cart state
        ChangeNotifierProvider(create: (_) => FavoriteProvider()), // provides favorite state
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false, // remove debug banner
        title: 'SRH Craft Shop', // app title
        theme: ThemeData(primarySwatch: Colors.red), // set theme color
        initialRoute: '/', // start on login screen
        routes: {
          '/': (context) => const LoginScreen(), // login screen
          '/navscreen': (context) => const NavScreen(), // main navigation screen
          '/cart': (context) =>  CartPage(), // cart screen
          '/order_review': (context) => OrderReviewPage(), // order review screen
        },
      ),
    );
  }
}




