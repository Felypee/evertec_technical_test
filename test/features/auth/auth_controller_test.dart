import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:evertec_technical_test/features/auth/service/auth_service.dart';
import 'package:evertec_technical_test/features/auth/controller/auth_controller.dart';
import 'package:evertec_technical_test/features/auth/models/user.dart';
import 'package:evertec_technical_test/core/error/exceptions.dart';

class MockAuthService extends Mock implements AuthService {}

void main() {
  late MockAuthService mockAuthService;
  late ProviderContainer container;

  setUp(() {
    mockAuthService = MockAuthService();

    // Setup default behaviors
    when(() => mockAuthService.getCurrentUser()).thenAnswer((_) async => null);
    when(() => mockAuthService.isAuthenticated()).thenAnswer((_) async => false);

    container = ProviderContainer(
      overrides: [
        authServiceProvider.overrideWithValue(mockAuthService),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  group('AuthController', () {
    group('login', () {
      test('debe cambiar estado a Authenticated cuando login es exitoso', () async {
        // Arrange
        final user = User(username: 'testuser', lastLogin: DateTime.now());
        when(() => mockAuthService.login(
          username: any(named: 'username'),
          password: any(named: 'password'),
        )).thenAnswer((_) async => user);

        final controller = container.read(authControllerProvider.notifier);
        var successCalled = false;

        // Act
        await controller.login(
          username: 'testuser',
          password: 'Password123!',
          onSuccess: () => successCalled = true,
          onError: (_) {},
        );

        // Assert
        final state = container.read(authControllerProvider);
        expect(state, isA<Authenticated>());
        expect((state as Authenticated).user.username, equals('testuser'));
        expect(successCalled, isTrue);
      });

      test('debe llamar onError cuando login falla', () async {
        // Arrange
        when(() => mockAuthService.login(
          username: any(named: 'username'),
          password: any(named: 'password'),
        )).thenThrow(const AuthException(message: 'Invalid credentials'));

        final controller = container.read(authControllerProvider.notifier);
        String? errorMessage;

        // Act
        await controller.login(
          username: 'testuser',
          password: 'wrongpassword',
          onSuccess: () {},
          onError: (error) => errorMessage = error,
        );

        // Assert
        expect(errorMessage, isNotNull);
        expect(errorMessage, contains('Invalid credentials'));
      });

      test('debe cambiar a estado Error cuando login falla', () async {
        // Arrange
        when(() => mockAuthService.login(
          username: any(named: 'username'),
          password: any(named: 'password'),
        )).thenThrow(const AuthException(message: 'Error'));

        final controller = container.read(authControllerProvider.notifier);

        // Act
        await controller.login(
          username: 'testuser',
          password: 'wrong',
          onSuccess: () {},
          onError: (_) {},
        );

        // Assert
        final state = container.read(authControllerProvider);
        expect(state, isA<AuthError>());
      });
    });

    group('logout', () {
      test('debe cambiar estado a Unauthenticated cuando logout es exitoso', () async {
        // Arrange
        final user = User(username: 'testuser', lastLogin: DateTime.now());
        when(() => mockAuthService.login(
          username: any(named: 'username'),
          password: any(named: 'password'),
        )).thenAnswer((_) async => user);
        when(() => mockAuthService.logout()).thenAnswer((_) async {});

        final controller = container.read(authControllerProvider.notifier);

        // Login first
        await controller.login(
          username: 'testuser',
          password: 'Password123!',
          onSuccess: () {},
          onError: (_) {},
        );

        var successCalled = false;

        // Act
        await controller.logout(
          onSuccess: () => successCalled = true,
          onError: (_) {},
        );

        // Assert
        final state = container.read(authControllerProvider);
        expect(state, isA<Unauthenticated>());
        expect(successCalled, isTrue);
      });

      test('debe llamar onError cuando logout falla', () async {
        // Arrange
        when(() => mockAuthService.logout()).thenThrow(
          const AuthException(message: 'Logout error'),
        );

        final controller = container.read(authControllerProvider.notifier);
        String? errorMessage;

        // Act
        await controller.logout(
          onSuccess: () {},
          onError: (error) => errorMessage = error,
        );

        // Assert
        expect(errorMessage, isNotNull);
      });
    });

    group('clearError', () {
      test('debe limpiar el estado de error', () async {
        // Arrange
        when(() => mockAuthService.login(
          username: any(named: 'username'),
          password: any(named: 'password'),
        )).thenThrow(const AuthException(message: 'Error'));

        final controller = container.read(authControllerProvider.notifier);

        // Create error state
        await controller.login(
          username: 'test',
          password: 'wrong',
          onSuccess: () {},
          onError: (_) {},
        );

        expect(container.read(authControllerProvider), isA<AuthError>());

        // Act
        controller.clearError();

        // Assert
        expect(container.read(authControllerProvider), isA<Unauthenticated>());
      });
    });

    group('isAuthenticated', () {
      test('debe retornar true cuando el usuario está autenticado', () async {
        // Arrange
        final user = User(username: 'testuser');
        when(() => mockAuthService.login(
          username: any(named: 'username'),
          password: any(named: 'password'),
        )).thenAnswer((_) async => user);

        final controller = container.read(authControllerProvider.notifier);

        await controller.login(
          username: 'testuser',
          password: 'Password123!',
          onSuccess: () {},
          onError: (_) {},
        );

        // Assert
        expect(controller.isAuthenticated, isTrue);
      });

      test('debe retornar false cuando el usuario no está autenticado', () {
        // Arrange
        final controller = container.read(authControllerProvider.notifier);

        // Assert
        expect(controller.isAuthenticated, isFalse);
      });
    });

    group('currentUser', () {
      test('debe retornar el usuario cuando está autenticado', () async {
        // Arrange
        final user = User(username: 'testuser');
        when(() => mockAuthService.login(
          username: any(named: 'username'),
          password: any(named: 'password'),
        )).thenAnswer((_) async => user);

        final controller = container.read(authControllerProvider.notifier);

        await controller.login(
          username: 'testuser',
          password: 'Password123!',
          onSuccess: () {},
          onError: (_) {},
        );

        // Assert
        expect(controller.currentUser, isNotNull);
        expect(controller.currentUser!.username, equals('testuser'));
      });

      test('debe retornar null cuando no está autenticado', () {
        // Arrange
        final controller = container.read(authControllerProvider.notifier);

        // Assert
        expect(controller.currentUser, isNull);
      });
    });
  });
}
