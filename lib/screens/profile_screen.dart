import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'about_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Профиль')),
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          final user = snapshot.data;
          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircleAvatar(radius: 40, child: Icon(Icons.person, size: 40)),
                    const SizedBox(height: 16),
                    Text(user?.email ?? 'Вы не вошли в аккаунт'),
                    const SizedBox(height: 24),
                    if (user == null)
                      ElevatedButton(
                        onPressed: () => Navigator.pushNamed(context, '/login'),
                        child: const Text('ВОЙТИ'),
                      )
                    else
                      ElevatedButton(
                        onPressed: () => FirebaseAuth.instance.signOut(),
                        child: const Text('ВЫЙТИ'),
                      ),
                    const SizedBox(height: 12),
                    OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const AboutScreen(title: 'О магазине'),
                          ),
                        );
                      },
                      child: const Text('О магазине'),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}