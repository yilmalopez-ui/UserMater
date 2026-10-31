import 'package:flutter/material.dart';
import 'Presentation/pages/splash.dart'; // Asegúrate de importar correctamente la página SplashPage
import 'Presentation/pages/login.dart'; 
import 'Presentation/pages/registrar.dart'; // Importar la página RegistrarPage
void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Sebas bugs", // Cambiar el nombre la pagina en la parte duperior
      debugShowCheckedModeBanner: false, // para quitar la linea roja de debug
       initialRoute: '/',
        routes: {
          '/': (context) => const SplashPage(),
          '/login': (context) => const LoginPage(),
          '/registrar': (context) => const RegistrarPage(),
        },
    );
  }
}
