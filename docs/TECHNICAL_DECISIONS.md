# Decisiones Técnicas

Este documento describe las decisiones técnicas tomadas durante el desarrollo de la aplicación SpaceX Launches y la justificación de cada una.

## Índice

1. [Arquitectura](#arquitectura)
2. [Gestión de Estado](#gestión-de-estado)
3. [Persistencia Local](#persistencia-local)
4. [Navegación](#navegación)
5. [Inyección de Dependencias](#inyección-de-dependencias)
6. [Conectividad](#conectividad)
7. [API Consumida](#api-consumida)

---

## Arquitectura

### Decisión: Feature-First Architecture con Clean Architecture Principles

**Estructura adoptada:**
```
lib/
├── config/         # Configuración global (rutas, temas, constantes)
├── core/           # Funcionalidades compartidas (network, storage, utils)
├── features/       # Módulos de funcionalidad (auth, home, detail, profile)
│   └── feature/
│       ├── controller/   # Lógica de estado
│       ├── service/      # Lógica de negocio y acceso a datos
│       ├── models/       # Modelos de datos
│       └── ui/           # Widgets y pantallas
└── shared/         # Widgets reutilizables
```

**Justificación:**
- **Escalabilidad**: Cada feature es independiente y autocontenida
- **Mantenibilidad**: Cambios en una feature no afectan a otras
- **Testabilidad**: Separación clara permite tests unitarios aislados
- **Colaboración**: Múltiples desarrolladores pueden trabajar en features diferentes

---

## Gestión de Estado

### Decisión: Riverpod en lugar de BLoC/Cubit

**Justificación técnica:**

| Aspecto | BLoC/Cubit | Riverpod |
|---------|------------|----------|
| Boilerplate | Alto (Events, States, BLoC) | Mínimo (Provider + Notifier) |
| Curva de aprendizaje | Moderada-Alta | Moderada |
| Compile-time safety | No | Sí |
| Inyección de dependencias | Requiere get_it o similar | Integrada |
| Testabilidad | Buena | Excelente |
| Performance | Buena | Excelente (granular rebuilds) |

**Razones específicas:**

1. **Compile-time Safety**: Riverpod detecta errores en tiempo de compilación, no en runtime.

2. **Integración con Inyección de Dependencias**: No requiere paquetes adicionales como `get_it` o `injectable`.

3. **Menor Boilerplate**: Un `StateNotifier` reemplaza Event + State + BLoC:

   ```dart
   // Con Riverpod (actual)
   class AuthController extends StateNotifier<AuthState> {
     Future<void> login(...) async {
       state = Authenticated(user);
     }
   }

   // Con BLoC (alternativa)
   // Requiere: AuthEvent, AuthState, AuthBloc + mapEventToState
   ```

4. **Auto-dispose**: Los providers se limpian automáticamente cuando no se usan.

5. **Acceso sin BuildContext**: Se puede acceder al estado desde cualquier lugar usando `ref`.

6. **Recomendación oficial**: Riverpod es creado por Remi Rousselet (autor de Provider) y es considerado la evolución de Provider.

**Trade-offs considerados:**
- BLoC tiene más adopción en el mercado empresarial
- BLoC tiene mejor tooling (bloc_test, extensiones VS Code)
- Riverpod tiene documentación menos extensa que BLoC

**Conclusión**: Para este proyecto, Riverpod ofrece mejor developer experience, menos código y las mismas garantías de arquitectura que BLoC, con el beneficio adicional de type-safety en compilación.

---

## Persistencia Local

### Decisión: Drift (SQLite)

**Alternativas evaluadas:**
- **Isar**: NoSQL, muy rápido, pero en proceso de deprecación
- **Hive**: NoSQL, simple, pero limitado en queries complejas
- **SharedPreferences**: Solo key-value, insuficiente para datos estructurados
- **Drift**: SQL type-safe con generación de código

**Justificación:**
1. **Type-safety**: Queries verificadas en compilación
2. **Relaciones**: Soporte completo para relaciones entre tablas
3. **Migrations**: Sistema robusto de migraciones de schema
4. **Performance**: SQLite es extremadamente eficiente
5. **Queries complejas**: Filtros, ordenamiento y búsqueda full-text

---

## Navegación

### Decisión: GoRouter

**Justificación:**
1. **Declarativa**: Rutas definidas en un solo lugar
2. **Deep linking**: Soporte nativo para URLs
3. **Redirección**: Guards de autenticación integrados
4. **Type-safe**: Parámetros tipados
5. **Oficial**: Mantenido por el equipo de Flutter

**Implementación:**
```dart
redirect: (context, state) {
  final isAuthenticated = authNotifier.isAuthenticated;
  if (!isAuthenticated && !isLoginRoute) return Routes.login;
  return null;
}
```

---

## Inyección de Dependencias

### Decisión: Riverpod Providers (sin get_it)

**Justificación:**
- Riverpod ya proporciona DI como característica core
- Evita dependencias adicionales
- Providers son lazy por defecto
- Auto-dispose maneja el ciclo de vida

**Ejemplo:**
```dart
final launchServiceProvider = Provider<LaunchService>((ref) {
  final dio = ref.watch(dioClientProvider);
  final networkInfo = ref.watch(networkInfoProvider);
  final launchDao = ref.watch(launchDaoProvider);
  return LaunchService(dio, networkInfo, launchDao);
});
```

---

## Conectividad

### Decisión: connectivity_plus + Estrategia Offline-First

**Implementación:**
1. **Detección de red**: Stream reactivo de cambios de conectividad
2. **Caché local**: Datos guardados en SQLite
3. **Fallback automático**: API → Caché → Error
4. **UI feedback**: Banner visual cuando está offline

**Flujo:**
```
Con conexión: API → Guardar en caché → Mostrar
Sin conexión: Caché → Mostrar + Banner offline
Sin conexión + Sin caché: Error + Botón reintentar
```

---

## API Consumida

### Decisión: SpaceX API (api.spacexdata.com)

**Requisitos cumplidos:**
- ✅ Listado de elementos (launches)
- ✅ Detalle por elemento (launch/{id})
- ✅ Recursos visuales (patches, thumbnails YouTube, Flickr)

**Beneficios adicionales:**
- API pública sin autenticación
- Datos reales y actualizados
- Múltiples endpoints relacionados (rockets, launchpads)
- Buena documentación

---

## Resumen de Dependencias Principales

| Categoría | Paquete | Versión | Justificación |
|-----------|---------|---------|---------------|
| Estado | flutter_riverpod | ^2.6.1 | Type-safe, menos boilerplate |
| DB Local | drift | ^2.25.0 | SQL type-safe, migraciones |
| HTTP | dio | ^5.8.0 | Interceptors, cancelación |
| Navegación | go_router | ^14.8.1 | Declarativo, guards |
| Conectividad | connectivity_plus | ^6.1.4 | Multiplataforma |
| Storage seguro | flutter_secure_storage | ^9.2.4 | Encriptación nativa |

---

*Documento actualizado: Marzo 2025*
