import 'package:flutter/material.dart';

const _authAccent = Color(0xFF176B5B);

class AuthBackground extends StatelessWidget {
  final Widget child;

  const AuthBackground({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'imagen01.jpeg',
            fit: BoxFit.cover,
          ),
          const ColoredBox(color: Color(0x990A2524)),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 28,
                ),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 440),
                  child: child,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget authCard({required Widget child}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(28),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.96),
      borderRadius: BorderRadius.circular(24),
      boxShadow: const [
        BoxShadow(
          color: Color(0x33000000),
          blurRadius: 28,
          offset: Offset(0, 14),
        ),
      ],
    ),
    child: child,
  );
}

InputDecoration authInputDecoration({
  required String label,
  required IconData icon,
  Widget? suffixIcon,
}) {
  return InputDecoration(
    labelText: label,
    prefixIcon: Icon(icon, color: _authAccent),
    suffixIcon: suffixIcon,
    filled: true,
    fillColor: const Color(0xFFF5F7F6),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(color: Color(0xFFDCE4E1)),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(color: Color(0xFFDCE4E1)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(color: _authAccent, width: 1.5),
    ),
  );
}

class AuthTitle extends StatelessWidget {
  final String title;
  final String subtitle;

  const AuthTitle({required this.title, required this.subtitle, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CircleAvatar(
          radius: 30,
          backgroundColor: Color(0xFFE5F1ED),
          child: Icon(Icons.lock_open_rounded, color: _authAccent, size: 30),
        ),
        const SizedBox(height: 18),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Color(0xFF183D3A),
            fontSize: 26,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Color(0xFF66736F), height: 1.4),
        ),
      ],
    );
  }
}

Widget authSubmitButton({
  required String label,
  required VoidCallback onPressed,
}) {
  return SizedBox(
    width: double.infinity,
    height: 52,
    child: FilledButton(
      style: FilledButton.styleFrom(
        backgroundColor: _authAccent,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
      onPressed: onPressed,
      child: Text(
        label,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    ),
  );
}

Widget authFooterLink({
  required String prompt,
  required String label,
  required VoidCallback onPressed,
}) {
  return Wrap(
    alignment: WrapAlignment.center,
    crossAxisAlignment: WrapCrossAlignment.center,
    children: [
      Text(prompt, style: const TextStyle(color: Color(0xFF66736F))),
      TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(foregroundColor: _authAccent),
        child: Text(label, style: const TextStyle(fontWeight: FontWeight.w700)),
      ),
    ],
  );
}
