import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../data/seed.dart';
import '../models/product.dart';
import 'product_card.dart';

class ProductsView extends StatelessWidget {
  final String? category;
  const ProductsView({super.key, this.category});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance.collection('products').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Ошибка: ${snapshot.error}');
        }
        if (!snapshot.hasData) {
          return const Padding(
            padding: EdgeInsets.all(32),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        var products = snapshot.data!.docs
            .map((d) => Product.fromMap(d.id, d.data()))
            .toList();

        if (products.isEmpty) {
          return Center(
            child: ElevatedButton(
              onPressed: seedProducts,
              child: const Text('Загрузить демо-товары'),
            ),
          );
        }

        if (category != null) {
          products = products.where((p) => p.category == category).toList();
        }

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: products.length,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 220,
            childAspectRatio: 0.62,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemBuilder: (context, i) => ProductCard(product: products[i]),
        );
      },
    );
  }
}