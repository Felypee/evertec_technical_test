# SpaceX Launches App - Prueba Tecnica Evertec

Aplicacion Flutter que consume la API de SpaceX para mostrar informacion de lanzamientos espaciales, con funcionalidades avanzadas como autenticación local, modo offline, cambio de tema e internacionalización.

## Caracteristicas

### Funcionalidades Principales
- **Autenticacion local** con validacion de contrasena segura (8+ caracteres, mayuscula, numero, caracter especial)
- **Carrusel horizontal** de lanzamientos con PageView y elemento central destacado
- **Detalle de lanzamiento** con animacion Hero e informacion completa (cohete, launchpad, fecha, estado)
- **Modo offline** con cache SQLite usando Drift
- **Cambio de tema** persistente (claro/oscuro/sistema)
- **Internacionalizacion** ES/EN con easy_localization

### Funcionalidades Opcionales Implementadas
- **Modales**: Bottom sheet para filtros, dialogs para confirmaciones
- **Transiciones personalizadas**: Fade, slide, scale entre pantallas
- **Mejoras de UX**:
  - Haptic feedback en interacciones
  - Pull to refresh
  - Skeleton loading con Shimmer
  - Animaciones de entrada con flutter_animate
- **Filtros**: Por estado (Success/Failed/Upcoming) y por cohete
- **Enlaces externos**: Webcast, Wikipedia, articulos relacionados

## Stack Tecnologico

| Categoria | Tecnologia |
|-----------|------------|
| Estado | `flutter_riverpod` |
| Modelos | `freezed` + `json_serializable` |
| HTTP | `dio` con interceptores |
| Navegacion | `go_router` |
| DB Local | `drift` (SQLite) |
| Auth Storage | `flutter_secure_storage` |
| Conectividad | `connectivity_plus` |
| Animaciones | `flutter_animate` + `lottie` |
| Imagenes | `cached_network_image` |
| Loading | `shimmer` |
| i18n | `easy_localization` |
| Testing | `mocktail` |

## Estructura del Proyecto

```
lib/
├── config/
│   ├── routes/        # Configuracion de navegacion (go_router)
│   ├── themes/        # Temas, tokens de color y provider
│   └── constants/     # Constantes de API y storage keys
├── core/
│   ├── network/       # Cliente HTTP (Dio) e interceptores
│   ├── local_storage/ # Base de datos Drift y secure storage
│   ├── utils/         # Utilidades (validadores)
│   └── error/         # Excepciones tipadas
├── features/
│   ├── auth/          # Autenticacion (login, servicio, controller)
│   ├── home/          # Pantalla principal con carrusel de lanzamientos
│   ├── detail/        # Detalle de lanzamiento
│   └── profile/       # Perfil y configuracion (tema, idioma)
├── shared/
│   └── widgets/       # Widgets compartidos (shimmer, errores, banner)
├── l10n/              # Archivos de traduccion (ES/EN)
└── main.dart
```

## Requisitos

- Flutter 3.9.2 o superior
- Dart 3.0 o superior
- FVM (opcional, recomendado)

## Instalacion

1. Clonar el repositorio:
```bash
git clone <url-del-repositorio>
cd evertec_technical_test
```

2. Instalar dependencias:
```bash
flutter pub get
```

3. Generar codigo (Freezed, Drift, etc.):
```bash
dart run build_runner build --delete-conflicting-outputs
```

4. Ejecutar la aplicacion:
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

