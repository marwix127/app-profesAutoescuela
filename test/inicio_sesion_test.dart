import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:profesor_autoescuela_app/infraestructure/services/firebase/firebase_authService.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class UserCredentialMock extends Mock implements UserCredential {}

class MockFirebaseAuthServices extends Mock implements FirebaseAuthService {
  @override
  final FirebaseAuth auth;

  MockFirebaseAuthServices(this.auth);
}

void main() {
  group('signInWithFirebase Tests', () {
    late MockFirebaseAuthServices mockFirebaseAuthServices;
    late MockFirebaseAuth mockFirebaseAuth;

    setUp(() {
      mockFirebaseAuth = MockFirebaseAuth();
      mockFirebaseAuthServices = MockFirebaseAuthServices(mockFirebaseAuth);
    });

    test('Inicio de sesión exitoso', () async {
      // Simular un inicio de sesión exitoso
      when(mockFirebaseAuth.signInWithEmailAndPassword(
        email: 'prueba@email.com',
        password: 'password123',
      )).thenAnswer((_) async => UserCredentialMock());

      var result = await mockFirebaseAuthServices.signInWithFirebase(
        'prueba@email.com',
        'password123',
      );
      expect(result, isA<UserCredentialMock>());
    });

    test('Error de FirebaseAuth', () async {
      // Simular una excepción de FirebaseAuth
      when(mockFirebaseAuth.signInWithEmailAndPassword(
        email: ('prueba@email.com'),
        password: ('password'),
      )).thenThrow(FirebaseAuthException(code: 'user-not-found'));

      var result = await mockFirebaseAuthServices.signInWithFirebase(
        'prueba@email.com',
        'password',
      );
      expect(result, 'user-not-found');
    });

    test('Otra excepción', () async {
      // Simular una excepción general
      when(mockFirebaseAuth.signInWithEmailAndPassword(
        email: ('prueba@email.com'),
        password: ('password'),
      )).thenThrow(Exception());

      var result = await mockFirebaseAuthServices.signInWithFirebase(
        'prueba@email.com',
        'password',
      );
      expect(result, null);
    });
  });
}
