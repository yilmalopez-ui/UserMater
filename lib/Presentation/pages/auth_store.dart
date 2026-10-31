class Usuario {
  final String nombre;
  final String email;
  String password;

  Usuario({required this.nombre, required this.email, required this.password});
}

class AuthStore {
  AuthStore._();

  static final List<Usuario> _usuarios = [];

  static Usuario? authenticate(String email, String password) {
    for (final usuario in _usuarios) {
      if (usuario.email == email.trim().toLowerCase() &&
          usuario.password == password) {
        return usuario;
      }
    }
    return null;
  }

  static String? register({
    required String nombre,
    required String email,
    required String password,
  }) {
    final normalizedEmail = email.trim().toLowerCase();
    if (_usuarios.any((usuario) => usuario.email == normalizedEmail)) {
      return 'Ya existe una cuenta con ese correo.';
    }

    _usuarios.add(
      Usuario(
        nombre: nombre.trim(),
        email: normalizedEmail,
        password: password,
      ),
    );
    return null;
  }

  static bool changePassword({
    required String email,
    required String password,
  }) {
    final normalizedEmail = email.trim().toLowerCase();
    for (final usuario in _usuarios) {
      if (usuario.email == normalizedEmail) {
        usuario.password = password;
        return true;
      }
    }
    return false;
  }
}
