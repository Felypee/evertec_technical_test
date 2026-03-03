// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $LaunchesTable extends Launches with TableInfo<$LaunchesTable, Launch> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LaunchesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _successMeta = const VerificationMeta(
    'success',
  );
  @override
  late final GeneratedColumn<int> success = GeneratedColumn<int>(
    'success',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _flightNumberMeta = const VerificationMeta(
    'flightNumber',
  );
  @override
  late final GeneratedColumn<int> flightNumber = GeneratedColumn<int>(
    'flight_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _detailsMeta = const VerificationMeta(
    'details',
  );
  @override
  late final GeneratedColumn<String> details = GeneratedColumn<String>(
    'details',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dateUtcMeta = const VerificationMeta(
    'dateUtc',
  );
  @override
  late final GeneratedColumn<String> dateUtc = GeneratedColumn<String>(
    'date_utc',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _patchSmallMeta = const VerificationMeta(
    'patchSmall',
  );
  @override
  late final GeneratedColumn<String> patchSmall = GeneratedColumn<String>(
    'patch_small',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _patchLargeMeta = const VerificationMeta(
    'patchLarge',
  );
  @override
  late final GeneratedColumn<String> patchLarge = GeneratedColumn<String>(
    'patch_large',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _webcastMeta = const VerificationMeta(
    'webcast',
  );
  @override
  late final GeneratedColumn<String> webcast = GeneratedColumn<String>(
    'webcast',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _wikipediaMeta = const VerificationMeta(
    'wikipedia',
  );
  @override
  late final GeneratedColumn<String> wikipedia = GeneratedColumn<String>(
    'wikipedia',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _articleMeta = const VerificationMeta(
    'article',
  );
  @override
  late final GeneratedColumn<String> article = GeneratedColumn<String>(
    'article',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _flickrImagesMeta = const VerificationMeta(
    'flickrImages',
  );
  @override
  late final GeneratedColumn<String> flickrImages = GeneratedColumn<String>(
    'flickr_images',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _rocketMeta = const VerificationMeta('rocket');
  @override
  late final GeneratedColumn<String> rocket = GeneratedColumn<String>(
    'rocket',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _launchpadMeta = const VerificationMeta(
    'launchpad',
  );
  @override
  late final GeneratedColumn<String> launchpad = GeneratedColumn<String>(
    'launchpad',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _rocketNameMeta = const VerificationMeta(
    'rocketName',
  );
  @override
  late final GeneratedColumn<String> rocketName = GeneratedColumn<String>(
    'rocket_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _launchpadNameMeta = const VerificationMeta(
    'launchpadName',
  );
  @override
  late final GeneratedColumn<String> launchpadName = GeneratedColumn<String>(
    'launchpad_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _cachedAtMeta = const VerificationMeta(
    'cachedAt',
  );
  @override
  late final GeneratedColumn<DateTime> cachedAt = GeneratedColumn<DateTime>(
    'cached_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    success,
    flightNumber,
    details,
    dateUtc,
    patchSmall,
    patchLarge,
    webcast,
    wikipedia,
    article,
    flickrImages,
    rocket,
    launchpad,
    rocketName,
    launchpadName,
    cachedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'launches';
  @override
  VerificationContext validateIntegrity(
    Insertable<Launch> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('success')) {
      context.handle(
        _successMeta,
        success.isAcceptableOrUnknown(data['success']!, _successMeta),
      );
    }
    if (data.containsKey('flight_number')) {
      context.handle(
        _flightNumberMeta,
        flightNumber.isAcceptableOrUnknown(
          data['flight_number']!,
          _flightNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_flightNumberMeta);
    }
    if (data.containsKey('details')) {
      context.handle(
        _detailsMeta,
        details.isAcceptableOrUnknown(data['details']!, _detailsMeta),
      );
    }
    if (data.containsKey('date_utc')) {
      context.handle(
        _dateUtcMeta,
        dateUtc.isAcceptableOrUnknown(data['date_utc']!, _dateUtcMeta),
      );
    } else if (isInserting) {
      context.missing(_dateUtcMeta);
    }
    if (data.containsKey('patch_small')) {
      context.handle(
        _patchSmallMeta,
        patchSmall.isAcceptableOrUnknown(data['patch_small']!, _patchSmallMeta),
      );
    }
    if (data.containsKey('patch_large')) {
      context.handle(
        _patchLargeMeta,
        patchLarge.isAcceptableOrUnknown(data['patch_large']!, _patchLargeMeta),
      );
    }
    if (data.containsKey('webcast')) {
      context.handle(
        _webcastMeta,
        webcast.isAcceptableOrUnknown(data['webcast']!, _webcastMeta),
      );
    }
    if (data.containsKey('wikipedia')) {
      context.handle(
        _wikipediaMeta,
        wikipedia.isAcceptableOrUnknown(data['wikipedia']!, _wikipediaMeta),
      );
    }
    if (data.containsKey('article')) {
      context.handle(
        _articleMeta,
        article.isAcceptableOrUnknown(data['article']!, _articleMeta),
      );
    }
    if (data.containsKey('flickr_images')) {
      context.handle(
        _flickrImagesMeta,
        flickrImages.isAcceptableOrUnknown(
          data['flickr_images']!,
          _flickrImagesMeta,
        ),
      );
    }
    if (data.containsKey('rocket')) {
      context.handle(
        _rocketMeta,
        rocket.isAcceptableOrUnknown(data['rocket']!, _rocketMeta),
      );
    }
    if (data.containsKey('launchpad')) {
      context.handle(
        _launchpadMeta,
        launchpad.isAcceptableOrUnknown(data['launchpad']!, _launchpadMeta),
      );
    }
    if (data.containsKey('rocket_name')) {
      context.handle(
        _rocketNameMeta,
        rocketName.isAcceptableOrUnknown(data['rocket_name']!, _rocketNameMeta),
      );
    }
    if (data.containsKey('launchpad_name')) {
      context.handle(
        _launchpadNameMeta,
        launchpadName.isAcceptableOrUnknown(
          data['launchpad_name']!,
          _launchpadNameMeta,
        ),
      );
    }
    if (data.containsKey('cached_at')) {
      context.handle(
        _cachedAtMeta,
        cachedAt.isAcceptableOrUnknown(data['cached_at']!, _cachedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Launch map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Launch(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      success: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}success'],
      ),
      flightNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}flight_number'],
      )!,
      details: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}details'],
      ),
      dateUtc: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}date_utc'],
      )!,
      patchSmall: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}patch_small'],
      ),
      patchLarge: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}patch_large'],
      ),
      webcast: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}webcast'],
      ),
      wikipedia: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}wikipedia'],
      ),
      article: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}article'],
      ),
      flickrImages: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}flickr_images'],
      )!,
      rocket: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}rocket'],
      ),
      launchpad: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}launchpad'],
      ),
      rocketName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}rocket_name'],
      ),
      launchpadName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}launchpad_name'],
      ),
      cachedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}cached_at'],
      )!,
    );
  }

  @override
  $LaunchesTable createAlias(String alias) {
    return $LaunchesTable(attachedDatabase, alias);
  }
}

