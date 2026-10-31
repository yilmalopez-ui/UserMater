import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_application_1/main.dart';

void main() {
  testWidgets('registering and signing in works', (tester) async {
    tester.view.physicalSize = const Size(1280, 1200);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const MyApp());
    expect(find.text('Cargando...'), findsOneWidget);

    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();
    expect(find.text('¡Qué bueno verte!'), findsOneWidget);

    await tester.tap(find.text('Regístrate'));
    await tester.pumpAndSettle();
    expect(find.text('Completa tus datos para registrarte'), findsOneWidget);

    await tester.enterText(
      find.byKey(const ValueKey('registerName')),
      'Usuario de prueba',
    );
    await tester.enterText(
      find.byKey(const ValueKey('registerEmail')),
      'prueba@example.com',
    );
    await tester.enterText(
      find.byKey(const ValueKey('registerPassword')),
      'clave123',
    );
    await tester.enterText(
      find.byKey(const ValueKey('registerConfirmPassword')),
      'clave123',
    );
    await tester.tap(find.widgetWithText(FilledButton, 'Crear cuenta'));
    await tester.pumpAndSettle();

    expect(find.text('¡Qué bueno verte!'), findsOneWidget);
    expect(find.text('prueba@example.com'), findsOneWidget);

    await tester.enterText(
      find.byKey(const ValueKey('loginPassword')),
      'clave123',
    );
    await tester.tap(find.text('Iniciar sesión'));
    await tester.pumpAndSettle();

    expect(find.text('Hola, Usuario de prueba'), findsOneWidget);
    expect(find.byType(Card), findsNWidgets(5));

    await tester.tap(find.text('Perfil'));
    await tester.pumpAndSettle();
    expect(find.text('Usuario de prueba'), findsOneWidget);
    expect(find.text('prueba@example.com'), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('signOut')));
    await tester.pumpAndSettle();
    expect(find.text('¡Qué bueno verte!'), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('forgotPassword')));
    await tester.pumpAndSettle();
    expect(find.text('Recuperar contraseña'), findsOneWidget);

    await tester.enterText(
      find.byKey(const ValueKey('recoveryEmail')),
      'prueba@example.com',
    );
    await tester.enterText(
      find.byKey(const ValueKey('recoveryPassword')),
      'nueva123',
    );
    await tester.enterText(
      find.byKey(const ValueKey('recoveryConfirmPassword')),
      'nueva123',
    );
    await tester.tap(find.text('Cambiar contraseña'));
    await tester.pumpAndSettle();
    expect(find.text('Contraseña actualizada. Inicia sesión.'), findsOneWidget);

    await tester.enterText(
      find.byKey(const ValueKey('loginEmail')),
      'prueba@example.com',
    );
    await tester.enterText(
      find.byKey(const ValueKey('loginPassword')),
      'nueva123',
    );
    await tester.tap(find.text('Iniciar sesión'));
    await tester.pumpAndSettle();
    expect(find.text('Hola, Usuario de prueba'), findsOneWidget);
  });
}
