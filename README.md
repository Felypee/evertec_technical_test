# SpaceX Launches App - Prueba Técnica Evertec

## Demo

<p align="center">
  <img src="docs/demo_1.gif" width="250" alt="Splash y Login" />
  <img src="docs/demo_2.gif" width="250" alt="Home y Carrusel" />
  <img src="docs/demo_3.gif" width="250" alt="Detalle y Perfil" />
</p>

Aplicación Flutter que consume la API de SpaceX para mostrar información de lanzamientos espaciales, con funcionalidades avanzadas como autenticación local, modo offline, cambio de tema e internacionalización.

## Características

### Funcionalidades Principales
- **Autenticación local** con validación de contraseña segura (8+ caracteres, mayúscula, número, carácter especial)
- **Carrusel horizontal** de lanzamientos con PageView y elemento central destacado
- **Detalle de lanzamiento** con animación Hero e información completa (cohete, launchpad, fecha, estado)
- **Modo offline** con caché SQLite usando Drift
- **Cambio de tema** persistente (claro/oscuro/sistema)
- **Internacionalización** ES/EN con easy_localization

### Funcionalidades Opcionales Implementadas
- **Modales**: Bottom sheet para filtros, dialogs para confirmaciones
- **Transiciones personalizadas**: Fade, slide, scale entre pantallas
- **Mejoras de UX**:
  - Haptic feedback en interacciones
  - Pull to refresh
  - Skeleton loading con Shimmer
  - Animaciones de entrada con flutter_animate
- **Filtros**: Por estado (Success/Failed/Upcoming) y por cohete
- **Enlaces externos**: Webcast, Wikipedia, artículos relacionados

## Stack Tecnológico

| Categoría | Tecnología |
|-----------|------------|
| Estado | `flutter_riverpod` |
| Modelos | `freezed` + `json_serializable` |
| HTTP | `dio` con interceptores |
| Navegación | `go_router` |
| DB Local | `drift` (SQLite) |
| Auth Storage | `flutter_secure_storage` |
| Conectividad | `connectivity_plus` |
| Animaciones | `flutter_animate` + `lottie` |
| Imágenes | `cached_network_image` |
| Loading | `shimmer` |
| i18n | `easy_localization` |
| Testing | `mocktail` |

## Estructura del Proyecto

```
lib/
├── config/
│   ├── routes/        # Configuración de navegación (go_router)
│   ├── themes/        # Temas, tokens de color y provider
│   └── constants/     # Constantes de API y storage keys
├── core/
│   ├── network/       # Cliente HTTP (Dio) e interceptores
│   ├── local_storage/ # Base de datos Drift y secure storage
│   ├── utils/         # Utilidades (validadores)
│   └── error/         # Excepciones tipadas
├── features/
│   ├── auth/          # Autenticación (login, servicio, controller)
│   ├── home/          # Pantalla principal con carrusel de lanzamientos
│   ├── detail/        # Detalle de lanzamiento
│   └── profile/       # Perfil y configuración (tema, idioma)
├── shared/
│   └── widgets/       # Widgets compartidos (shimmer, errores, banner)
├── l10n/              # Archivos de traducción (ES/EN)
└── main.dart
```

## Requisitos

- Flutter 3.9.2 o superior
- Dart 3.0 o superior
- FVM (opcional, recomendado)

## Instalación

1. Clonar el repositorio:
```bash
git clone <url-del-repositorio>
cd evertec_technical_test
```

2. Instalar dependencias:
```bash
flutter pub get
```

3. Generar código (Freezed, Drift, etc.):
```bash
dart run build_runner build --delete-conflicting-outputs
```

4. Ejecutar la aplicación:
```bash
flutter run
```

### Con FVM (recomendado)
```bash
fvm use 3.9.2
fvm flutter pub get
fvm flutter run
```

## Pruebas

Ejecutar todas las pruebas:
```bash
flutter test
```

Ejecutar pruebas con cobertura:
```bash
flutter test --coverage
```

## API

