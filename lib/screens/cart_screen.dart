import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/cart.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  Future<void> checkout(BuildContext context) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      Navigator.pushNamed(context, '/login');
      return;
    }
    final cart = Cart.instance;
    await FirebaseFirestore.instance.collection('orders').add({
      'userEmail': user.email,
      'total': cart.total,
      'items': cart.items
          .map((i) => {'name': i.product.name, 'size': i.size, 'qty': i.qty})
          .toList(),
      'createdAt': FieldValue.serverTimestamp(),
    });
    cart.clear();
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Заказ оформлен!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Корзина')),
      body: ListenableBuilder(
        listenable: Cart.instance,
        builder: (context, _) {
          final items = Cart.instance.items;
          if (items.isEmpty) {
            return const Center(child: Text('Корзина пуста'));
          }
          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 700),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, i) {
                        final item = items[i];
                        return ListTile(
                          leading: Image.network(item.product.image, width: 50, fit: BoxFit.cover),
                          title: Text(item.product.name),
                          subtitle: Text('Размер ${item.size} • ${item.qty} шт.'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('${(item.product.finalPrice * item.qty).toStringAsFixed(0)} ₸'),
                              IconButton(
                                icon: const Icon(Icons.delete_outline),
                                onPressed: () => Cart.instance.remove(item),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                      border: Border(top: BorderSide(color: Colors.black12)),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Итого', style: TextStyle(fontSize: 18)),
                            Text(
                              '${Cart.instance.total.toStringAsFixed(0)} ₸',
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        ElevatedButton(
                          onPressed: () => checkout(context),
                          child: const Text('ОФОРМИТЬ ЗАКАЗ'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}