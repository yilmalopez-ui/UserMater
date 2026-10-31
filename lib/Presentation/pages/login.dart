import 'package:flutter/material.dart';

import 'auth_store.dart';
import 'auth_widgets.dart';
import 'recuperar_contrasena.dart';
import 'registrar.dart';
import 'dashboard_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  String? _message;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _openRegistration() async {
    final email = await Navigator.of(context).push<String>(
      MaterialPageRoute<String>(builder: (context) => const RegistrarPage()),
    );
    if (email != null) {
      _emailController.text = email;
    }
  }

  Future<void> _openRecovery() async {
    final passwordChanged = await Navigator.of(context).push<bool>(
      MaterialPageRoute<bool>(
        builder: (context) => const RecuperarContrasenaPage(),
      ),
    );
    if (passwordChanged == true && mounted) {
      setState(() => _message = 'Contraseña actualizada. Inicia sesión.');
    }
  }

  void _signIn() {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _message = null);

    final usuario = AuthStore.authenticate(
      _emailController.text,
      _passwordController.text,
    );
    if (usuario == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Correo o contraseña incorrectos.')),
      );
      return;
    }

    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(
        builder: (context) => DashboardPage(usuario: usuario),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AuthBackground(
      child: authCard(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const AuthTitle(
                title: '¡Qué bueno verte!',
                subtitle: 'Inicia sesión para continuar',
              ),
              const SizedBox(height: 28),
              TextFormField(
                key: const ValueKey('loginEmail'),
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                decoration: authInputDecoration(
                  label: 'Correo electrónico',
                  icon: Icons.email_outlined,
                ),
                validator: (value) {
                  final email = value?.trim() ?? '';
                  if (email.isEmpty || !email.contains('@')) {
                    return 'Ingresa un correo electrónico válido.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                key: const ValueKey('loginPassword'),
                controller: _passwordController,
                obscureText: _obscurePassword,
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (_) => _signIn(),
                decoration: authInputDecoration(
                  label: 'Contraseña',
                  icon: Icons.lock_outline,
                  suffixIcon: IconButton(
                    tooltip: _obscurePassword
                        ? 'Mostrar contraseña'
                        : 'Ocultar contraseña',
                    onPressed: () {
                      setState(() => _obscurePassword = !_obscurePassword);
                    },
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingresa tu contraseña.';
                  }
                  return null;
                },
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  key: const ValueKey('forgotPassword'),
                  onPressed: _openRecovery,
                  style: TextButton.styleFrom(
                    foregroundColor: const Color(0xFF176B5B),
                  ),
                  child: const Text('¿Olvidaste tu contraseña?'),
                ),
              ),
              const SizedBox(height: 8),
              if (_message != null) ...[
                Text(
                  _message!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xFF176B5B),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
              ],
              authSubmitButton(label: 'Iniciar sesión', onPressed: _signIn),
              const SizedBox(height: 12),
              authFooterLink(
                prompt: '¿Aún no tienes cuenta?',
                label: 'Regístrate',
                onPressed: _openRegistration,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