La aplicación consume la [API de SpaceX](https://github.com/r-spacex/SpaceX-API) v5, una API REST gratuita con información sobre:

- **Lanzamientos** (`/launches`): Historial completo de misiones
- **Cohetes** (`/rockets`): Falcon 9, Falcon Heavy, Starship, etc.
- **Launchpads** (`/launchpads`): Plataformas de lanzamiento

## Arquitectura

La aplicación sigue una arquitectura limpia con separación de responsabilidades:

- **Service**: Lógica de negocio y acceso a datos (API/caché)
- **Controller**: Manejo de estado con Riverpod
- **UI**: Widgets de Flutter

### Patrón Offline-First

```dart
Future<List<LaunchModel>> getLaunches() async {
  try {
    if (await _networkInfo.isConnected) {
      final response = await _dio.get('/launches');
      final launches = _parseResponse(response);
      await _launchDao.insertLaunches(launches); // Guardar en caché
      return launches;
    } else {
      return await _getFromCache();
    }
  } on DioException catch (e) {
    final cached = await _getFromCache();
    if (cached.isNotEmpty) return cached;
    throw NetworkException(message: 'Error de conexión');
  }
}
```

## Decisiones Técnicas

### ¿Por qué Riverpod en lugar de BLoC/Cubit?

| Aspecto | BLoC/Cubit | Riverpod |
|---------|------------|----------|
| Boilerplate | Alto (Events, States, BLoC) | Mínimo (Provider + Notifier) |
| Compile-time safety | No | Sí |
| Inyección de dependencias | Requiere get_it o similar | Integrada |
| Performance | Buena | Excelente (granular rebuilds) |

**Argumentación:**
1. **Compile-time Safety**: Riverpod detecta errores en tiempo de compilación, no en runtime, reduciendo bugs en producción.
2. **Menor código**: Un `StateNotifier` reemplaza la triada Event + State + BLoC, reduciendo líneas de código en ~60%.
3. **DI integrada**: No requiere paquetes adicionales como `get_it` o `injectable`, simplificando el árbol de dependencias.
4. **Auto-dispose**: Los providers se limpian automáticamente cuando no se usan, evitando memory leaks.
5. **Evolución de Provider**: Creado por Remi Rousselet (autor de Provider), representa la evolución natural del patrón.

### ¿Por qué Drift (SQLite) para persistencia?

**Alternativas evaluadas:**
- **Isar**: NoSQL muy rápido, pero en proceso de deprecación (no es opción viable a largo plazo)
- **Hive**: NoSQL simple, pero limitado en queries complejas y relaciones
- **SharedPreferences**: Solo key-value, insuficiente para datos estructurados

**Argumentación:**
1. **Type-safety**: Las queries SQL se verifican en compilación, evitando errores de sintaxis en runtime.
2. **Relaciones**: Soporte completo para relaciones entre tablas (launches ↔ rockets ↔ launchpads).
3. **Migraciones**: Sistema robusto de migraciones de schema, crítico para actualizaciones de la app.
4. **Performance**: SQLite es extremadamente eficiente y probado en millones de apps.
5. **Queries complejas**: Filtros, ordenamiento y búsqueda full-text sin limitaciones.

### ¿Por qué GoRouter para navegación?

1. **Declarativo**: Todas las rutas definidas en un solo archivo, fácil de auditar y mantener.
2. **Guards integrados**: Redirección de autenticación sin código adicional.
3. **Deep linking**: Soporte nativo para URLs, preparado para web y universal links.
4. **Mantenido por Flutter**: Garantía de compatibilidad y actualizaciones.

### Estrategia Offline-First

```
Con conexión:    API → Guardar en caché → Mostrar datos
Sin conexión:    Caché → Mostrar + Banner offline
Sin conexión + Sin caché: Error + Botón reintentar
```

Esta estrategia garantiza que la app sea funcional incluso sin conectividad, priorizando la experiencia del usuario sobre la frescura de los datos.

### Resumen de Stack

| Categoría | Paquete | Justificación |
|-----------|---------|---------------|
| Estado | flutter_riverpod | Type-safe, menos boilerplate, DI integrada |
| DB Local | drift | SQL type-safe, migraciones, relaciones |
| HTTP | dio | Interceptors, cancelación, retry |
| Navegación | go_router | Declarativo, guards, deep linking |
| Conectividad | connectivity_plus | Multiplataforma, stream reactivo |
| Storage seguro | flutter_secure_storage | Encriptación nativa por plataforma |

> Para documentación detallada ver [docs/TECHNICAL_DECISIONS.md](docs/TECHNICAL_DECISIONS.md)

## Capturas de Pantalla

### Login
- Validación de contraseña en tiempo real
- Requisitos visuales de seguridad

### Home
- Carrusel horizontal de lanzamientos
- Indicador de conectividad
- Filtros por estado y cohete
- Pull to refresh

### Detalle
- Animación Hero desde el carrusel
- Información completa: cohete, launchpad, fecha, estado
- Enlaces a webcast, Wikipedia y artículos
- Galería de imágenes de Flickr

### Perfil
- Selector de tema (claro/oscuro/sistema)
- Selector de idioma (ES/EN)
- Logout con confirmación

## Licencia

Este proyecto es parte de una prueba técnica y su uso está limitado a fines de evaluación.
