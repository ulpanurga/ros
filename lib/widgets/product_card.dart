import 'package:flutter/material.dart';
import '../models/product.dart';
import '../screens/product_screen.dart';
import 'favorite_button.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // анонимный маршрут + передача параметра через конструктор
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => ProductScreen(product: product)),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: NetworkImage(product.image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                if (product.discount > 0)
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE50010),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        '-${product.discount}%',
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                const Positioned(top: 0, right: 0, child: FavoriteButton()),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            product.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          Row(
            children: [
              Text(
                '${product.finalPrice.toStringAsFixed(0)} ₸',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              if (product.discount > 0) ...[
                const SizedBox(width: 6),
                Text(
                  '${product.price.toStringAsFixed(0)} ₸',
                  style: const TextStyle(
                    color: Colors.grey,
                    decoration: TextDecoration.lineThrough,
                    fontSize: 12,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}