// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'launch.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LaunchModel {

 String get id; String get name;@JsonKey(name: 'success') bool? get success;@JsonKey(name: 'flight_number') int get flightNumber; String? get details;@JsonKey(name: 'date_utc') String get dateUtc; LaunchLinks get links; String? get rocket; String? get launchpad;// Campos poblados después de resolver IDs
 String? get rocketName; String? get launchpadName;
/// Create a copy of LaunchModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LaunchModelCopyWith<LaunchModel> get copyWith => _$LaunchModelCopyWithImpl<LaunchModel>(this as LaunchModel, _$identity);

  /// Serializes this LaunchModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LaunchModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.success, success) || other.success == success)&&(identical(other.flightNumber, flightNumber) || other.flightNumber == flightNumber)&&(identical(other.details, details) || other.details == details)&&(identical(other.dateUtc, dateUtc) || other.dateUtc == dateUtc)&&(identical(other.links, links) || other.links == links)&&(identical(other.rocket, rocket) || other.rocket == rocket)&&(identical(other.launchpad, launchpad) || other.launchpad == launchpad)&&(identical(other.rocketName, rocketName) || other.rocketName == rocketName)&&(identical(other.launchpadName, launchpadName) || other.launchpadName == launchpadName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,success,flightNumber,details,dateUtc,links,rocket,launchpad,rocketName,launchpadName);

@override
String toString() {
  return 'LaunchModel(id: $id, name: $name, success: $success, flightNumber: $flightNumber, details: $details, dateUtc: $dateUtc, links: $links, rocket: $rocket, launchpad: $launchpad, rocketName: $rocketName, launchpadName: $launchpadName)';
}


}

/// @nodoc
abstract mixin class $LaunchModelCopyWith<$Res>  {
  factory $LaunchModelCopyWith(LaunchModel value, $Res Function(LaunchModel) _then) = _$LaunchModelCopyWithImpl;
@useResult
$Res call({
 String id, String name,@JsonKey(name: 'success') bool? success,@JsonKey(name: 'flight_number') int flightNumber, String? details,@JsonKey(name: 'date_utc') String dateUtc, LaunchLinks links, String? rocket, String? launchpad, String? rocketName, String? launchpadName
});


$LaunchLinksCopyWith<$Res> get links;

}
/// @nodoc
class _$LaunchModelCopyWithImpl<$Res>
    implements $LaunchModelCopyWith<$Res> {
  _$LaunchModelCopyWithImpl(this._self, this._then);

  final LaunchModel _self;
  final $Res Function(LaunchModel) _then;

/// Create a copy of LaunchModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? success = freezed,Object? flightNumber = null,Object? details = freezed,Object? dateUtc = null,Object? links = null,Object? rocket = freezed,Object? launchpad = freezed,Object? rocketName = freezed,Object? launchpadName = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,success: freezed == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool?,flightNumber: null == flightNumber ? _self.flightNumber : flightNumber // ignore: cast_nullable_to_non_nullable
as int,details: freezed == details ? _self.details : details // ignore: cast_nullable_to_non_nullable
as String?,dateUtc: null == dateUtc ? _self.dateUtc : dateUtc // ignore: cast_nullable_to_non_nullable
as String,links: null == links ? _self.links : links // ignore: cast_nullable_to_non_nullable
as LaunchLinks,rocket: freezed == rocket ? _self.rocket : rocket // ignore: cast_nullable_to_non_nullable
as String?,launchpad: freezed == launchpad ? _self.launchpad : launchpad // ignore: cast_nullable_to_non_nullable
as String?,rocketName: freezed == rocketName ? _self.rocketName : rocketName // ignore: cast_nullable_to_non_nullable
as String?,launchpadName: freezed == launchpadName ? _self.launchpadName : launchpadName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of LaunchModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LaunchLinksCopyWith<$Res> get links {
  
  return $LaunchLinksCopyWith<$Res>(_self.links, (value) {
    return _then(_self.copyWith(links: value));
  });
}
}


