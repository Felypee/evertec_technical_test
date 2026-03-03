// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'launch.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LaunchModel _$LaunchModelFromJson(Map<String, dynamic> json) => _LaunchModel(
  id: json['id'] as String,
  name: json['name'] as String,
  success: json['success'] as bool?,
  flightNumber: (json['flight_number'] as num).toInt(),
  details: json['details'] as String?,
  dateUtc: json['date_utc'] as String,
  links: LaunchLinks.fromJson(json['links'] as Map<String, dynamic>),
  rocket: json['rocket'] as String?,
  launchpad: json['launchpad'] as String?,
  rocketName: json['rocketName'] as String?,
  launchpadName: json['launchpadName'] as String?,
);

Map<String, dynamic> _$LaunchModelToJson(_LaunchModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'success': instance.success,
      'flight_number': instance.flightNumber,
      'details': instance.details,
      'date_utc': instance.dateUtc,
      'links': instance.links.toJson(),
      'rocket': instance.rocket,
      'launchpad': instance.launchpad,
      'rocketName': instance.rocketName,
      'launchpadName': instance.launchpadName,
    };

_LaunchLinks _$LaunchLinksFromJson(Map<String, dynamic> json) => _LaunchLinks(
  patch: json['patch'] == null
      ? null
      : LaunchPatch.fromJson(json['patch'] as Map<String, dynamic>),
  flickr: json['flickr'] == null
      ? null
      : LaunchFlickr.fromJson(json['flickr'] as Map<String, dynamic>),
  webcast: json['webcast'] as String?,
  wikipedia: json['wikipedia'] as String?,
  article: json['article'] as String?,
);

Map<String, dynamic> _$LaunchLinksToJson(_LaunchLinks instance) =>
    <String, dynamic>{
      'patch': instance.patch,
      'flickr': instance.flickr,
      'webcast': instance.webcast,
      'wikipedia': instance.wikipedia,
      'article': instance.article,
    };

_LaunchPatch _$LaunchPatchFromJson(Map<String, dynamic> json) => _LaunchPatch(
  small: json['small'] as String?,
  large: json['large'] as String?,
);

Map<String, dynamic> _$LaunchPatchToJson(_LaunchPatch instance) =>
    <String, dynamic>{'small': instance.small, 'large': instance.large};

_LaunchFlickr _$LaunchFlickrFromJson(Map<String, dynamic> json) =>
    _LaunchFlickr(
      small:
          (json['small'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          const [],
      original:
          (json['original'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$LaunchFlickrToJson(_LaunchFlickr instance) =>
    <String, dynamic>{'small': instance.small, 'original': instance.original};
