import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  
  @override
  void initState() {
    super.initState();
    // Simula tiempo de carga de 3 segundos
    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;

      Navigator.pushReplacementNamed(context, '/login');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. Capa de imagen de fondo
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                // imagen assets
                image: AssetImage(
                  'imagen01.jpeg', // Ruta a tu imagen de fondo en los assets
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.flutter_dash, size: 100, color: Colors.white),
                SizedBox(height: 20),
                CircularProgressIndicator(color: Colors.white),
                SizedBox(height: 20),
                Text(
                  'Cargando...',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}