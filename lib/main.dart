import 'package:flutter/material.dart';
import 'models/product.dart';
import 'screens/cart_screen.dart';
import 'screens/home_screen.dart';
import 'screens/product_detail_screen.dart';

void main() {
  runApp(const MiniKatalogApp());
}

class MiniKatalogApp extends StatelessWidget {
  const MiniKatalogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mini Katalog Uygulaması',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4F7ECF)),
        scaffoldBackgroundColor: const Color(0xFFF5F7FB),
        useMaterial3: true,
      ),
      home: const AppRoot(),
    );
  }
}

class AppRoot extends StatefulWidget {
  const AppRoot({super.key});

  @override
  State<AppRoot> createState() => _AppRootState();
}

class _AppRootState extends State<AppRoot> {
  final List<Product> _cartItems = [];

  void _addToCart(Product product) {
    setState(() {
      _cartItems.add(product);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product.name} sepete eklendi'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _removeFromCart(Product product) {
    setState(() {
      _cartItems.remove(product);
    });
  }

  void _openCart() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CartScreen(
          cartItems: _cartItems,
          onRemove: _removeFromCart,
        ),
      ),
    );
  }

  void _openDetail(Product product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ProductDetailScreen(
          product: product,
          onAddToCart: _addToCart,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return HomeScreen(
      cartCount: _cartItems.length,
      onCartPressed: _openCart,
      onProductTap: _openDetail,
    );
  }
}
