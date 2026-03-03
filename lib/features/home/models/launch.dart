// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'launch.freezed.dart';
part 'launch.g.dart';

/// Modelo de lanzamiento de SpaceX
@Freezed(toJson: true, fromJson: true)
abstract class LaunchModel with _$LaunchModel {
  @JsonSerializable(explicitToJson: true)
  const factory LaunchModel({
    required String id,
    required String name,
    @JsonKey(name: 'success') bool? success,
    @JsonKey(name: 'flight_number') required int flightNumber,
    String? details,
    @JsonKey(name: 'date_utc') required String dateUtc,
    required LaunchLinks links,
    String? rocket,
    String? launchpad,
    // Campos poblados después de resolver IDs
    String? rocketName,
    String? launchpadName,
  }) = _LaunchModel;

  factory LaunchModel.fromJson(Map<String, dynamic> json) =>
      _$LaunchModelFromJson(json);
}

/// Enlaces de un lanzamiento
@freezed
abstract class LaunchLinks with _$LaunchLinks {
  const factory LaunchLinks({
    LaunchPatch? patch,
    LaunchFlickr? flickr,
    String? webcast,
    String? wikipedia,
    String? article,
  }) = _LaunchLinks;

  factory LaunchLinks.fromJson(Map<String, dynamic> json) =>
      _$LaunchLinksFromJson(json);
}

/// Parches de misión
@freezed
abstract class LaunchPatch with _$LaunchPatch {
  const factory LaunchPatch({
    String? small,
    String? large,
  }) = _LaunchPatch;

  factory LaunchPatch.fromJson(Map<String, dynamic> json) =>
      _$LaunchPatchFromJson(json);
}

/// Imágenes de Flickr
@freezed
abstract class LaunchFlickr with _$LaunchFlickr {
  const factory LaunchFlickr({
    @Default([]) List<String> small,
    @Default([]) List<String> original,
  }) = _LaunchFlickr;

  factory LaunchFlickr.fromJson(Map<String, dynamic> json) =>
      _$LaunchFlickrFromJson(json);
}

/// Extensión para obtener el estado del lanzamiento
extension LaunchModelExtension on LaunchModel {
  /// Obtiene el estado del lanzamiento como string
  String get status {
    if (success == null) return 'Upcoming';
    return success! ? 'Success' : 'Failed';
  }

  /// Obtiene la URL de la imagen del parche (pequeño)
  String? get patchSmall => links.patch?.small;

  /// Obtiene la URL de la imagen del parche (grande)
  String? get patchLarge => links.patch?.large;

  /// Obtiene las imágenes de Flickr
  List<String> get flickrImages => links.flickr?.original ?? [];

  /// Verifica si tiene webcast (video) disponible
  bool get hasWebcast => links.webcast != null && links.webcast!.isNotEmpty;

  /// Verifica si tiene Wikipedia disponible
  bool get hasWikipedia => links.wikipedia != null && links.wikipedia!.isNotEmpty;

  /// Verifica si tiene artículo disponible
  bool get hasArticle => links.article != null && links.article!.isNotEmpty;

  /// Verifica si tiene algún enlace disponible
  bool get hasLinks => hasWebcast || hasWikipedia || hasArticle;

  /// Cuenta la cantidad de enlaces disponibles (para ordenamiento)
  int get linkCount {
    int count = 0;
    if (hasWebcast) count += 2; // Prioridad mayor para videos
    if (hasWikipedia) count++;
    if (hasArticle) count++;
    return count;
  }

  /// Formatea la fecha del lanzamiento
  String get formattedDate {
    try {
      final date = DateTime.parse(dateUtc);
      return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
    } catch (_) {
      return dateUtc;
    }
  }
}
