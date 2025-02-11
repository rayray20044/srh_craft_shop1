import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:srhcraftshop/services/cart_provider.dart';
import 'login_screen.dart';
import 'nav_screen.dart';
import 'package:srhcraftshop/nav-pages/cart_page.dart'; // If you need direct navigation to cart

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()), // Your CartProvider
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Your App Name',
        initialRoute: '/',
        routes: {
          '/': (context) => const LoginScreen(),
          '/navscreen': (context) => const NavScreen(),
          '/cart': (context) => const CartPage(), // Add this if you want a direct route to the cart
        },
      ),
    );
  }
}





