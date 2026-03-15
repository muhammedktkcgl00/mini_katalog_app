import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/product_service.dart';
import '../widgets/product_card.dart';

class HomeScreen extends StatefulWidget {
  final int cartCount;
  final void Function() onCartPressed;
  final void Function(Product product) onProductTap;

  const HomeScreen({
    super.key,
    required this.cartCount,
    required this.onCartPressed,
    required this.onProductTap,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Product>> _productsFuture;
  List<Product> _allProducts = [];
  String _searchText = '';

  @override
  void initState() {
    super.initState();
    _productsFuture = ProductService.loadProducts();
  }

  List<Product> get _filteredProducts {
    if (_searchText.trim().isEmpty) return _allProducts;
    return _allProducts.where((product) {
      final query = _searchText.toLowerCase();
      return product.name.toLowerCase().contains(query) ||
          product.category.toLowerCase().contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredProducts;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Mini Katalog',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                onPressed: widget.onCartPressed,
                icon: const Icon(Icons.shopping_cart_outlined),
              ),
              if (widget.cartCount > 0)
                Positioned(
                  right: 10,
                  top: 8,
                  child: Container(
                    width: 18,
                    height: 18,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      widget.cartCount.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: FutureBuilder<List<Product>>(
        future: _productsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  'Ürünler yüklenirken hata oluştu.\n${snapshot.error}',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          _allProducts = snapshot.data ?? [];
          final currentProducts = _filteredProducts;

          return RefreshIndicator(
            onRefresh: () async {
              setState(() {
                _productsFuture = ProductService.loadProducts();
              });
            },
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(22),
                  child: Image.asset(
                    'assets/banner.png',
                    height: 180,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  onChanged: (value) {
                    setState(() {
                      _searchText = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Ürün veya kategori ara',
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(vertical: 14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Popüler Ürünler',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      '${currentProducts.length} ürün',
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                GridView.builder(
                  itemCount: currentProducts.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 14,
                    mainAxisSpacing: 14,
                    childAspectRatio: 0.72,
                  ),
                  itemBuilder: (context, index) {
                    return ProductCard(
                      product: currentProducts[index],
                      onTap: () => widget.onProductTap(currentProducts[index]),
                    );
                  },
                ),
                if (filtered.isEmpty)
                  const Padding(
                    padding: EdgeInsets.only(top: 40),
                    child: Center(
                      child: Text('Aramana uygun ürün bulunamadı.'),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