class Launch extends DataClass implements Insertable<Launch> {
  final String id;
  final String name;
  final int? success;
  final int flightNumber;
  final String? details;
  final String dateUtc;
  final String? patchSmall;
  final String? patchLarge;
  final String? webcast;
  final String? wikipedia;
  final String? article;
  final String flickrImages;
  final String? rocket;
  final String? launchpad;
  final String? rocketName;
  final String? launchpadName;
  final DateTime cachedAt;
  const Launch({
    required this.id,
    required this.name,
    this.success,
    required this.flightNumber,
    this.details,
    required this.dateUtc,
    this.patchSmall,
    this.patchLarge,
    this.webcast,
    this.wikipedia,
    this.article,
    required this.flickrImages,
    this.rocket,
    this.launchpad,
    this.rocketName,
    this.launchpadName,
    required this.cachedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || success != null) {
      map['success'] = Variable<int>(success);
    }
    map['flight_number'] = Variable<int>(flightNumber);
    if (!nullToAbsent || details != null) {
      map['details'] = Variable<String>(details);
    }
    map['date_utc'] = Variable<String>(dateUtc);
    if (!nullToAbsent || patchSmall != null) {
      map['patch_small'] = Variable<String>(patchSmall);
    }
    if (!nullToAbsent || patchLarge != null) {
      map['patch_large'] = Variable<String>(patchLarge);
    }
    if (!nullToAbsent || webcast != null) {
      map['webcast'] = Variable<String>(webcast);
    }
    if (!nullToAbsent || wikipedia != null) {
      map['wikipedia'] = Variable<String>(wikipedia);
    }
    if (!nullToAbsent || article != null) {
      map['article'] = Variable<String>(article);
    }
    map['flickr_images'] = Variable<String>(flickrImages);
    if (!nullToAbsent || rocket != null) {
      map['rocket'] = Variable<String>(rocket);
    }
    if (!nullToAbsent || launchpad != null) {
      map['launchpad'] = Variable<String>(launchpad);
    }
    if (!nullToAbsent || rocketName != null) {
      map['rocket_name'] = Variable<String>(rocketName);
    }
    if (!nullToAbsent || launchpadName != null) {
      map['launchpad_name'] = Variable<String>(launchpadName);
    }
    map['cached_at'] = Variable<DateTime>(cachedAt);
    return map;
  }

