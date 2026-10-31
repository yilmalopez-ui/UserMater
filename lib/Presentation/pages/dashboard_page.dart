import 'package:flutter/material.dart';

import 'auth_store.dart';
import 'profile_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({required this.usuario, super.key});

  final Usuario usuario;

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;

  static const _recentItems = [
    ('Revisar tareas pendientes', Icons.task_alt, 'Hace 10 minutos'),
    ('Nueva notificación recibida', Icons.notifications_none, 'Hace 1 hora'),
    ('Actualizar información de perfil', Icons.person_outline, 'Ayer'),
    ('Reunión de equipo programada', Icons.groups_outlined, 'Ayer'),
    ('Bienvenido a la aplicación', Icons.waving_hand_outlined, 'Esta semana'),
  ];

  @override
  Widget build(BuildContext context) {
    final isHome = _selectedIndex == 0;

    return Scaffold(
      appBar: AppBar(
        title: Text(isHome ? 'Inicio' : 'Perfil'),
        backgroundColor: const Color(0xFF176B5B),
        foregroundColor: Colors.white,
      ),
      body: isHome ? _buildHome() : ProfilePage(usuario: widget.usuario),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }

  Widget _buildHome() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'Hola, ${widget.usuario.nombre}',
          style: Theme.of(context).textTheme.headlineSmall
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          'Aquí tienes tus elementos recientes.',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 12),
        for (final item in _recentItems)
          Card(
            child: ListTile(
              leading: Icon(item.$2, color: const Color(0xFF176B5B)),
              title: Text(item.$1),
              subtitle: Text(item.$3),
            ),
          ),
      ],
    );
  }
}
