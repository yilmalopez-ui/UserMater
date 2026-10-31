import 'package:flutter/material.dart';

import 'auth_store.dart';
import 'login.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({required this.usuario, super.key});

  final Usuario usuario;

  void _signOut(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute<void>(builder: (context) => const LoginPage()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircleAvatar(radius: 52, child: Icon(Icons.person, size: 56)),
            const SizedBox(height: 16),
            Text(
              usuario.nombre,
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              usuario.email,
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            FilledButton.icon(
              key: const ValueKey('signOut'),
              onPressed: () => _signOut(context),
              icon: const Icon(Icons.logout),
              label: const Text('Cerrar sesión'),
              style: FilledButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
