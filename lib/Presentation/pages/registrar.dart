import 'package:flutter/material.dart';

import 'auth_store.dart';
import 'auth_widgets.dart';

class RegistrarPage extends StatefulWidget {
  const RegistrarPage({super.key});

  @override
  State<RegistrarPage> createState() => _RegistrarPageState();
}

class _RegistrarPageState extends State<RegistrarPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _register() {
    if (!_formKey.currentState!.validate()) return;

    final error = AuthStore.register(
      nombre: _nameController.text,
      email: _emailController.text,
      password: _passwordController.text,
    );
    if (error != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
      return;
    }

    Navigator.pop(context, _emailController.text.trim().toLowerCase());
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
                title: 'Crear cuenta',
                subtitle: 'Completa tus datos para registrarte',
              ),
              const SizedBox(height: 26),
              TextFormField(
                key: const ValueKey('registerName'),
                controller: _nameController,
                textCapitalization: TextCapitalization.words,
                textInputAction: TextInputAction.next,
                decoration: authInputDecoration(
                  label: 'Nombre completo',
                  icon: Icons.person_outline,
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Ingresa tu nombre.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 14),
              TextFormField(
                key: const ValueKey('registerEmail'),
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
              const SizedBox(height: 14),
              TextFormField(
                key: const ValueKey('registerPassword'),
                controller: _passwordController,
                obscureText: _obscurePassword,
                textInputAction: TextInputAction.next,
                decoration: authInputDecoration(
                  label: 'Contraseña',
                  icon: Icons.lock_outline,
                  suffixIcon: IconButton(
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
                  if (value == null || value.length < 6) {
                    return 'Usa al menos 6 caracteres.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 14),
              TextFormField(
                key: const ValueKey('registerConfirmPassword'),
                controller: _confirmPasswordController,
                obscureText: _obscureConfirmPassword,
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (_) => _register(),
                decoration: authInputDecoration(
                  label: 'Confirmar contraseña',
                  icon: Icons.lock_outline,
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(
                        () => _obscureConfirmPassword =
                            !_obscureConfirmPassword,
                      );
                    },
                    icon: Icon(
                      _obscureConfirmPassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value != _passwordController.text) {
                    return 'Las contraseñas no coinciden.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 22),
              authSubmitButton(label: 'Crear cuenta', onPressed: _register),
              const SizedBox(height: 8),
              authFooterLink(
                prompt: '¿Ya tienes una cuenta?',
                label: 'Inicia sesión',
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}