  LaunchesCompanion toCompanion(bool nullToAbsent) {
    return LaunchesCompanion(
      id: Value(id),
      name: Value(name),
      success: success == null && nullToAbsent
          ? const Value.absent()
          : Value(success),
      flightNumber: Value(flightNumber),
      details: details == null && nullToAbsent
          ? const Value.absent()
          : Value(details),
      dateUtc: Value(dateUtc),
      patchSmall: patchSmall == null && nullToAbsent
          ? const Value.absent()
          : Value(patchSmall),
      patchLarge: patchLarge == null && nullToAbsent
          ? const Value.absent()
          : Value(patchLarge),
      webcast: webcast == null && nullToAbsent
          ? const Value.absent()
          : Value(webcast),
      wikipedia: wikipedia == null && nullToAbsent
          ? const Value.absent()
          : Value(wikipedia),
      article: article == null && nullToAbsent
          ? const Value.absent()
          : Value(article),
      flickrImages: Value(flickrImages),
      rocket: rocket == null && nullToAbsent
          ? const Value.absent()
          : Value(rocket),
      launchpad: launchpad == null && nullToAbsent
          ? const Value.absent()
          : Value(launchpad),
      rocketName: rocketName == null && nullToAbsent
          ? const Value.absent()
          : Value(rocketName),
      launchpadName: launchpadName == null && nullToAbsent
          ? const Value.absent()
          : Value(launchpadName),
      cachedAt: Value(cachedAt),
    );
  }

