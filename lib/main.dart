import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'login_screen.dart';
import 'nav_screen.dart';
import 'nav-pages/cart_page.dart';
import 'package:srhcraftshop/provider/cart_provider.dart';
import 'package:srhcraftshop/provider/favorite_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()), // 🛒 Cart Provider
        ChangeNotifierProvider(create: (_) => FavoriteProvider()), // ❤️ Favorite Provider
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => const LoginScreen(),
          '/navscreen': (context) => const NavScreen(),
          '/cart': (context) => const CartPage(),
        },
      ),
    );
  }
}






