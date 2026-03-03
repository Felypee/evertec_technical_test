import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:evertec_technical_test/core/network/network_info.dart';
import 'package:evertec_technical_test/core/local_storage/database/daos/launch_dao.dart';
import 'package:evertec_technical_test/features/home/service/launch_service.dart';
import 'package:evertec_technical_test/features/home/models/launch.dart';

class MockDio extends Mock implements Dio {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

class MockLaunchDao extends Mock implements LaunchDao {}

void main() {
  late LaunchService launchService;
  late MockDio mockDio;
  late MockNetworkInfo mockNetworkInfo;
  late MockLaunchDao mockLaunchDao;

  setUp(() {
    mockDio = MockDio();
    mockNetworkInfo = MockNetworkInfo();
    mockLaunchDao = MockLaunchDao();
    launchService = LaunchService(mockDio, mockNetworkInfo, mockLaunchDao);
  });

  group('LaunchService', () {
    group('getAllLaunches', () {
      final mockLaunchesJson = [
        {
          'id': '1',
          'name': 'Falcon 9 Test',
          'success': true,
          'flight_number': 1,
          'details': 'Test launch',
          'date_utc': '2024-01-01T00:00:00.000Z',
          'rocket': 'rocket1',
          'launchpad': 'pad1',
          'links': {
            'patch': {'small': null, 'large': null},
            'webcast': null,
            'wikipedia': null,
            'article': null,
            'flickr': {'original': []},
          },
        },
      ];

      test('debe retornar lanzamientos de la API cuando hay conexión', () async {
        // Arrange
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(() => mockDio.get(any())).thenAnswer(
          (_) async => Response(
            data: mockLaunchesJson,
            statusCode: 200,
            requestOptions: RequestOptions(path: ''),
          ),
        );
        when(() => mockLaunchDao.insertLaunches(any())).thenAnswer((_) async {});

        // Act
        final result = await launchService.getAllLaunches();

        // Assert
        expect(result, isA<List<LaunchModel>>());
        expect(result.length, equals(1));
        expect(result.first.name, equals('Falcon 9 Test'));
        verify(() => mockNetworkInfo.isConnected).called(1);
      });

      test('debe retornar lista vacía de caché cuando no hay conexión', () async {
        // Arrange
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
        when(() => mockLaunchDao.getAllLaunches()).thenAnswer((_) async => []);

        // Act
        final result = await launchService.getAllLaunches();

        // Assert
        expect(result, isA<List<LaunchModel>>());
        expect(result, isEmpty);
        verify(() => mockLaunchDao.getAllLaunches()).called(1);
      });
    });

    group('searchLaunches', () {
      test('debe buscar en caché cuando no hay conexión', () async {
        // Arrange
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
        when(() => mockLaunchDao.searchByName('falcon')).thenAnswer((_) async => []);

        // Act
        final result = await launchService.searchLaunches('falcon');

        // Assert
        expect(result, isA<List<LaunchModel>>());
        verify(() => mockLaunchDao.searchByName('falcon')).called(1);
      });
    });

    group('filterByStatus', () {
      test('debe filtrar por estado en caché cuando no hay conexión', () async {
        // Arrange
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
        when(() => mockLaunchDao.filterBySuccess('success')).thenAnswer((_) async => []);

        // Act
        final result = await launchService.filterByStatus('success');

        // Assert
        expect(result, isA<List<LaunchModel>>());
        verify(() => mockLaunchDao.filterBySuccess('success')).called(1);
      });
    });

    group('hasCache', () {
      test('debe retornar true cuando hay datos en caché', () async {
        // Arrange
        when(() => mockLaunchDao.hasCache()).thenAnswer((_) async => true);

        // Act
        final result = await launchService.hasCache();

        // Assert
        expect(result, isTrue);
        verify(() => mockLaunchDao.hasCache()).called(1);
      });

      test('debe retornar false cuando no hay datos en caché', () async {
        // Arrange
        when(() => mockLaunchDao.hasCache()).thenAnswer((_) async => false);

        // Act
        final result = await launchService.hasCache();

        // Assert
        expect(result, isFalse);
        verify(() => mockLaunchDao.hasCache()).called(1);
      });
    });

    group('getUniqueRockets', () {
      test('debe retornar cohetes únicos del caché', () async {
        // Arrange
        when(() => mockLaunchDao.getUniqueRockets())
            .thenAnswer((_) async => ['Falcon 9', 'Falcon Heavy']);

        // Act
        final result = await launchService.getUniqueRockets();

        // Assert
        expect(result, contains('Falcon 9'));
        expect(result, contains('Falcon Heavy'));
      });

      test('debe retornar valores por defecto cuando no hay datos', () async {
        // Arrange
        when(() => mockLaunchDao.getUniqueRockets()).thenAnswer((_) async => []);

        // Act
        final result = await launchService.getUniqueRockets();

        // Assert
        expect(result, isNotEmpty);
        expect(result, contains('Falcon 9'));
      });
    });
  });
}
