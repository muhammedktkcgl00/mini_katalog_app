import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/product.dart';

class ProductService {
  static Future<List<Product>> loadProducts() async {
    final jsonString = await rootBundle.loadString('lib/data/products.json');
    final List<dynamic> data = jsonDecode(jsonString) as List<dynamic>;
    return data
        .map((item) => Product.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
