import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> seedProducts() async {
  final col = FirebaseFirestore.instance.collection('products');
  final items = [
    {'name': 'Базовая футболка', 'category': 'Женщины', 'price': 5990, 'discount': 0, 'image': 'https://picsum.photos/seed/w1/400/500', 'description': 'Мягкая хлопковая футболка свободного кроя.'},
    {'name': 'Джинсы Slim', 'category': 'Женщины', 'price': 15990, 'discount': 20, 'image': 'https://picsum.photos/seed/w2/400/500', 'description': 'Классические джинсы с высокой посадкой.'},
    {'name': 'Платье миди', 'category': 'Женщины', 'price': 19990, 'discount': 30, 'image': 'https://picsum.photos/seed/w3/400/500', 'description': 'Лёгкое платье на каждый день.'},
    {'name': 'Худи оверсайз', 'category': 'Мужчины', 'price': 17990, 'discount': 0, 'image': 'https://picsum.photos/seed/m1/400/500', 'description': 'Тёплое худи с капюшоном.'},
    {'name': 'Рубашка Oxford', 'category': 'Мужчины', 'price': 12990, 'discount': 10, 'image': 'https://picsum.photos/seed/m2/400/500', 'description': 'Классическая рубашка из хлопка.'},
    {'name': 'Брюки чинос', 'category': 'Мужчины', 'price': 14990, 'discount': 0, 'image': 'https://picsum.photos/seed/m3/400/500', 'description': 'Удобные брюки прямого кроя.'},
    {'name': 'Детская куртка', 'category': 'Дети', 'price': 16990, 'discount': 25, 'image': 'https://picsum.photos/seed/k1/400/500', 'description': 'Тёплая куртка для прогулок.'},
    {'name': 'Детский свитшот', 'category': 'Дети', 'price': 7990, 'discount': 0, 'image': 'https://picsum.photos/seed/k2/400/500', 'description': 'Мягкий свитшот с принтом.'},
  ];
  for (final item in items) {
    await col.add(item);
  }
}