  factory Launch.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Launch(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      success: serializer.fromJson<int?>(json['success']),
      flightNumber: serializer.fromJson<int>(json['flightNumber']),
      details: serializer.fromJson<String?>(json['details']),
      dateUtc: serializer.fromJson<String>(json['dateUtc']),
      patchSmall: serializer.fromJson<String?>(json['patchSmall']),
      patchLarge: serializer.fromJson<String?>(json['patchLarge']),
      webcast: serializer.fromJson<String?>(json['webcast']),
      wikipedia: serializer.fromJson<String?>(json['wikipedia']),
      article: serializer.fromJson<String?>(json['article']),
      flickrImages: serializer.fromJson<String>(json['flickrImages']),
      rocket: serializer.fromJson<String?>(json['rocket']),
      launchpad: serializer.fromJson<String?>(json['launchpad']),
      rocketName: serializer.fromJson<String?>(json['rocketName']),
      launchpadName: serializer.fromJson<String?>(json['launchpadName']),
      cachedAt: serializer.fromJson<DateTime>(json['cachedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'success': serializer.toJson<int?>(success),
      'flightNumber': serializer.toJson<int>(flightNumber),
      'details': serializer.toJson<String?>(details),
      'dateUtc': serializer.toJson<String>(dateUtc),
      'patchSmall': serializer.toJson<String?>(patchSmall),
      'patchLarge': serializer.toJson<String?>(patchLarge),
      'webcast': serializer.toJson<String?>(webcast),
      'wikipedia': serializer.toJson<String?>(wikipedia),
      'article': serializer.toJson<String?>(article),
      'flickrImages': serializer.toJson<String>(flickrImages),
      'rocket': serializer.toJson<String?>(rocket),
      'launchpad': serializer.toJson<String?>(launchpad),
      'rocketName': serializer.toJson<String?>(rocketName),
      'launchpadName': serializer.toJson<String?>(launchpadName),
      'cachedAt': serializer.toJson<DateTime>(cachedAt),
    };
  }

  Launch copyWith({
    String? id,
    String? name,
    Value<int?> success = const Value.absent(),
    int? flightNumber,
    Value<String?> details = const Value.absent(),
    String? dateUtc,
    Value<String?> patchSmall = const Value.absent(),
    Value<String?> patchLarge = const Value.absent(),
    Value<String?> webcast = const Value.absent(),
    Value<String?> wikipedia = const Value.absent(),
    Value<String?> article = const Value.absent(),
    String? flickrImages,
    Value<String?> rocket = const Value.absent(),
    Value<String?> launchpad = const Value.absent(),
    Value<String?> rocketName = const Value.absent(),
    Value<String?> launchpadName = const Value.absent(),
    DateTime? cachedAt,
  }) => Launch(
    id: id ?? this.id,
    name: name ?? this.name,
    success: success.present ? success.value : this.success,
    flightNumber: flightNumber ?? this.flightNumber,
    details: details.present ? details.value : this.details,
    dateUtc: dateUtc ?? this.dateUtc,
    patchSmall: patchSmall.present ? patchSmall.value : this.patchSmall,
    patchLarge: patchLarge.present ? patchLarge.value : this.patchLarge,
    webcast: webcast.present ? webcast.value : this.webcast,
    wikipedia: wikipedia.present ? wikipedia.value : this.wikipedia,
    article: article.present ? article.value : this.article,
    flickrImages: flickrImages ?? this.flickrImages,
    rocket: rocket.present ? rocket.value : this.rocket,
    launchpad: launchpad.present ? launchpad.value : this.launchpad,
    rocketName: rocketName.present ? rocketName.value : this.rocketName,
    launchpadName: launchpadName.present
        ? launchpadName.value
        : this.launchpadName,
    cachedAt: cachedAt ?? this.cachedAt,
  );
  Launch copyWithCompanion(LaunchesCompanion data) {
    return Launch(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      success: data.success.present ? data.success.value : this.success,
      flightNumber: data.flightNumber.present
          ? data.flightNumber.value
          : this.flightNumber,
      details: data.details.present ? data.details.value : this.details,
      dateUtc: data.dateUtc.present ? data.dateUtc.value : this.dateUtc,
      patchSmall: data.patchSmall.present
          ? data.patchSmall.value
          : this.patchSmall,
      patchLarge: data.patchLarge.present
          ? data.patchLarge.value
          : this.patchLarge,
      webcast: data.webcast.present ? data.webcast.value : this.webcast,
      wikipedia: data.wikipedia.present ? data.wikipedia.value : this.wikipedia,
      article: data.article.present ? data.article.value : this.article,
      flickrImages: data.flickrImages.present
          ? data.flickrImages.value
          : this.flickrImages,
      rocket: data.rocket.present ? data.rocket.value : this.rocket,
      launchpad: data.launchpad.present ? data.launchpad.value : this.launchpad,
      rocketName: data.rocketName.present
          ? data.rocketName.value
          : this.rocketName,
      launchpadName: data.launchpadName.present
          ? data.launchpadName.value
          : this.launchpadName,
      cachedAt: data.cachedAt.present ? data.cachedAt.value : this.cachedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Launch(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('success: $success, ')
          ..write('flightNumber: $flightNumber, ')
          ..write('details: $details, ')
          ..write('dateUtc: $dateUtc, ')
          ..write('patchSmall: $patchSmall, ')
          ..write('patchLarge: $patchLarge, ')
          ..write('webcast: $webcast, ')
          ..write('wikipedia: $wikipedia, ')
          ..write('article: $article, ')
          ..write('flickrImages: $flickrImages, ')
          ..write('rocket: $rocket, ')
          ..write('launchpad: $launchpad, ')
          ..write('rocketName: $rocketName, ')
          ..write('launchpadName: $launchpadName, ')
          ..write('cachedAt: $cachedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    success,
    flightNumber,
    details,
    dateUtc,
    patchSmall,
    patchLarge,
    webcast,
    wikipedia,
    article,
    flickrImages,
    rocket,
    launchpad,
    rocketName,
    launchpadName,
    cachedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Launch &&
          other.id == this.id &&
          other.name == this.name &&
          other.success == this.success &&
          other.flightNumber == this.flightNumber &&
          other.details == this.details &&
          other.dateUtc == this.dateUtc &&
          other.patchSmall == this.patchSmall &&
          other.patchLarge == this.patchLarge &&
          other.webcast == this.webcast &&
          other.wikipedia == this.wikipedia &&
          other.article == this.article &&
          other.flickrImages == this.flickrImages &&
          other.rocket == this.rocket &&
          other.launchpad == this.launchpad &&
          other.rocketName == this.rocketName &&
          other.launchpadName == this.launchpadName &&
          other.cachedAt == this.cachedAt);
}

class LaunchesCompanion extends UpdateCompanion<Launch> {
  final Value<String> id;
  final Value<String> name;
  final Value<int?> success;
  final Value<int> flightNumber;
  final Value<String?> details;
  final Value<String> dateUtc;
  final Value<String?> patchSmall;
  final Value<String?> patchLarge;
  final Value<String?> webcast;
  final Value<String?> wikipedia;
  final Value<String?> article;
  final Value<String> flickrImages;
  final Value<String?> rocket;
  final Value<String?> launchpad;
  final Value<String?> rocketName;
  final Value<String?> launchpadName;
  final Value<DateTime> cachedAt;
  final Value<int> rowid;
  const LaunchesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.success = const Value.absent(),
    this.flightNumber = const Value.absent(),
    this.details = const Value.absent(),
    this.dateUtc = const Value.absent(),
    this.patchSmall = const Value.absent(),
    this.patchLarge = const Value.absent(),
    this.webcast = const Value.absent(),
    this.wikipedia = const Value.absent(),
    this.article = const Value.absent(),
    this.flickrImages = const Value.absent(),
    this.rocket = const Value.absent(),
    this.launchpad = const Value.absent(),
    this.rocketName = const Value.absent(),
    this.launchpadName = const Value.absent(),
    this.cachedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LaunchesCompanion.insert({
    required String id,
    required String name,
    this.success = const Value.absent(),
    required int flightNumber,
    this.details = const Value.absent(),
    required String dateUtc,
    this.patchSmall = const Value.absent(),
    this.patchLarge = const Value.absent(),
    this.webcast = const Value.absent(),
    this.wikipedia = const Value.absent(),
    this.article = const Value.absent(),
    this.flickrImages = const Value.absent(),
    this.rocket = const Value.absent(),
    this.launchpad = const Value.absent(),
    this.rocketName = const Value.absent(),
    this.launchpadName = const Value.absent(),
    this.cachedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       flightNumber = Value(flightNumber),
       dateUtc = Value(dateUtc);
  static Insertable<Launch> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<int>? success,
    Expression<int>? flightNumber,
    Expression<String>? details,
    Expression<String>? dateUtc,
    Expression<String>? patchSmall,
    Expression<String>? patchLarge,
    Expression<String>? webcast,
    Expression<String>? wikipedia,
    Expression<String>? article,
    Expression<String>? flickrImages,
    Expression<String>? rocket,
    Expression<String>? launchpad,
    Expression<String>? rocketName,
    Expression<String>? launchpadName,
    Expression<DateTime>? cachedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (success != null) 'success': success,
      if (flightNumber != null) 'flight_number': flightNumber,
      if (details != null) 'details': details,
      if (dateUtc != null) 'date_utc': dateUtc,
      if (patchSmall != null) 'patch_small': patchSmall,
      if (patchLarge != null) 'patch_large': patchLarge,
      if (webcast != null) 'webcast': webcast,
      if (wikipedia != null) 'wikipedia': wikipedia,
      if (article != null) 'article': article,
      if (flickrImages != null) 'flickr_images': flickrImages,
      if (rocket != null) 'rocket': rocket,
      if (launchpad != null) 'launchpad': launchpad,
      if (rocketName != null) 'rocket_name': rocketName,
      if (launchpadName != null) 'launchpad_name': launchpadName,
      if (cachedAt != null) 'cached_at': cachedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LaunchesCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<int?>? success,
    Value<int>? flightNumber,
    Value<String?>? details,
    Value<String>? dateUtc,
    Value<String?>? patchSmall,
    Value<String?>? patchLarge,
    Value<String?>? webcast,
    Value<String?>? wikipedia,
    Value<String?>? article,
    Value<String>? flickrImages,
    Value<String?>? rocket,
    Value<String?>? launchpad,
    Value<String?>? rocketName,
    Value<String?>? launchpadName,
    Value<DateTime>? cachedAt,
    Value<int>? rowid,
  }) {
    return LaunchesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      success: success ?? this.success,
      flightNumber: flightNumber ?? this.flightNumber,
      details: details ?? this.details,
      dateUtc: dateUtc ?? this.dateUtc,
      patchSmall: patchSmall ?? this.patchSmall,
      patchLarge: patchLarge ?? this.patchLarge,
      webcast: webcast ?? this.webcast,
      wikipedia: wikipedia ?? this.wikipedia,
      article: article ?? this.article,
      flickrImages: flickrImages ?? this.flickrImages,
      rocket: rocket ?? this.rocket,
      launchpad: launchpad ?? this.launchpad,
      rocketName: rocketName ?? this.rocketName,
      launchpadName: launchpadName ?? this.launchpadName,
      cachedAt: cachedAt ?? this.cachedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (success.present) {
      map['success'] = Variable<int>(success.value);
    }
    if (flightNumber.present) {
      map['flight_number'] = Variable<int>(flightNumber.value);
    }
    if (details.present) {
      map['details'] = Variable<String>(details.value);
    }
    if (dateUtc.present) {
      map['date_utc'] = Variable<String>(dateUtc.value);
    }
    if (patchSmall.present) {
      map['patch_small'] = Variable<String>(patchSmall.value);
    }
    if (patchLarge.present) {
      map['patch_large'] = Variable<String>(patchLarge.value);
    }
    if (webcast.present) {
      map['webcast'] = Variable<String>(webcast.value);
    }
    if (wikipedia.present) {
      map['wikipedia'] = Variable<String>(wikipedia.value);
    }
    if (article.present) {
      map['article'] = Variable<String>(article.value);
    }
    if (flickrImages.present) {
      map['flickr_images'] = Variable<String>(flickrImages.value);
    }
    if (rocket.present) {
      map['rocket'] = Variable<String>(rocket.value);
    }
    if (launchpad.present) {
      map['launchpad'] = Variable<String>(launchpad.value);
    }
    if (rocketName.present) {
      map['rocket_name'] = Variable<String>(rocketName.value);
    }
    if (launchpadName.present) {
      map['launchpad_name'] = Variable<String>(launchpadName.value);
    }
    if (cachedAt.present) {
      map['cached_at'] = Variable<DateTime>(cachedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LaunchesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('success: $success, ')
          ..write('flightNumber: $flightNumber, ')
          ..write('details: $details, ')
          ..write('dateUtc: $dateUtc, ')
          ..write('patchSmall: $patchSmall, ')
          ..write('patchLarge: $patchLarge, ')
          ..write('webcast: $webcast, ')
          ..write('wikipedia: $wikipedia, ')
          ..write('article: $article, ')
          ..write('flickrImages: $flickrImages, ')
          ..write('rocket: $rocket, ')
          ..write('launchpad: $launchpad, ')
          ..write('rocketName: $rocketName, ')
          ..write('launchpadName: $launchpadName, ')
          ..write('cachedAt: $cachedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $LaunchesTable launches = $LaunchesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [launches];
}

typedef $$LaunchesTableCreateCompanionBuilder =
    LaunchesCompanion Function({
      required String id,
      required String name,
      Value<int?> success,
      required int flightNumber,
      Value<String?> details,
      required String dateUtc,
      Value<String?> patchSmall,
      Value<String?> patchLarge,
      Value<String?> webcast,
      Value<String?> wikipedia,
      Value<String?> article,
      Value<String> flickrImages,
      Value<String?> rocket,
      Value<String?> launchpad,
      Value<String?> rocketName,
      Value<String?> launchpadName,
      Value<DateTime> cachedAt,
      Value<int> rowid,
    });
typedef $$LaunchesTableUpdateCompanionBuilder =
    LaunchesCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<int?> success,
      Value<int> flightNumber,
      Value<String?> details,
      Value<String> dateUtc,
      Value<String?> patchSmall,
      Value<String?> patchLarge,
      Value<String?> webcast,
      Value<String?> wikipedia,
      Value<String?> article,
      Value<String> flickrImages,
      Value<String?> rocket,
      Value<String?> launchpad,
      Value<String?> rocketName,
      Value<String?> launchpadName,
      Value<DateTime> cachedAt,
      Value<int> rowid,
    });

class $$LaunchesTableFilterComposer
    extends Composer<_$AppDatabase, $LaunchesTable> {
  $$LaunchesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get success => $composableBuilder(
    column: $table.success,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get flightNumber => $composableBuilder(
    column: $table.flightNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get details => $composableBuilder(
    column: $table.details,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dateUtc => $composableBuilder(
    column: $table.dateUtc,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get patchSmall => $composableBuilder(
    column: $table.patchSmall,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get patchLarge => $composableBuilder(
    column: $table.patchLarge,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get webcast => $composableBuilder(
    column: $table.webcast,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get wikipedia => $composableBuilder(
    column: $table.wikipedia,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get article => $composableBuilder(
    column: $table.article,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get flickrImages => $composableBuilder(
    column: $table.flickrImages,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get rocket => $composableBuilder(
    column: $table.rocket,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get launchpad => $composableBuilder(
    column: $table.launchpad,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get rocketName => $composableBuilder(
    column: $table.rocketName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get launchpadName => $composableBuilder(
    column: $table.launchpadName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get cachedAt => $composableBuilder(
    column: $table.cachedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LaunchesTableOrderingComposer
    extends Composer<_$AppDatabase, $LaunchesTable> {
  $$LaunchesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get success => $composableBuilder(
    column: $table.success,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get flightNumber => $composableBuilder(
    column: $table.flightNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get details => $composableBuilder(
    column: $table.details,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dateUtc => $composableBuilder(
    column: $table.dateUtc,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get patchSmall => $composableBuilder(
    column: $table.patchSmall,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get patchLarge => $composableBuilder(
    column: $table.patchLarge,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get webcast => $composableBuilder(
    column: $table.webcast,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get wikipedia => $composableBuilder(
    column: $table.wikipedia,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get article => $composableBuilder(
    column: $table.article,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get flickrImages => $composableBuilder(
    column: $table.flickrImages,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get rocket => $composableBuilder(
    column: $table.rocket,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get launchpad => $composableBuilder(
    column: $table.launchpad,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get rocketName => $composableBuilder(
    column: $table.rocketName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get launchpadName => $composableBuilder(
    column: $table.launchpadName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get cachedAt => $composableBuilder(
    column: $table.cachedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LaunchesTableAnnotationComposer
    extends Composer<_$AppDatabase, $LaunchesTable> {
  $$LaunchesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get success =>
      $composableBuilder(column: $table.success, builder: (column) => column);

  GeneratedColumn<int> get flightNumber => $composableBuilder(
    column: $table.flightNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get details =>
      $composableBuilder(column: $table.details, builder: (column) => column);

  GeneratedColumn<String> get dateUtc =>
      $composableBuilder(column: $table.dateUtc, builder: (column) => column);

  GeneratedColumn<String> get patchSmall => $composableBuilder(
    column: $table.patchSmall,
    builder: (column) => column,
  );

  GeneratedColumn<String> get patchLarge => $composableBuilder(
    column: $table.patchLarge,
    builder: (column) => column,
  );

  GeneratedColumn<String> get webcast =>
      $composableBuilder(column: $table.webcast, builder: (column) => column);

  GeneratedColumn<String> get wikipedia =>
      $composableBuilder(column: $table.wikipedia, builder: (column) => column);

  GeneratedColumn<String> get article =>
      $composableBuilder(column: $table.article, builder: (column) => column);

  GeneratedColumn<String> get flickrImages => $composableBuilder(
    column: $table.flickrImages,
    builder: (column) => column,
  );

  GeneratedColumn<String> get rocket =>
      $composableBuilder(column: $table.rocket, builder: (column) => column);

  GeneratedColumn<String> get launchpad =>
      $composableBuilder(column: $table.launchpad, builder: (column) => column);

  GeneratedColumn<String> get rocketName => $composableBuilder(
    column: $table.rocketName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get launchpadName => $composableBuilder(
    column: $table.launchpadName,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get cachedAt =>
      $composableBuilder(column: $table.cachedAt, builder: (column) => column);
}

class $$LaunchesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LaunchesTable,
          Launch,
          $$LaunchesTableFilterComposer,
          $$LaunchesTableOrderingComposer,
          $$LaunchesTableAnnotationComposer,
          $$LaunchesTableCreateCompanionBuilder,
          $$LaunchesTableUpdateCompanionBuilder,
          (Launch, BaseReferences<_$AppDatabase, $LaunchesTable, Launch>),
          Launch,
          PrefetchHooks Function()
        > {
  $$LaunchesTableTableManager(_$AppDatabase db, $LaunchesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LaunchesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LaunchesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LaunchesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int?> success = const Value.absent(),
                Value<int> flightNumber = const Value.absent(),
                Value<String?> details = const Value.absent(),
                Value<String> dateUtc = const Value.absent(),
                Value<String?> patchSmall = const Value.absent(),
                Value<String?> patchLarge = const Value.absent(),
                Value<String?> webcast = const Value.absent(),
                Value<String?> wikipedia = const Value.absent(),
                Value<String?> article = const Value.absent(),
                Value<String> flickrImages = const Value.absent(),
                Value<String?> rocket = const Value.absent(),
                Value<String?> launchpad = const Value.absent(),
                Value<String?> rocketName = const Value.absent(),
                Value<String?> launchpadName = const Value.absent(),
                Value<DateTime> cachedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LaunchesCompanion(
                id: id,
                name: name,
                success: success,
                flightNumber: flightNumber,
                details: details,
                dateUtc: dateUtc,
                patchSmall: patchSmall,
                patchLarge: patchLarge,
                webcast: webcast,
                wikipedia: wikipedia,
                article: article,
                flickrImages: flickrImages,
                rocket: rocket,
                launchpad: launchpad,
                rocketName: rocketName,
                launchpadName: launchpadName,
                cachedAt: cachedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                Value<int?> success = const Value.absent(),
                required int flightNumber,
                Value<String?> details = const Value.absent(),
                required String dateUtc,
                Value<String?> patchSmall = const Value.absent(),
                Value<String?> patchLarge = const Value.absent(),
                Value<String?> webcast = const Value.absent(),
                Value<String?> wikipedia = const Value.absent(),
                Value<String?> article = const Value.absent(),
                Value<String> flickrImages = const Value.absent(),
                Value<String?> rocket = const Value.absent(),
                Value<String?> launchpad = const Value.absent(),
                Value<String?> rocketName = const Value.absent(),
                Value<String?> launchpadName = const Value.absent(),
                Value<DateTime> cachedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LaunchesCompanion.insert(
                id: id,
                name: name,
                success: success,
                flightNumber: flightNumber,
                details: details,
                dateUtc: dateUtc,
                patchSmall: patchSmall,
                patchLarge: patchLarge,
                webcast: webcast,
                wikipedia: wikipedia,
                article: article,
                flickrImages: flickrImages,
                rocket: rocket,
                launchpad: launchpad,
                rocketName: rocketName,
                launchpadName: launchpadName,
                cachedAt: cachedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LaunchesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LaunchesTable,
      Launch,
      $$LaunchesTableFilterComposer,
      $$LaunchesTableOrderingComposer,
      $$LaunchesTableAnnotationComposer,
      $$LaunchesTableCreateCompanionBuilder,
      $$LaunchesTableUpdateCompanionBuilder,
      (Launch, BaseReferences<_$AppDatabase, $LaunchesTable, Launch>),
      Launch,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$LaunchesTableTableManager get launches =>
      $$LaunchesTableTableManager(_db, _db.launches);
}
