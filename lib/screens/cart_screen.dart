import 'package:flutter/material.dart';
import '../models/product.dart';

class CartScreen extends StatelessWidget {
  final List<Product> cartItems;
  final void Function(Product product) onRemove;

  const CartScreen({
    super.key,
    required this.cartItems,
    required this.onRemove,
  });

  double get totalPrice =>
      cartItems.fold(0, (sum, item) => sum + item.price);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sepetim')),
      body: cartItems.isEmpty
          ? const Center(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Text(
                  'Sepetin şu anda boş.\nAna sayfadan ürün ekleyebilirsin.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: cartItems.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final product = cartItems[index];
                      return Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 74,
                              height: 74,
                              decoration: BoxDecoration(
                                color: const Color(0xFFF4F6FA),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Image.asset(product.image, fit: BoxFit.contain),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    product.category,
                                    style: TextStyle(
                                      color: Colors.blueGrey.shade500,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    '₺${product.price.toStringAsFixed(0)}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 17,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: () => onRemove(product),
                              icon: const Icon(Icons.delete_outline),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                  ),
                  child: SafeArea(
                    top: false,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Text(
                              'Toplam',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              '₺${totalPrice.toStringAsFixed(0)}',
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        FilledButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Bu proje eğitim amaçlıdır. Sipariş simülasyonu tamamlandı.'),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          },
                          style: FilledButton.styleFrom(
                            minimumSize: const Size(double.infinity, 52),
                          ),
                          child: const Text('Sepeti Onayla'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
