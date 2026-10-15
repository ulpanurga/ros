import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'screens/main_screen.dart';
import 'screens/login_screen.dart';
import 'screens/category_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fashion Store',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      initialRoute: '/',
      routes: {
        '/': (context) => const MainScreen(),
        '/login': (context) => const LoginScreen(),
        '/category': (context) => const CategoryScreen(),
      },
    );
  }
}