La aplicacion consume la [API de SpaceX](https://github.com/r-spacex/SpaceX-API) v5, una API REST gratuita con informacion sobre:

- **Lanzamientos** (`/launches`): Historial completo de misiones
- **Cohetes** (`/rockets`): Falcon 9, Falcon Heavy, Starship, etc.
- **Launchpads** (`/launchpads`): Plataformas de lanzamiento

## Arquitectura

La aplicacion sigue una arquitectura limpia con separacion de responsabilidades:

- **Service**: Logica de negocio y acceso a datos (API/cache)
- **Controller**: Manejo de estado con Riverpod
- **UI**: Widgets de Flutter

### Patron Offline-First

```dart
Future<List<LaunchModel>> getLaunches() async {
  try {
    if (await _networkInfo.isConnected) {
      final response = await _dio.get('/launches');
      final launches = _parseResponse(response);
      await _launchDao.insertLaunches(launches); // Guardar en cache
      return launches;
    } else {
      return await _getFromCache();
    }
  } on DioException catch (e) {
    final cached = await _getFromCache();
    if (cached.isNotEmpty) return cached;
    throw NetworkException(message: 'Error de conexion');
  }
}
```

## Decisiones Tecnicas

### Por que Riverpod en lugar de BLoC/Cubit?

| Aspecto | BLoC/Cubit | Riverpod |
|---------|------------|----------|
| Boilerplate | Alto (Events, States, BLoC) | Minimo (Provider + Notifier) |
| Compile-time safety | No | Si |
| Inyeccion de dependencias | Requiere get_it o similar | Integrada |
| Performance | Buena | Excelente (granular rebuilds) |

**Argumentacion:**
1. **Compile-time Safety**: Riverpod detecta errores en tiempo de compilacion, no en runtime, reduciendo bugs en produccion.
2. **Menor codigo**: Un `StateNotifier` reemplaza la triada Event + State + BLoC, reduciendo lineas de codigo en ~60%.
3. **DI integrada**: No requiere paquetes adicionales como `get_it` o `injectable`, simplificando el arbol de dependencias.
4. **Auto-dispose**: Los providers se limpian automaticamente cuando no se usan, evitando memory leaks.
5. **Evolucion de Provider**: Creado por Remi Rousselet (autor de Provider), representa la evolucion natural del patron.

### Por que Drift (SQLite) para persistencia?

**Alternativas evaluadas:**
- **Isar**: NoSQL muy rapido, pero en proceso de deprecacion (no es opcion viable a largo plazo)
- **Hive**: NoSQL simple, pero limitado en queries complejas y relaciones
- **SharedPreferences**: Solo key-value, insuficiente para datos estructurados

**Argumentacion:**
1. **Type-safety**: Las queries SQL se verifican en compilacion, evitando errores de sintaxis en runtime.
2. **Relaciones**: Soporte completo para relaciones entre tablas (launches ↔ rockets ↔ launchpads).
3. **Migraciones**: Sistema robusto de migraciones de schema, critico para actualizaciones de la app.
4. **Performance**: SQLite es extremadamente eficiente y probado en millones de apps.
5. **Queries complejas**: Filtros, ordenamiento y busqueda full-text sin limitaciones.

### Por que GoRouter para navegacion?

1. **Declarativo**: Todas las rutas definidas en un solo archivo, facil de auditar y mantener.
2. **Guards integrados**: Redireccion de autenticacion sin codigo adicional.
3. **Deep linking**: Soporte nativo para URLs, preparado para web y universal links.
4. **Mantenido por Flutter**: Garantia de compatibilidad y actualizaciones.

### Estrategia Offline-First

```
Con conexion:    API → Guardar en cache → Mostrar datos
Sin conexion:    Cache → Mostrar + Banner offline
Sin conexion + Sin cache: Error + Boton reintentar
```

Esta estrategia garantiza que la app sea funcional incluso sin conectividad, priorizando la experiencia del usuario sobre la frescura de los datos.

### Resumen de Stack

| Categoria | Paquete | Justificacion |
|-----------|---------|---------------|
| Estado | flutter_riverpod | Type-safe, menos boilerplate, DI integrada |
| DB Local | drift | SQL type-safe, migraciones, relaciones |
| HTTP | dio | Interceptors, cancelacion, retry |
| Navegacion | go_router | Declarativo, guards, deep linking |
| Conectividad | connectivity_plus | Multiplataforma, stream reactivo |
| Storage seguro | flutter_secure_storage | Encriptacion nativa por plataforma |

> Para documentacion detallada ver [docs/TECHNICAL_DECISIONS.md](docs/TECHNICAL_DECISIONS.md)

## Capturas de Pantalla

### Login
- Validacion de contrasena en tiempo real
- Requisitos visuales de seguridad

### Home
- Carrusel horizontal de lanzamientos
- Indicador de conectividad
- Filtros por estado y cohete
- Pull to refresh

### Detalle
- Animacion Hero desde el carrusel
- Informacion completa: cohete, launchpad, fecha, estado
- Enlaces a webcast, Wikipedia y articulos
- Galeria de imagenes de Flickr

### Perfil
- Selector de tema (claro/oscuro/sistema)
- Selector de idioma (ES/EN)
- Logout con confirmacion

## Licencia

Este proyecto es parte de una prueba técnica y su uso esta limitado a fines de evaluación.
