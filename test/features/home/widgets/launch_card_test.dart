import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:evertec_technical_test/features/home/ui/widgets/video_launch_card.dart';
import 'package:evertec_technical_test/features/home/models/launch.dart';

void main() {
  Widget createTestWidget(Widget child) {
    return ProviderScope(
      child: MaterialApp(
        home: Scaffold(
          body: SizedBox(
            width: 350,
            height: 600,
            child: child,
          ),
        ),
      ),
    );
  }

  LaunchModel createMockLaunch({
    String id = '1',
    String name = 'Falcon 9 Test',
    bool? success = true,
    int flightNumber = 1,
    String? details,
    String? webcast,
    String? patchSmall,
  }) {
    return LaunchModel(
      id: id,
      name: name,
      success: success,
      flightNumber: flightNumber,
      details: details,
      dateUtc: '2024-01-01T00:00:00.000Z',
      rocket: 'rocket1',
      launchpad: 'pad1',
      links: LaunchLinks(
        patch: LaunchPatch(small: patchSmall, large: null),
        webcast: webcast,
        wikipedia: null,
        article: null,
        flickr: const LaunchFlickr(original: []),
      ),
    );
  }

  group('VideoLaunchCard', () {
    testWidgets('debe mostrar el nombre del lanzamiento', (tester) async {
      // Arrange
      final launch = createMockLaunch(name: 'Starlink Mission');

      // Act
      await tester.pumpWidget(
        createTestWidget(
          VideoLaunchCard(
            launch: launch,
            onTap: () {},
          ),
        ),
      );

      // Assert
      expect(find.text('Starlink Mission'), findsOneWidget);
    });

    testWidgets('debe mostrar el número de vuelo', (tester) async {
      // Arrange
      final launch = createMockLaunch(flightNumber: 42);

      // Act
      await tester.pumpWidget(
        createTestWidget(
          VideoLaunchCard(
            launch: launch,
            onTap: () {},
          ),
        ),
      );

      // Assert
      expect(find.text('#42'), findsOneWidget);
    });

    testWidgets('debe ejecutar onTap cuando se toca la tarjeta', (tester) async {
      // Arrange
      var tapCount = 0;
      final launch = createMockLaunch();

      // Act
      await tester.pumpWidget(
        createTestWidget(
          VideoLaunchCard(
            launch: launch,
            onTap: () => tapCount++,
          ),
        ),
      );

      await tester.tap(find.byType(VideoLaunchCard));
      await tester.pump();

      // Assert
      expect(tapCount, equals(1));
    });

    testWidgets('debe mostrar icono de calendario para la fecha', (tester) async {
      // Arrange
      final launch = createMockLaunch();

      // Act
      await tester.pumpWidget(
        createTestWidget(
          VideoLaunchCard(
            launch: launch,
            onTap: () {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Assert
      expect(find.byIcon(Icons.calendar_today_outlined), findsOneWidget);
    });

    testWidgets('debe aplicar parallax offset sin errores', (tester) async {
      // Arrange
      final launch = createMockLaunch();

      // Act
      await tester.pumpWidget(
        createTestWidget(
          VideoLaunchCard(
            launch: launch,
            onTap: () {},
            parallaxOffset: 20.0,
          ),
        ),
      );

      // Assert
      expect(find.byType(VideoLaunchCard), findsOneWidget);
    });

    testWidgets('debe mostrar placeholder cuando no hay imagen', (tester) async {
      // Arrange
      final launch = createMockLaunch(patchSmall: null, webcast: null);

      // Act
      await tester.pumpWidget(
        createTestWidget(
          VideoLaunchCard(
            launch: launch,
            onTap: () {},
          ),
        ),
      );

      // Assert
      expect(find.byIcon(Icons.rocket_launch_outlined), findsOneWidget);
    });

    testWidgets('debe mostrar nombre del cohete si está disponible', (tester) async {
      // Arrange
      final launch = LaunchModel(
        id: '1',
        name: 'Test Launch',
        success: true,
        flightNumber: 1,
        dateUtc: '2024-01-01T00:00:00.000Z',
        rocket: 'rocket1',
        launchpad: 'pad1',
        rocketName: 'Falcon 9',
        links: const LaunchLinks(
          patch: LaunchPatch(small: null, large: null),
          flickr: LaunchFlickr(original: []),
        ),
      );

      // Act
      await tester.pumpWidget(
        createTestWidget(
          VideoLaunchCard(
            launch: launch,
            onTap: () {},
          ),
        ),
      );

      // Assert
      expect(find.text('Falcon 9'), findsOneWidget);
    });
  });
}