/// Adds pattern-matching-related methods to [LaunchModel].
extension LaunchModelPatterns on LaunchModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LaunchModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LaunchModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LaunchModel value)  $default,){
final _that = this;
switch (_that) {
case _LaunchModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LaunchModel value)?  $default,){
final _that = this;
switch (_that) {
case _LaunchModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name, @JsonKey(name: 'success')  bool? success, @JsonKey(name: 'flight_number')  int flightNumber,  String? details, @JsonKey(name: 'date_utc')  String dateUtc,  LaunchLinks links,  String? rocket,  String? launchpad,  String? rocketName,  String? launchpadName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LaunchModel() when $default != null:
return $default(_that.id,_that.name,_that.success,_that.flightNumber,_that.details,_that.dateUtc,_that.links,_that.rocket,_that.launchpad,_that.rocketName,_that.launchpadName);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name, @JsonKey(name: 'success')  bool? success, @JsonKey(name: 'flight_number')  int flightNumber,  String? details, @JsonKey(name: 'date_utc')  String dateUtc,  LaunchLinks links,  String? rocket,  String? launchpad,  String? rocketName,  String? launchpadName)  $default,) {final _that = this;
switch (_that) {
case _LaunchModel():
return $default(_that.id,_that.name,_that.success,_that.flightNumber,_that.details,_that.dateUtc,_that.links,_that.rocket,_that.launchpad,_that.rocketName,_that.launchpadName);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name, @JsonKey(name: 'success')  bool? success, @JsonKey(name: 'flight_number')  int flightNumber,  String? details, @JsonKey(name: 'date_utc')  String dateUtc,  LaunchLinks links,  String? rocket,  String? launchpad,  String? rocketName,  String? launchpadName)?  $default,) {final _that = this;
switch (_that) {
case _LaunchModel() when $default != null:
return $default(_that.id,_that.name,_that.success,_that.flightNumber,_that.details,_that.dateUtc,_that.links,_that.rocket,_that.launchpad,_that.rocketName,_that.launchpadName);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _LaunchModel implements LaunchModel {
  const _LaunchModel({required this.id, required this.name, @JsonKey(name: 'success') this.success, @JsonKey(name: 'flight_number') required this.flightNumber, this.details, @JsonKey(name: 'date_utc') required this.dateUtc, required this.links, this.rocket, this.launchpad, this.rocketName, this.launchpadName});
  factory _LaunchModel.fromJson(Map<String, dynamic> json) => _$LaunchModelFromJson(json);

@override final  String id;
@override final  String name;
@override@JsonKey(name: 'success') final  bool? success;
@override@JsonKey(name: 'flight_number') final  int flightNumber;
@override final  String? details;
@override@JsonKey(name: 'date_utc') final  String dateUtc;
@override final  LaunchLinks links;
@override final  String? rocket;
@override final  String? launchpad;
// Campos poblados después de resolver IDs
@override final  String? rocketName;
@override final  String? launchpadName;

/// Create a copy of LaunchModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LaunchModelCopyWith<_LaunchModel> get copyWith => __$LaunchModelCopyWithImpl<_LaunchModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LaunchModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LaunchModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.success, success) || other.success == success)&&(identical(other.flightNumber, flightNumber) || other.flightNumber == flightNumber)&&(identical(other.details, details) || other.details == details)&&(identical(other.dateUtc, dateUtc) || other.dateUtc == dateUtc)&&(identical(other.links, links) || other.links == links)&&(identical(other.rocket, rocket) || other.rocket == rocket)&&(identical(other.launchpad, launchpad) || other.launchpad == launchpad)&&(identical(other.rocketName, rocketName) || other.rocketName == rocketName)&&(identical(other.launchpadName, launchpadName) || other.launchpadName == launchpadName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,success,flightNumber,details,dateUtc,links,rocket,launchpad,rocketName,launchpadName);

@override
String toString() {
  return 'LaunchModel(id: $id, name: $name, success: $success, flightNumber: $flightNumber, details: $details, dateUtc: $dateUtc, links: $links, rocket: $rocket, launchpad: $launchpad, rocketName: $rocketName, launchpadName: $launchpadName)';
}


}

/// @nodoc
abstract mixin class _$LaunchModelCopyWith<$Res> implements $LaunchModelCopyWith<$Res> {
  factory _$LaunchModelCopyWith(_LaunchModel value, $Res Function(_LaunchModel) _then) = __$LaunchModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name,@JsonKey(name: 'success') bool? success,@JsonKey(name: 'flight_number') int flightNumber, String? details,@JsonKey(name: 'date_utc') String dateUtc, LaunchLinks links, String? rocket, String? launchpad, String? rocketName, String? launchpadName
});


@override $LaunchLinksCopyWith<$Res> get links;

}
/// @nodoc
class __$LaunchModelCopyWithImpl<$Res>
    implements _$LaunchModelCopyWith<$Res> {
  __$LaunchModelCopyWithImpl(this._self, this._then);

  final _LaunchModel _self;
  final $Res Function(_LaunchModel) _then;

/// Create a copy of LaunchModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? success = freezed,Object? flightNumber = null,Object? details = freezed,Object? dateUtc = null,Object? links = null,Object? rocket = freezed,Object? launchpad = freezed,Object? rocketName = freezed,Object? launchpadName = freezed,}) {
  return _then(_LaunchModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,success: freezed == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool?,flightNumber: null == flightNumber ? _self.flightNumber : flightNumber // ignore: cast_nullable_to_non_nullable
as int,details: freezed == details ? _self.details : details // ignore: cast_nullable_to_non_nullable
as String?,dateUtc: null == dateUtc ? _self.dateUtc : dateUtc // ignore: cast_nullable_to_non_nullable
as String,links: null == links ? _self.links : links // ignore: cast_nullable_to_non_nullable
as LaunchLinks,rocket: freezed == rocket ? _self.rocket : rocket // ignore: cast_nullable_to_non_nullable
as String?,launchpad: freezed == launchpad ? _self.launchpad : launchpad // ignore: cast_nullable_to_non_nullable
as String?,rocketName: freezed == rocketName ? _self.rocketName : rocketName // ignore: cast_nullable_to_non_nullable
as String?,launchpadName: freezed == launchpadName ? _self.launchpadName : launchpadName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of LaunchModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LaunchLinksCopyWith<$Res> get links {
  
  return $LaunchLinksCopyWith<$Res>(_self.links, (value) {
    return _then(_self.copyWith(links: value));
  });
}
}


/// @nodoc
mixin _$LaunchLinks {

 LaunchPatch? get patch; LaunchFlickr? get flickr; String? get webcast; String? get wikipedia; String? get article;
/// Create a copy of LaunchLinks
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LaunchLinksCopyWith<LaunchLinks> get copyWith => _$LaunchLinksCopyWithImpl<LaunchLinks>(this as LaunchLinks, _$identity);

  /// Serializes this LaunchLinks to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LaunchLinks&&(identical(other.patch, patch) || other.patch == patch)&&(identical(other.flickr, flickr) || other.flickr == flickr)&&(identical(other.webcast, webcast) || other.webcast == webcast)&&(identical(other.wikipedia, wikipedia) || other.wikipedia == wikipedia)&&(identical(other.article, article) || other.article == article));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,patch,flickr,webcast,wikipedia,article);

@override
String toString() {
  return 'LaunchLinks(patch: $patch, flickr: $flickr, webcast: $webcast, wikipedia: $wikipedia, article: $article)';
}


}

/// @nodoc
abstract mixin class $LaunchLinksCopyWith<$Res>  {
  factory $LaunchLinksCopyWith(LaunchLinks value, $Res Function(LaunchLinks) _then) = _$LaunchLinksCopyWithImpl;
@useResult
$Res call({
 LaunchPatch? patch, LaunchFlickr? flickr, String? webcast, String? wikipedia, String? article
});


$LaunchPatchCopyWith<$Res>? get patch;$LaunchFlickrCopyWith<$Res>? get flickr;

}
/// @nodoc
class _$LaunchLinksCopyWithImpl<$Res>
    implements $LaunchLinksCopyWith<$Res> {
  _$LaunchLinksCopyWithImpl(this._self, this._then);

  final LaunchLinks _self;
  final $Res Function(LaunchLinks) _then;

/// Create a copy of LaunchLinks
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? patch = freezed,Object? flickr = freezed,Object? webcast = freezed,Object? wikipedia = freezed,Object? article = freezed,}) {
  return _then(_self.copyWith(
patch: freezed == patch ? _self.patch : patch // ignore: cast_nullable_to_non_nullable
as LaunchPatch?,flickr: freezed == flickr ? _self.flickr : flickr // ignore: cast_nullable_to_non_nullable
as LaunchFlickr?,webcast: freezed == webcast ? _self.webcast : webcast // ignore: cast_nullable_to_non_nullable
as String?,wikipedia: freezed == wikipedia ? _self.wikipedia : wikipedia // ignore: cast_nullable_to_non_nullable
as String?,article: freezed == article ? _self.article : article // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of LaunchLinks
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LaunchPatchCopyWith<$Res>? get patch {
    if (_self.patch == null) {
    return null;
  }

  return $LaunchPatchCopyWith<$Res>(_self.patch!, (value) {
    return _then(_self.copyWith(patch: value));
  });
}/// Create a copy of LaunchLinks
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LaunchFlickrCopyWith<$Res>? get flickr {
    if (_self.flickr == null) {
    return null;
  }

  return $LaunchFlickrCopyWith<$Res>(_self.flickr!, (value) {
    return _then(_self.copyWith(flickr: value));
  });
}
}


/// Adds pattern-matching-related methods to [LaunchLinks].
extension LaunchLinksPatterns on LaunchLinks {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LaunchLinks value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LaunchLinks() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LaunchLinks value)  $default,){
final _that = this;
switch (_that) {
case _LaunchLinks():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LaunchLinks value)?  $default,){
final _that = this;
switch (_that) {
case _LaunchLinks() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( LaunchPatch? patch,  LaunchFlickr? flickr,  String? webcast,  String? wikipedia,  String? article)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LaunchLinks() when $default != null:
return $default(_that.patch,_that.flickr,_that.webcast,_that.wikipedia,_that.article);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( LaunchPatch? patch,  LaunchFlickr? flickr,  String? webcast,  String? wikipedia,  String? article)  $default,) {final _that = this;
switch (_that) {
case _LaunchLinks():
return $default(_that.patch,_that.flickr,_that.webcast,_that.wikipedia,_that.article);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( LaunchPatch? patch,  LaunchFlickr? flickr,  String? webcast,  String? wikipedia,  String? article)?  $default,) {final _that = this;
switch (_that) {
case _LaunchLinks() when $default != null:
return $default(_that.patch,_that.flickr,_that.webcast,_that.wikipedia,_that.article);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LaunchLinks implements LaunchLinks {
  const _LaunchLinks({this.patch, this.flickr, this.webcast, this.wikipedia, this.article});
  factory _LaunchLinks.fromJson(Map<String, dynamic> json) => _$LaunchLinksFromJson(json);

@override final  LaunchPatch? patch;
@override final  LaunchFlickr? flickr;
@override final  String? webcast;
@override final  String? wikipedia;
@override final  String? article;

/// Create a copy of LaunchLinks
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LaunchLinksCopyWith<_LaunchLinks> get copyWith => __$LaunchLinksCopyWithImpl<_LaunchLinks>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LaunchLinksToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LaunchLinks&&(identical(other.patch, patch) || other.patch == patch)&&(identical(other.flickr, flickr) || other.flickr == flickr)&&(identical(other.webcast, webcast) || other.webcast == webcast)&&(identical(other.wikipedia, wikipedia) || other.wikipedia == wikipedia)&&(identical(other.article, article) || other.article == article));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,patch,flickr,webcast,wikipedia,article);

@override
String toString() {
  return 'LaunchLinks(patch: $patch, flickr: $flickr, webcast: $webcast, wikipedia: $wikipedia, article: $article)';
}


}

/// @nodoc
abstract mixin class _$LaunchLinksCopyWith<$Res> implements $LaunchLinksCopyWith<$Res> {
  factory _$LaunchLinksCopyWith(_LaunchLinks value, $Res Function(_LaunchLinks) _then) = __$LaunchLinksCopyWithImpl;
@override @useResult
$Res call({
 LaunchPatch? patch, LaunchFlickr? flickr, String? webcast, String? wikipedia, String? article
});


@override $LaunchPatchCopyWith<$Res>? get patch;@override $LaunchFlickrCopyWith<$Res>? get flickr;

}
/// @nodoc
class __$LaunchLinksCopyWithImpl<$Res>
    implements _$LaunchLinksCopyWith<$Res> {
  __$LaunchLinksCopyWithImpl(this._self, this._then);

  final _LaunchLinks _self;
  final $Res Function(_LaunchLinks) _then;

/// Create a copy of LaunchLinks
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? patch = freezed,Object? flickr = freezed,Object? webcast = freezed,Object? wikipedia = freezed,Object? article = freezed,}) {
  return _then(_LaunchLinks(
patch: freezed == patch ? _self.patch : patch // ignore: cast_nullable_to_non_nullable
as LaunchPatch?,flickr: freezed == flickr ? _self.flickr : flickr // ignore: cast_nullable_to_non_nullable
as LaunchFlickr?,webcast: freezed == webcast ? _self.webcast : webcast // ignore: cast_nullable_to_non_nullable
as String?,wikipedia: freezed == wikipedia ? _self.wikipedia : wikipedia // ignore: cast_nullable_to_non_nullable
as String?,article: freezed == article ? _self.article : article // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of LaunchLinks
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LaunchPatchCopyWith<$Res>? get patch {
    if (_self.patch == null) {
    return null;
  }

  return $LaunchPatchCopyWith<$Res>(_self.patch!, (value) {
    return _then(_self.copyWith(patch: value));
  });
}/// Create a copy of LaunchLinks
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LaunchFlickrCopyWith<$Res>? get flickr {
    if (_self.flickr == null) {
    return null;
  }

  return $LaunchFlickrCopyWith<$Res>(_self.flickr!, (value) {
    return _then(_self.copyWith(flickr: value));
  });
}
}


/// @nodoc
mixin _$LaunchPatch {

 String? get small; String? get large;
/// Create a copy of LaunchPatch
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LaunchPatchCopyWith<LaunchPatch> get copyWith => _$LaunchPatchCopyWithImpl<LaunchPatch>(this as LaunchPatch, _$identity);

  /// Serializes this LaunchPatch to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LaunchPatch&&(identical(other.small, small) || other.small == small)&&(identical(other.large, large) || other.large == large));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,small,large);

@override
String toString() {
  return 'LaunchPatch(small: $small, large: $large)';
}


}

/// @nodoc
abstract mixin class $LaunchPatchCopyWith<$Res>  {
  factory $LaunchPatchCopyWith(LaunchPatch value, $Res Function(LaunchPatch) _then) = _$LaunchPatchCopyWithImpl;
@useResult
$Res call({
 String? small, String? large
});




}
/// @nodoc
class _$LaunchPatchCopyWithImpl<$Res>
    implements $LaunchPatchCopyWith<$Res> {
  _$LaunchPatchCopyWithImpl(this._self, this._then);

  final LaunchPatch _self;
  final $Res Function(LaunchPatch) _then;

/// Create a copy of LaunchPatch
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? small = freezed,Object? large = freezed,}) {
  return _then(_self.copyWith(
small: freezed == small ? _self.small : small // ignore: cast_nullable_to_non_nullable
as String?,large: freezed == large ? _self.large : large // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [LaunchPatch].
extension LaunchPatchPatterns on LaunchPatch {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LaunchPatch value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LaunchPatch() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LaunchPatch value)  $default,){
final _that = this;
switch (_that) {
case _LaunchPatch():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LaunchPatch value)?  $default,){
final _that = this;
switch (_that) {
case _LaunchPatch() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? small,  String? large)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LaunchPatch() when $default != null:
return $default(_that.small,_that.large);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? small,  String? large)  $default,) {final _that = this;
switch (_that) {
case _LaunchPatch():
return $default(_that.small,_that.large);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? small,  String? large)?  $default,) {final _that = this;
switch (_that) {
case _LaunchPatch() when $default != null:
return $default(_that.small,_that.large);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LaunchPatch implements LaunchPatch {
  const _LaunchPatch({this.small, this.large});
  factory _LaunchPatch.fromJson(Map<String, dynamic> json) => _$LaunchPatchFromJson(json);

@override final  String? small;
@override final  String? large;

/// Create a copy of LaunchPatch
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LaunchPatchCopyWith<_LaunchPatch> get copyWith => __$LaunchPatchCopyWithImpl<_LaunchPatch>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LaunchPatchToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LaunchPatch&&(identical(other.small, small) || other.small == small)&&(identical(other.large, large) || other.large == large));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,small,large);

@override
String toString() {
  return 'LaunchPatch(small: $small, large: $large)';
}


}

/// @nodoc
abstract mixin class _$LaunchPatchCopyWith<$Res> implements $LaunchPatchCopyWith<$Res> {
  factory _$LaunchPatchCopyWith(_LaunchPatch value, $Res Function(_LaunchPatch) _then) = __$LaunchPatchCopyWithImpl;
@override @useResult
$Res call({
 String? small, String? large
});




}
/// @nodoc
class __$LaunchPatchCopyWithImpl<$Res>
    implements _$LaunchPatchCopyWith<$Res> {
  __$LaunchPatchCopyWithImpl(this._self, this._then);

  final _LaunchPatch _self;
  final $Res Function(_LaunchPatch) _then;

/// Create a copy of LaunchPatch
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? small = freezed,Object? large = freezed,}) {
  return _then(_LaunchPatch(
small: freezed == small ? _self.small : small // ignore: cast_nullable_to_non_nullable
as String?,large: freezed == large ? _self.large : large // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$LaunchFlickr {

 List<String> get small; List<String> get original;
/// Create a copy of LaunchFlickr
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LaunchFlickrCopyWith<LaunchFlickr> get copyWith => _$LaunchFlickrCopyWithImpl<LaunchFlickr>(this as LaunchFlickr, _$identity);

  /// Serializes this LaunchFlickr to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LaunchFlickr&&const DeepCollectionEquality().equals(other.small, small)&&const DeepCollectionEquality().equals(other.original, original));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(small),const DeepCollectionEquality().hash(original));

@override
String toString() {
  return 'LaunchFlickr(small: $small, original: $original)';
}


}

/// @nodoc
abstract mixin class $LaunchFlickrCopyWith<$Res>  {
  factory $LaunchFlickrCopyWith(LaunchFlickr value, $Res Function(LaunchFlickr) _then) = _$LaunchFlickrCopyWithImpl;
@useResult
$Res call({
 List<String> small, List<String> original
});




}
/// @nodoc
class _$LaunchFlickrCopyWithImpl<$Res>
    implements $LaunchFlickrCopyWith<$Res> {
  _$LaunchFlickrCopyWithImpl(this._self, this._then);

  final LaunchFlickr _self;
  final $Res Function(LaunchFlickr) _then;

/// Create a copy of LaunchFlickr
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? small = null,Object? original = null,}) {
  return _then(_self.copyWith(
small: null == small ? _self.small : small // ignore: cast_nullable_to_non_nullable
as List<String>,original: null == original ? _self.original : original // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [LaunchFlickr].
extension LaunchFlickrPatterns on LaunchFlickr {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LaunchFlickr value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LaunchFlickr() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LaunchFlickr value)  $default,){
final _that = this;
switch (_that) {
case _LaunchFlickr():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LaunchFlickr value)?  $default,){
final _that = this;
switch (_that) {
case _LaunchFlickr() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<String> small,  List<String> original)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LaunchFlickr() when $default != null:
return $default(_that.small,_that.original);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<String> small,  List<String> original)  $default,) {final _that = this;
switch (_that) {
case _LaunchFlickr():
return $default(_that.small,_that.original);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<String> small,  List<String> original)?  $default,) {final _that = this;
switch (_that) {
case _LaunchFlickr() when $default != null:
return $default(_that.small,_that.original);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LaunchFlickr implements LaunchFlickr {
  const _LaunchFlickr({final  List<String> small = const [], final  List<String> original = const []}): _small = small,_original = original;
  factory _LaunchFlickr.fromJson(Map<String, dynamic> json) => _$LaunchFlickrFromJson(json);

 final  List<String> _small;
@override@JsonKey() List<String> get small {
  if (_small is EqualUnmodifiableListView) return _small;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_small);
}

 final  List<String> _original;
@override@JsonKey() List<String> get original {
  if (_original is EqualUnmodifiableListView) return _original;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_original);
}


/// Create a copy of LaunchFlickr
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LaunchFlickrCopyWith<_LaunchFlickr> get copyWith => __$LaunchFlickrCopyWithImpl<_LaunchFlickr>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LaunchFlickrToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LaunchFlickr&&const DeepCollectionEquality().equals(other._small, _small)&&const DeepCollectionEquality().equals(other._original, _original));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_small),const DeepCollectionEquality().hash(_original));

@override
String toString() {
  return 'LaunchFlickr(small: $small, original: $original)';
}


}

/// @nodoc
abstract mixin class _$LaunchFlickrCopyWith<$Res> implements $LaunchFlickrCopyWith<$Res> {
  factory _$LaunchFlickrCopyWith(_LaunchFlickr value, $Res Function(_LaunchFlickr) _then) = __$LaunchFlickrCopyWithImpl;
@override @useResult
$Res call({
 List<String> small, List<String> original
});




}
/// @nodoc
class __$LaunchFlickrCopyWithImpl<$Res>
    implements _$LaunchFlickrCopyWith<$Res> {
  __$LaunchFlickrCopyWithImpl(this._self, this._then);

  final _LaunchFlickr _self;
  final $Res Function(_LaunchFlickr) _then;

/// Create a copy of LaunchFlickr
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? small = null,Object? original = null,}) {
  return _then(_LaunchFlickr(
small: null == small ? _self._small : small // ignore: cast_nullable_to_non_nullable
as List<String>,original: null == original ? _self._original : original // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
