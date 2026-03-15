import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;
  final void Function(Product product) onAddToCart;

  const ProductDetailScreen({
    super.key,
    required this.product,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ürün Detayı')),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          Container(
            height: 300,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(28),
            ),
            child: Padding(
              padding: const EdgeInsets.all(22),
              child: Hero(
                tag: 'product_${product.id}',
                child: Image.asset(product.image, fit: BoxFit.contain),
              ),
            ),
          ),
          const SizedBox(height: 18),
          Text(
            product.category,
            style: TextStyle(
              color: Colors.blueGrey.shade500,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            product.name,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              height: 1.15,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(Icons.star_rounded, color: Colors.amber.shade700),
              const SizedBox(width: 6),
              Text(
                '${product.rating.toStringAsFixed(1)} puan',
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              const Spacer(),
              Text(
                '₺${product.price.toStringAsFixed(0)}',
                style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 28,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          const Text(
            'Açıklama',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            product.description,
            style: TextStyle(
              height: 1.6,
              color: Colors.grey.shade800,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 26),
          FilledButton.icon(
            onPressed: () {
              onAddToCart(product);
              Navigator.pop(context);
            },
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            icon: const Icon(Icons.add_shopping_cart),
            label: const Text(
              'Sepete Ekle',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
