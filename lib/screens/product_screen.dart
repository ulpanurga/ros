import 'package:flutter/material.dart';
import '../models/cart.dart';
import '../models/product.dart';

class ProductScreen extends StatefulWidget {
  final Product product;
  const ProductScreen({super.key, required this.product});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final sizes = ['XS', 'S', 'M', 'L', 'XL'];
  String selectedSize = 'M';

  @override
  Widget build(BuildContext context) {
    final p = widget.product;

    return Scaffold(
      appBar: AppBar(title: Text(p.name)),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  p.image,
                  height: 380,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const SizedBox(
                    height: 380,
                    child: Icon(Icons.broken_image, size: 60),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(p.name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  ),
                  Text(
                    '${p.finalPrice.toStringAsFixed(0)} ₸',
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFFE50010)),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(p.description),
              const SizedBox(height: 20),
              const Text('Размер', style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: sizes.map((s) {
                  return ChoiceChip(
                    label: Text(s),
                    selected: selectedSize == s,
                    onSelected: (_) => setState(() => selectedSize = s),
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  Cart.instance.add(p, selectedSize);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Добавлено в корзину')),
                  );
                  Navigator.pop(context);
                },
                child: const Text('В КОРЗИНУ'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}