// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $UserTable extends User with TableInfo<$UserTable, UserData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _usernameMeta =
      const VerificationMeta('username');
  @override
  late final GeneratedColumn<String> username = GeneratedColumn<String>(
      'username', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _thumbMeta = const VerificationMeta('thumb');
  @override
  late final GeneratedColumn<String> thumb = GeneratedColumn<String>(
      'thumb', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _imageMeta = const VerificationMeta('image');
  @override
  late final GeneratedColumn<String> image = GeneratedColumn<String>(
      'image', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _lastUpdatedMeta =
      const VerificationMeta('lastUpdated');
  @override
  late final GeneratedColumn<DateTime> lastUpdated = GeneratedColumn<DateTime>(
      'last_updated', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, username, thumb, image, lastUpdated];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user';
  @override
  VerificationContext validateIntegrity(Insertable<UserData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('username')) {
      context.handle(_usernameMeta,
          username.isAcceptableOrUnknown(data['username']!, _usernameMeta));
    } else if (isInserting) {
      context.missing(_usernameMeta);
    }
    if (data.containsKey('thumb')) {
      context.handle(
          _thumbMeta, thumb.isAcceptableOrUnknown(data['thumb']!, _thumbMeta));
    } else if (isInserting) {
      context.missing(_thumbMeta);
    }
    if (data.containsKey('image')) {
      context.handle(
          _imageMeta, image.isAcceptableOrUnknown(data['image']!, _imageMeta));
    } else if (isInserting) {
      context.missing(_imageMeta);
    }
    if (data.containsKey('last_updated')) {
      context.handle(
          _lastUpdatedMeta,
          lastUpdated.isAcceptableOrUnknown(
              data['last_updated']!, _lastUpdatedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      username: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}username'])!,
      thumb: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}thumb'])!,
      image: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image'])!,
      lastUpdated: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}last_updated'])!,
    );
  }

  @override
  $UserTable createAlias(String alias) {
    return $UserTable(attachedDatabase, alias);
  }
}

class UserData extends DataClass implements Insertable<UserData> {
  final String id;
  final String name;
  final String username;
  final String thumb;
  final String image;
  final DateTime lastUpdated;
  const UserData(
      {required this.id,
      required this.name,
      required this.username,
      required this.thumb,
      required this.image,
      required this.lastUpdated});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['username'] = Variable<String>(username);
    map['thumb'] = Variable<String>(thumb);
    map['image'] = Variable<String>(image);
    map['last_updated'] = Variable<DateTime>(lastUpdated);
    return map;
  }

  UserCompanion toCompanion(bool nullToAbsent) {
    return UserCompanion(
      id: Value(id),
      name: Value(name),
      username: Value(username),
      thumb: Value(thumb),
      image: Value(image),
      lastUpdated: Value(lastUpdated),
    );
  }

  factory UserData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      username: serializer.fromJson<String>(json['username']),
      thumb: serializer.fromJson<String>(json['thumb']),
      image: serializer.fromJson<String>(json['image']),
      lastUpdated: serializer.fromJson<DateTime>(json['lastUpdated']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'username': serializer.toJson<String>(username),
      'thumb': serializer.toJson<String>(thumb),
      'image': serializer.toJson<String>(image),
      'lastUpdated': serializer.toJson<DateTime>(lastUpdated),
    };
  }

  UserData copyWith(
          {String? id,
          String? name,
          String? username,
          String? thumb,
          String? image,
          DateTime? lastUpdated}) =>
      UserData(
        id: id ?? this.id,
        name: name ?? this.name,
        username: username ?? this.username,
        thumb: thumb ?? this.thumb,
        image: image ?? this.image,
        lastUpdated: lastUpdated ?? this.lastUpdated,
      );
  UserData copyWithCompanion(UserCompanion data) {
    return UserData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      username: data.username.present ? data.username.value : this.username,
      thumb: data.thumb.present ? data.thumb.value : this.thumb,
      image: data.image.present ? data.image.value : this.image,
      lastUpdated:
          data.lastUpdated.present ? data.lastUpdated.value : this.lastUpdated,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('username: $username, ')
          ..write('thumb: $thumb, ')
          ..write('image: $image, ')
          ..write('lastUpdated: $lastUpdated')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, username, thumb, image, lastUpdated);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserData &&
          other.id == this.id &&
          other.name == this.name &&
          other.username == this.username &&
          other.thumb == this.thumb &&
          other.image == this.image &&
          other.lastUpdated == this.lastUpdated);
}

class UserCompanion extends UpdateCompanion<UserData> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> username;
  final Value<String> thumb;
  final Value<String> image;
  final Value<DateTime> lastUpdated;
  final Value<int> rowid;
  const UserCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.username = const Value.absent(),
    this.thumb = const Value.absent(),
    this.image = const Value.absent(),
    this.lastUpdated = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UserCompanion.insert({
    required String id,
    required String name,
    required String username,
    required String thumb,
    required String image,
    this.lastUpdated = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        username = Value(username),
        thumb = Value(thumb),
        image = Value(image);
  static Insertable<UserData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? username,
    Expression<String>? thumb,
    Expression<String>? image,
    Expression<DateTime>? lastUpdated,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (username != null) 'username': username,
      if (thumb != null) 'thumb': thumb,
      if (image != null) 'image': image,
      if (lastUpdated != null) 'last_updated': lastUpdated,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UserCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String>? username,
      Value<String>? thumb,
      Value<String>? image,
      Value<DateTime>? lastUpdated,
      Value<int>? rowid}) {
    return UserCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      username: username ?? this.username,
      thumb: thumb ?? this.thumb,
      image: image ?? this.image,
      lastUpdated: lastUpdated ?? this.lastUpdated,
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
    if (username.present) {
      map['username'] = Variable<String>(username.value);
    }
    if (thumb.present) {
      map['thumb'] = Variable<String>(thumb.value);
    }
    if (image.present) {
      map['image'] = Variable<String>(image.value);
    }
    if (lastUpdated.present) {
      map['last_updated'] = Variable<DateTime>(lastUpdated.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('username: $username, ')
          ..write('thumb: $thumb, ')
          ..write('image: $image, ')
          ..write('lastUpdated: $lastUpdated, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FriendshipTable extends Friendship
    with TableInfo<$FriendshipTable, FriendshipData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FriendshipTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _userMeta = const VerificationMeta('user');
  @override
  late final GeneratedColumn<String> user = GeneratedColumn<String>(
      'user', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES user (id)'));
  @override
  late final GeneratedColumnWithTypeConverter<FriendshipStatus, int> status =
      GeneratedColumn<int>('status', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<FriendshipStatus>($FriendshipTable.$converterstatus);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _lastUpdatedMeta =
      const VerificationMeta('lastUpdated');
  @override
  late final GeneratedColumn<DateTime> lastUpdated = GeneratedColumn<DateTime>(
      'last_updated', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, user, status, createdAt, lastUpdated];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'friendship';
  @override
  VerificationContext validateIntegrity(Insertable<FriendshipData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user')) {
      context.handle(
          _userMeta, user.isAcceptableOrUnknown(data['user']!, _userMeta));
    } else if (isInserting) {
      context.missing(_userMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('last_updated')) {
      context.handle(
          _lastUpdatedMeta,
          lastUpdated.isAcceptableOrUnknown(
              data['last_updated']!, _lastUpdatedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FriendshipData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FriendshipData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      user: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user'])!,
      status: $FriendshipTable.$converterstatus.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}status'])!),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      lastUpdated: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}last_updated'])!,
    );
  }

  @override
  $FriendshipTable createAlias(String alias) {
    return $FriendshipTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<FriendshipStatus, int, int> $converterstatus =
      const EnumIndexConverter<FriendshipStatus>(FriendshipStatus.values);
}

class FriendshipData extends DataClass implements Insertable<FriendshipData> {
  final String id;
  final String user;
  final FriendshipStatus status;
  final DateTime createdAt;
  final DateTime lastUpdated;
  const FriendshipData(
      {required this.id,
      required this.user,
      required this.status,
      required this.createdAt,
      required this.lastUpdated});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user'] = Variable<String>(user);
    {
      map['status'] =
          Variable<int>($FriendshipTable.$converterstatus.toSql(status));
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['last_updated'] = Variable<DateTime>(lastUpdated);
    return map;
  }

  FriendshipCompanion toCompanion(bool nullToAbsent) {
    return FriendshipCompanion(
      id: Value(id),
      user: Value(user),
      status: Value(status),
      createdAt: Value(createdAt),
      lastUpdated: Value(lastUpdated),
    );
  }

  factory FriendshipData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FriendshipData(
      id: serializer.fromJson<String>(json['id']),
      user: serializer.fromJson<String>(json['user']),
      status: $FriendshipTable.$converterstatus
          .fromJson(serializer.fromJson<int>(json['status'])),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      lastUpdated: serializer.fromJson<DateTime>(json['lastUpdated']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'user': serializer.toJson<String>(user),
      'status': serializer
          .toJson<int>($FriendshipTable.$converterstatus.toJson(status)),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'lastUpdated': serializer.toJson<DateTime>(lastUpdated),
    };
  }

  FriendshipData copyWith(
          {String? id,
          String? user,
          FriendshipStatus? status,
          DateTime? createdAt,
          DateTime? lastUpdated}) =>
      FriendshipData(
        id: id ?? this.id,
        user: user ?? this.user,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        lastUpdated: lastUpdated ?? this.lastUpdated,
      );
  FriendshipData copyWithCompanion(FriendshipCompanion data) {
    return FriendshipData(
      id: data.id.present ? data.id.value : this.id,
      user: data.user.present ? data.user.value : this.user,
      status: data.status.present ? data.status.value : this.status,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      lastUpdated:
          data.lastUpdated.present ? data.lastUpdated.value : this.lastUpdated,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FriendshipData(')
          ..write('id: $id, ')
          ..write('user: $user, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastUpdated: $lastUpdated')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, user, status, createdAt, lastUpdated);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FriendshipData &&
          other.id == this.id &&
          other.user == this.user &&
          other.status == this.status &&
          other.createdAt == this.createdAt &&
          other.lastUpdated == this.lastUpdated);
}

class FriendshipCompanion extends UpdateCompanion<FriendshipData> {
  final Value<String> id;
  final Value<String> user;
  final Value<FriendshipStatus> status;
  final Value<DateTime> createdAt;
  final Value<DateTime> lastUpdated;
  final Value<int> rowid;
  const FriendshipCompanion({
    this.id = const Value.absent(),
    this.user = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.lastUpdated = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FriendshipCompanion.insert({
    required String id,
    required String user,
    required FriendshipStatus status,
    required DateTime createdAt,
    this.lastUpdated = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        user = Value(user),
        status = Value(status),
        createdAt = Value(createdAt);
  static Insertable<FriendshipData> custom({
    Expression<String>? id,
    Expression<String>? user,
    Expression<int>? status,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? lastUpdated,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (user != null) 'user': user,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
      if (lastUpdated != null) 'last_updated': lastUpdated,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FriendshipCompanion copyWith(
      {Value<String>? id,
      Value<String>? user,
      Value<FriendshipStatus>? status,
      Value<DateTime>? createdAt,
      Value<DateTime>? lastUpdated,
      Value<int>? rowid}) {
    return FriendshipCompanion(
      id: id ?? this.id,
      user: user ?? this.user,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (user.present) {
      map['user'] = Variable<String>(user.value);
    }
    if (status.present) {
      map['status'] =
          Variable<int>($FriendshipTable.$converterstatus.toSql(status.value));
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (lastUpdated.present) {
      map['last_updated'] = Variable<DateTime>(lastUpdated.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FriendshipCompanion(')
          ..write('id: $id, ')
          ..write('user: $user, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastUpdated: $lastUpdated, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $GameTable extends Game with TableInfo<$GameTable, GameData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GameTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _slugMeta = const VerificationMeta('slug');
  @override
  late final GeneratedColumn<String> slug = GeneratedColumn<String>(
      'slug', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _apiIdMeta = const VerificationMeta('apiId');
  @override
  late final GeneratedColumn<int> apiId = GeneratedColumn<int>(
      'api_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  @override
  late final GeneratedColumnWithTypeConverter<List<PlatformId>, String>
      platforms = GeneratedColumn<String>('platforms', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<List<PlatformId>>($GameTable.$converterplatforms);
  static const VerificationMeta _backgroundMeta =
      const VerificationMeta('background');
  @override
  late final GeneratedColumn<String> background = GeneratedColumn<String>(
      'background', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  late final GeneratedColumnWithTypeConverter<List<String>, String>
      screenshots = GeneratedColumn<String>('screenshots', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<List<String>>($GameTable.$converterscreenshots);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _lastUpdatedMeta =
      const VerificationMeta('lastUpdated');
  @override
  late final GeneratedColumn<DateTime> lastUpdated = GeneratedColumn<DateTime>(
      'last_updated', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        slug,
        apiId,
        platforms,
        background,
        screenshots,
        description,
        lastUpdated
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'game';
  @override
  VerificationContext validateIntegrity(Insertable<GameData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('slug')) {
      context.handle(
          _slugMeta, slug.isAcceptableOrUnknown(data['slug']!, _slugMeta));
    } else if (isInserting) {
      context.missing(_slugMeta);
    }
    if (data.containsKey('api_id')) {
      context.handle(
          _apiIdMeta, apiId.isAcceptableOrUnknown(data['api_id']!, _apiIdMeta));
    } else if (isInserting) {
      context.missing(_apiIdMeta);
    }
    if (data.containsKey('background')) {
      context.handle(
          _backgroundMeta,
          background.isAcceptableOrUnknown(
              data['background']!, _backgroundMeta));
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('last_updated')) {
      context.handle(
          _lastUpdatedMeta,
          lastUpdated.isAcceptableOrUnknown(
              data['last_updated']!, _lastUpdatedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GameData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GameData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      slug: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}slug'])!,
      apiId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}api_id'])!,
      platforms: $GameTable.$converterplatforms.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}platforms'])!),
      background: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}background']),
      screenshots: $GameTable.$converterscreenshots.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}screenshots'])!),
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      lastUpdated: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}last_updated'])!,
    );
  }

  @override
  $GameTable createAlias(String alias) {
    return $GameTable(attachedDatabase, alias);
  }

  static TypeConverter<List<PlatformId>, String> $converterplatforms =
      const PlatformListConverter();
  static TypeConverter<List<String>, String> $converterscreenshots =
      const StringListConverter();
}

class GameData extends DataClass implements Insertable<GameData> {
  final String id;
  final String name;
  final String slug;
  final int apiId;
  final List<PlatformId> platforms;
  final String? background;
  final List<String> screenshots;
  final String description;
  final DateTime lastUpdated;
  const GameData(
      {required this.id,
      required this.name,
      required this.slug,
      required this.apiId,
      required this.platforms,
      this.background,
      required this.screenshots,
      required this.description,
      required this.lastUpdated});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['slug'] = Variable<String>(slug);
    map['api_id'] = Variable<int>(apiId);
    {
      map['platforms'] =
          Variable<String>($GameTable.$converterplatforms.toSql(platforms));
    }
    if (!nullToAbsent || background != null) {
      map['background'] = Variable<String>(background);
    }
    {
      map['screenshots'] =
          Variable<String>($GameTable.$converterscreenshots.toSql(screenshots));
    }
    map['description'] = Variable<String>(description);
    map['last_updated'] = Variable<DateTime>(lastUpdated);
    return map;
  }

  GameCompanion toCompanion(bool nullToAbsent) {
    return GameCompanion(
      id: Value(id),
      name: Value(name),
      slug: Value(slug),
      apiId: Value(apiId),
      platforms: Value(platforms),
      background: background == null && nullToAbsent
          ? const Value.absent()
          : Value(background),
      screenshots: Value(screenshots),
      description: Value(description),
      lastUpdated: Value(lastUpdated),
    );
  }

  factory GameData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GameData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      slug: serializer.fromJson<String>(json['slug']),
      apiId: serializer.fromJson<int>(json['apiId']),
      platforms: serializer.fromJson<List<PlatformId>>(json['platforms']),
      background: serializer.fromJson<String?>(json['background']),
      screenshots: serializer.fromJson<List<String>>(json['screenshots']),
      description: serializer.fromJson<String>(json['description']),
      lastUpdated: serializer.fromJson<DateTime>(json['lastUpdated']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'slug': serializer.toJson<String>(slug),
      'apiId': serializer.toJson<int>(apiId),
      'platforms': serializer.toJson<List<PlatformId>>(platforms),
      'background': serializer.toJson<String?>(background),
      'screenshots': serializer.toJson<List<String>>(screenshots),
      'description': serializer.toJson<String>(description),
      'lastUpdated': serializer.toJson<DateTime>(lastUpdated),
    };
  }

  GameData copyWith(
          {String? id,
          String? name,
          String? slug,
          int? apiId,
          List<PlatformId>? platforms,
          Value<String?> background = const Value.absent(),
          List<String>? screenshots,
          String? description,
          DateTime? lastUpdated}) =>
      GameData(
        id: id ?? this.id,
        name: name ?? this.name,
        slug: slug ?? this.slug,
        apiId: apiId ?? this.apiId,
        platforms: platforms ?? this.platforms,
        background: background.present ? background.value : this.background,
        screenshots: screenshots ?? this.screenshots,
        description: description ?? this.description,
        lastUpdated: lastUpdated ?? this.lastUpdated,
      );
  GameData copyWithCompanion(GameCompanion data) {
    return GameData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      slug: data.slug.present ? data.slug.value : this.slug,
      apiId: data.apiId.present ? data.apiId.value : this.apiId,
      platforms: data.platforms.present ? data.platforms.value : this.platforms,
      background:
          data.background.present ? data.background.value : this.background,
      screenshots:
          data.screenshots.present ? data.screenshots.value : this.screenshots,
      description:
          data.description.present ? data.description.value : this.description,
      lastUpdated:
          data.lastUpdated.present ? data.lastUpdated.value : this.lastUpdated,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GameData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('slug: $slug, ')
          ..write('apiId: $apiId, ')
          ..write('platforms: $platforms, ')
          ..write('background: $background, ')
          ..write('screenshots: $screenshots, ')
          ..write('description: $description, ')
          ..write('lastUpdated: $lastUpdated')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, slug, apiId, platforms, background,
      screenshots, description, lastUpdated);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GameData &&
          other.id == this.id &&
          other.name == this.name &&
          other.slug == this.slug &&
          other.apiId == this.apiId &&
          other.platforms == this.platforms &&
          other.background == this.background &&
          other.screenshots == this.screenshots &&
          other.description == this.description &&
          other.lastUpdated == this.lastUpdated);
}

class GameCompanion extends UpdateCompanion<GameData> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> slug;
  final Value<int> apiId;
  final Value<List<PlatformId>> platforms;
  final Value<String?> background;
  final Value<List<String>> screenshots;
  final Value<String> description;
  final Value<DateTime> lastUpdated;
  final Value<int> rowid;
  const GameCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.slug = const Value.absent(),
    this.apiId = const Value.absent(),
    this.platforms = const Value.absent(),
    this.background = const Value.absent(),
    this.screenshots = const Value.absent(),
    this.description = const Value.absent(),
    this.lastUpdated = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  GameCompanion.insert({
    required String id,
    required String name,
    required String slug,
    required int apiId,
    required List<PlatformId> platforms,
    this.background = const Value.absent(),
    required List<String> screenshots,
    required String description,
    this.lastUpdated = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        slug = Value(slug),
        apiId = Value(apiId),
        platforms = Value(platforms),
        screenshots = Value(screenshots),
        description = Value(description);
  static Insertable<GameData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? slug,
    Expression<int>? apiId,
    Expression<String>? platforms,
    Expression<String>? background,
    Expression<String>? screenshots,
    Expression<String>? description,
    Expression<DateTime>? lastUpdated,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (slug != null) 'slug': slug,
      if (apiId != null) 'api_id': apiId,
      if (platforms != null) 'platforms': platforms,
      if (background != null) 'background': background,
      if (screenshots != null) 'screenshots': screenshots,
      if (description != null) 'description': description,
      if (lastUpdated != null) 'last_updated': lastUpdated,
      if (rowid != null) 'rowid': rowid,
    });
  }

  GameCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String>? slug,
      Value<int>? apiId,
      Value<List<PlatformId>>? platforms,
      Value<String?>? background,
      Value<List<String>>? screenshots,
      Value<String>? description,
      Value<DateTime>? lastUpdated,
      Value<int>? rowid}) {
    return GameCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      apiId: apiId ?? this.apiId,
      platforms: platforms ?? this.platforms,
      background: background ?? this.background,
      screenshots: screenshots ?? this.screenshots,
      description: description ?? this.description,
      lastUpdated: lastUpdated ?? this.lastUpdated,
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
    if (slug.present) {
      map['slug'] = Variable<String>(slug.value);
    }
    if (apiId.present) {
      map['api_id'] = Variable<int>(apiId.value);
    }
    if (platforms.present) {
      map['platforms'] = Variable<String>(
          $GameTable.$converterplatforms.toSql(platforms.value));
    }
    if (background.present) {
      map['background'] = Variable<String>(background.value);
    }
    if (screenshots.present) {
      map['screenshots'] = Variable<String>(
          $GameTable.$converterscreenshots.toSql(screenshots.value));
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (lastUpdated.present) {
      map['last_updated'] = Variable<DateTime>(lastUpdated.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GameCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('slug: $slug, ')
          ..write('apiId: $apiId, ')
          ..write('platforms: $platforms, ')
          ..write('background: $background, ')
          ..write('screenshots: $screenshots, ')
          ..write('description: $description, ')
          ..write('lastUpdated: $lastUpdated, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MatchTable extends Match with TableInfo<$MatchTable, MatchData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MatchTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _gameMeta = const VerificationMeta('game');
  @override
  late final GeneratedColumn<String> game = GeneratedColumn<String>(
      'game', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES game (id)'));
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  late final GeneratedColumnWithTypeConverter<PlatformId, int> platform =
      GeneratedColumn<int>('platform', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<PlatformId>($MatchTable.$converterplatform);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _userMeta = const VerificationMeta('user');
  @override
  late final GeneratedColumn<String> user = GeneratedColumn<String>(
      'user', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES user (id)'));
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _durationMeta =
      const VerificationMeta('duration');
  @override
  late final GeneratedColumn<int> duration = GeneratedColumn<int>(
      'duration', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _privateMeta =
      const VerificationMeta('private');
  @override
  late final GeneratedColumn<bool> private = GeneratedColumn<bool>(
      'private', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("private" IN (0, 1))'));
  static const VerificationMeta _tournamentMeta =
      const VerificationMeta('tournament');
  @override
  late final GeneratedColumn<String> tournament = GeneratedColumn<String>(
      'tournament', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  late final GeneratedColumnWithTypeConverter<MatchStatus, int> status =
      GeneratedColumn<int>('status', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<MatchStatus>($MatchTable.$converterstatus);
  @override
  late final GeneratedColumnWithTypeConverter<List<String>, String> joined =
      GeneratedColumn<String>('joined', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<List<String>>($MatchTable.$converterjoined);
  @override
  late final GeneratedColumnWithTypeConverter<List<String>, String> inviteds =
      GeneratedColumn<String>('inviteds', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<List<String>>($MatchTable.$converterinviteds);
  static const VerificationMeta _lastUpdatedMeta =
      const VerificationMeta('lastUpdated');
  @override
  late final GeneratedColumn<DateTime> lastUpdated = GeneratedColumn<DateTime>(
      'last_updated', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        game,
        title,
        platform,
        date,
        user,
        description,
        duration,
        private,
        tournament,
        status,
        joined,
        inviteds,
        lastUpdated
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'match';
  @override
  VerificationContext validateIntegrity(Insertable<MatchData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('game')) {
      context.handle(
          _gameMeta, game.isAcceptableOrUnknown(data['game']!, _gameMeta));
    } else if (isInserting) {
      context.missing(_gameMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('user')) {
      context.handle(
          _userMeta, user.isAcceptableOrUnknown(data['user']!, _userMeta));
    } else if (isInserting) {
      context.missing(_userMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('duration')) {
      context.handle(_durationMeta,
          duration.isAcceptableOrUnknown(data['duration']!, _durationMeta));
    } else if (isInserting) {
      context.missing(_durationMeta);
    }
    if (data.containsKey('private')) {
      context.handle(_privateMeta,
          private.isAcceptableOrUnknown(data['private']!, _privateMeta));
    } else if (isInserting) {
      context.missing(_privateMeta);
    }
    if (data.containsKey('tournament')) {
      context.handle(
          _tournamentMeta,
          tournament.isAcceptableOrUnknown(
              data['tournament']!, _tournamentMeta));
    }
    if (data.containsKey('last_updated')) {
      context.handle(
          _lastUpdatedMeta,
          lastUpdated.isAcceptableOrUnknown(
              data['last_updated']!, _lastUpdatedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MatchData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MatchData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      game: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}game'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      platform: $MatchTable.$converterplatform.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}platform'])!),
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      user: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      duration: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}duration'])!,
      private: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}private'])!,
      tournament: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tournament']),
      status: $MatchTable.$converterstatus.fromSql(attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}status'])!),
      joined: $MatchTable.$converterjoined.fromSql(attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}joined'])!),
      inviteds: $MatchTable.$converterinviteds.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}inviteds'])!),
      lastUpdated: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}last_updated'])!,
    );
  }

  @override
  $MatchTable createAlias(String alias) {
    return $MatchTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<PlatformId, int, int> $converterplatform =
      const EnumIndexConverter<PlatformId>(PlatformId.values);
  static JsonTypeConverter2<MatchStatus, int, int> $converterstatus =
      const EnumIndexConverter<MatchStatus>(MatchStatus.values);
  static TypeConverter<List<String>, String> $converterjoined =
      const StringListConverter();
  static TypeConverter<List<String>, String> $converterinviteds =
      const StringListConverter();
}

class MatchData extends DataClass implements Insertable<MatchData> {
  final String id;
  final String game;
  final String title;
  final PlatformId platform;
  final DateTime date;
  final String user;
  final String description;
  final int duration;
  final bool private;
  final String? tournament;
  final MatchStatus status;
  final List<String> joined;
  final List<String> inviteds;
  final DateTime lastUpdated;
  const MatchData(
      {required this.id,
      required this.game,
      required this.title,
      required this.platform,
      required this.date,
      required this.user,
      required this.description,
      required this.duration,
      required this.private,
      this.tournament,
      required this.status,
      required this.joined,
      required this.inviteds,
      required this.lastUpdated});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['game'] = Variable<String>(game);
    map['title'] = Variable<String>(title);
    {
      map['platform'] =
          Variable<int>($MatchTable.$converterplatform.toSql(platform));
    }
    map['date'] = Variable<DateTime>(date);
    map['user'] = Variable<String>(user);
    map['description'] = Variable<String>(description);
    map['duration'] = Variable<int>(duration);
    map['private'] = Variable<bool>(private);
    if (!nullToAbsent || tournament != null) {
      map['tournament'] = Variable<String>(tournament);
    }
    {
      map['status'] = Variable<int>($MatchTable.$converterstatus.toSql(status));
    }
    {
      map['joined'] =
          Variable<String>($MatchTable.$converterjoined.toSql(joined));
    }
    {
      map['inviteds'] =
          Variable<String>($MatchTable.$converterinviteds.toSql(inviteds));
    }
    map['last_updated'] = Variable<DateTime>(lastUpdated);
    return map;
  }

  MatchCompanion toCompanion(bool nullToAbsent) {
    return MatchCompanion(
      id: Value(id),
      game: Value(game),
      title: Value(title),
      platform: Value(platform),
      date: Value(date),
      user: Value(user),
      description: Value(description),
      duration: Value(duration),
      private: Value(private),
      tournament: tournament == null && nullToAbsent
          ? const Value.absent()
          : Value(tournament),
      status: Value(status),
      joined: Value(joined),
      inviteds: Value(inviteds),
      lastUpdated: Value(lastUpdated),
    );
  }

  factory MatchData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MatchData(
      id: serializer.fromJson<String>(json['id']),
      game: serializer.fromJson<String>(json['game']),
      title: serializer.fromJson<String>(json['title']),
      platform: $MatchTable.$converterplatform
          .fromJson(serializer.fromJson<int>(json['platform'])),
      date: serializer.fromJson<DateTime>(json['date']),
      user: serializer.fromJson<String>(json['user']),
      description: serializer.fromJson<String>(json['description']),
      duration: serializer.fromJson<int>(json['duration']),
      private: serializer.fromJson<bool>(json['private']),
      tournament: serializer.fromJson<String?>(json['tournament']),
      status: $MatchTable.$converterstatus
          .fromJson(serializer.fromJson<int>(json['status'])),
      joined: serializer.fromJson<List<String>>(json['joined']),
      inviteds: serializer.fromJson<List<String>>(json['inviteds']),
      lastUpdated: serializer.fromJson<DateTime>(json['lastUpdated']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'game': serializer.toJson<String>(game),
      'title': serializer.toJson<String>(title),
      'platform': serializer
          .toJson<int>($MatchTable.$converterplatform.toJson(platform)),
      'date': serializer.toJson<DateTime>(date),
      'user': serializer.toJson<String>(user),
      'description': serializer.toJson<String>(description),
      'duration': serializer.toJson<int>(duration),
      'private': serializer.toJson<bool>(private),
      'tournament': serializer.toJson<String?>(tournament),
      'status':
          serializer.toJson<int>($MatchTable.$converterstatus.toJson(status)),
      'joined': serializer.toJson<List<String>>(joined),
      'inviteds': serializer.toJson<List<String>>(inviteds),
      'lastUpdated': serializer.toJson<DateTime>(lastUpdated),
    };
  }

  MatchData copyWith(
          {String? id,
          String? game,
          String? title,
          PlatformId? platform,
          DateTime? date,
          String? user,
          String? description,
          int? duration,
          bool? private,
          Value<String?> tournament = const Value.absent(),
          MatchStatus? status,
          List<String>? joined,
          List<String>? inviteds,
          DateTime? lastUpdated}) =>
      MatchData(
        id: id ?? this.id,
        game: game ?? this.game,
        title: title ?? this.title,
        platform: platform ?? this.platform,
        date: date ?? this.date,
        user: user ?? this.user,
        description: description ?? this.description,
        duration: duration ?? this.duration,
        private: private ?? this.private,
        tournament: tournament.present ? tournament.value : this.tournament,
        status: status ?? this.status,
        joined: joined ?? this.joined,
        inviteds: inviteds ?? this.inviteds,
        lastUpdated: lastUpdated ?? this.lastUpdated,
      );
  MatchData copyWithCompanion(MatchCompanion data) {
    return MatchData(
      id: data.id.present ? data.id.value : this.id,
      game: data.game.present ? data.game.value : this.game,
      title: data.title.present ? data.title.value : this.title,
      platform: data.platform.present ? data.platform.value : this.platform,
      date: data.date.present ? data.date.value : this.date,
      user: data.user.present ? data.user.value : this.user,
      description:
          data.description.present ? data.description.value : this.description,
      duration: data.duration.present ? data.duration.value : this.duration,
      private: data.private.present ? data.private.value : this.private,
      tournament:
          data.tournament.present ? data.tournament.value : this.tournament,
      status: data.status.present ? data.status.value : this.status,
      joined: data.joined.present ? data.joined.value : this.joined,
      inviteds: data.inviteds.present ? data.inviteds.value : this.inviteds,
      lastUpdated:
          data.lastUpdated.present ? data.lastUpdated.value : this.lastUpdated,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MatchData(')
          ..write('id: $id, ')
          ..write('game: $game, ')
          ..write('title: $title, ')
          ..write('platform: $platform, ')
          ..write('date: $date, ')
          ..write('user: $user, ')
          ..write('description: $description, ')
          ..write('duration: $duration, ')
          ..write('private: $private, ')
          ..write('tournament: $tournament, ')
          ..write('status: $status, ')
          ..write('joined: $joined, ')
          ..write('inviteds: $inviteds, ')
          ..write('lastUpdated: $lastUpdated')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      game,
      title,
      platform,
      date,
      user,
      description,
      duration,
      private,
      tournament,
      status,
      joined,
      inviteds,
      lastUpdated);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MatchData &&
          other.id == this.id &&
          other.game == this.game &&
          other.title == this.title &&
          other.platform == this.platform &&
          other.date == this.date &&
          other.user == this.user &&
          other.description == this.description &&
          other.duration == this.duration &&
          other.private == this.private &&
          other.tournament == this.tournament &&
          other.status == this.status &&
          other.joined == this.joined &&
          other.inviteds == this.inviteds &&
          other.lastUpdated == this.lastUpdated);
}

class MatchCompanion extends UpdateCompanion<MatchData> {
  final Value<String> id;
  final Value<String> game;
  final Value<String> title;
  final Value<PlatformId> platform;
  final Value<DateTime> date;
  final Value<String> user;
  final Value<String> description;
  final Value<int> duration;
  final Value<bool> private;
  final Value<String?> tournament;
  final Value<MatchStatus> status;
  final Value<List<String>> joined;
  final Value<List<String>> inviteds;
  final Value<DateTime> lastUpdated;
  final Value<int> rowid;
  const MatchCompanion({
    this.id = const Value.absent(),
    this.game = const Value.absent(),
    this.title = const Value.absent(),
    this.platform = const Value.absent(),
    this.date = const Value.absent(),
    this.user = const Value.absent(),
    this.description = const Value.absent(),
    this.duration = const Value.absent(),
    this.private = const Value.absent(),
    this.tournament = const Value.absent(),
    this.status = const Value.absent(),
    this.joined = const Value.absent(),
    this.inviteds = const Value.absent(),
    this.lastUpdated = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MatchCompanion.insert({
    required String id,
    required String game,
    required String title,
    required PlatformId platform,
    required DateTime date,
    required String user,
    required String description,
    required int duration,
    required bool private,
    this.tournament = const Value.absent(),
    required MatchStatus status,
    required List<String> joined,
    required List<String> inviteds,
    this.lastUpdated = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        game = Value(game),
        title = Value(title),
        platform = Value(platform),
        date = Value(date),
        user = Value(user),
        description = Value(description),
        duration = Value(duration),
        private = Value(private),
        status = Value(status),
        joined = Value(joined),
        inviteds = Value(inviteds);
  static Insertable<MatchData> custom({
    Expression<String>? id,
    Expression<String>? game,
    Expression<String>? title,
    Expression<int>? platform,
    Expression<DateTime>? date,
    Expression<String>? user,
    Expression<String>? description,
    Expression<int>? duration,
    Expression<bool>? private,
    Expression<String>? tournament,
    Expression<int>? status,
    Expression<String>? joined,
    Expression<String>? inviteds,
    Expression<DateTime>? lastUpdated,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (game != null) 'game': game,
      if (title != null) 'title': title,
      if (platform != null) 'platform': platform,
      if (date != null) 'date': date,
      if (user != null) 'user': user,
      if (description != null) 'description': description,
      if (duration != null) 'duration': duration,
      if (private != null) 'private': private,
      if (tournament != null) 'tournament': tournament,
      if (status != null) 'status': status,
      if (joined != null) 'joined': joined,
      if (inviteds != null) 'inviteds': inviteds,
      if (lastUpdated != null) 'last_updated': lastUpdated,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MatchCompanion copyWith(
      {Value<String>? id,
      Value<String>? game,
      Value<String>? title,
      Value<PlatformId>? platform,
      Value<DateTime>? date,
      Value<String>? user,
      Value<String>? description,
      Value<int>? duration,
      Value<bool>? private,
      Value<String?>? tournament,
      Value<MatchStatus>? status,
      Value<List<String>>? joined,
      Value<List<String>>? inviteds,
      Value<DateTime>? lastUpdated,
      Value<int>? rowid}) {
    return MatchCompanion(
      id: id ?? this.id,
      game: game ?? this.game,
      title: title ?? this.title,
      platform: platform ?? this.platform,
      date: date ?? this.date,
      user: user ?? this.user,
      description: description ?? this.description,
      duration: duration ?? this.duration,
      private: private ?? this.private,
      tournament: tournament ?? this.tournament,
      status: status ?? this.status,
      joined: joined ?? this.joined,
      inviteds: inviteds ?? this.inviteds,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (game.present) {
      map['game'] = Variable<String>(game.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (platform.present) {
      map['platform'] =
          Variable<int>($MatchTable.$converterplatform.toSql(platform.value));
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (user.present) {
      map['user'] = Variable<String>(user.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (duration.present) {
      map['duration'] = Variable<int>(duration.value);
    }
    if (private.present) {
      map['private'] = Variable<bool>(private.value);
    }
    if (tournament.present) {
      map['tournament'] = Variable<String>(tournament.value);
    }
    if (status.present) {
      map['status'] =
          Variable<int>($MatchTable.$converterstatus.toSql(status.value));
    }
    if (joined.present) {
      map['joined'] =
          Variable<String>($MatchTable.$converterjoined.toSql(joined.value));
    }
    if (inviteds.present) {
      map['inviteds'] = Variable<String>(
          $MatchTable.$converterinviteds.toSql(inviteds.value));
    }
    if (lastUpdated.present) {
      map['last_updated'] = Variable<DateTime>(lastUpdated.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MatchCompanion(')
          ..write('id: $id, ')
          ..write('game: $game, ')
          ..write('title: $title, ')
          ..write('platform: $platform, ')
          ..write('date: $date, ')
          ..write('user: $user, ')
          ..write('description: $description, ')
          ..write('duration: $duration, ')
          ..write('private: $private, ')
          ..write('tournament: $tournament, ')
          ..write('status: $status, ')
          ..write('joined: $joined, ')
          ..write('inviteds: $inviteds, ')
          ..write('lastUpdated: $lastUpdated, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ConversationTable extends Conversation
    with TableInfo<$ConversationTable, ConversationData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ConversationTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _conversationIdMeta =
      const VerificationMeta('conversationId');
  @override
  late final GeneratedColumn<String> conversationId = GeneratedColumn<String>(
      'conversation_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _hasReachedEndMeta =
      const VerificationMeta('hasReachedEnd');
  @override
  late final GeneratedColumn<bool> hasReachedEnd = GeneratedColumn<bool>(
      'has_reached_end', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("has_reached_end" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [conversationId, hasReachedEnd];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'conversation';
  @override
  VerificationContext validateIntegrity(Insertable<ConversationData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('conversation_id')) {
      context.handle(
          _conversationIdMeta,
          conversationId.isAcceptableOrUnknown(
              data['conversation_id']!, _conversationIdMeta));
    } else if (isInserting) {
      context.missing(_conversationIdMeta);
    }
    if (data.containsKey('has_reached_end')) {
      context.handle(
          _hasReachedEndMeta,
          hasReachedEnd.isAcceptableOrUnknown(
              data['has_reached_end']!, _hasReachedEndMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {conversationId};
  @override
  ConversationData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ConversationData(
      conversationId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}conversation_id'])!,
      hasReachedEnd: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}has_reached_end'])!,
    );
  }

  @override
  $ConversationTable createAlias(String alias) {
    return $ConversationTable(attachedDatabase, alias);
  }
}

class ConversationData extends DataClass
    implements Insertable<ConversationData> {
  final String conversationId;
  final bool hasReachedEnd;
  const ConversationData(
      {required this.conversationId, required this.hasReachedEnd});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['conversation_id'] = Variable<String>(conversationId);
    map['has_reached_end'] = Variable<bool>(hasReachedEnd);
    return map;
  }

  ConversationCompanion toCompanion(bool nullToAbsent) {
    return ConversationCompanion(
      conversationId: Value(conversationId),
      hasReachedEnd: Value(hasReachedEnd),
    );
  }

  factory ConversationData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ConversationData(
      conversationId: serializer.fromJson<String>(json['conversationId']),
      hasReachedEnd: serializer.fromJson<bool>(json['hasReachedEnd']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'conversationId': serializer.toJson<String>(conversationId),
      'hasReachedEnd': serializer.toJson<bool>(hasReachedEnd),
    };
  }

  ConversationData copyWith({String? conversationId, bool? hasReachedEnd}) =>
      ConversationData(
        conversationId: conversationId ?? this.conversationId,
        hasReachedEnd: hasReachedEnd ?? this.hasReachedEnd,
      );
  ConversationData copyWithCompanion(ConversationCompanion data) {
    return ConversationData(
      conversationId: data.conversationId.present
          ? data.conversationId.value
          : this.conversationId,
      hasReachedEnd: data.hasReachedEnd.present
          ? data.hasReachedEnd.value
          : this.hasReachedEnd,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ConversationData(')
          ..write('conversationId: $conversationId, ')
          ..write('hasReachedEnd: $hasReachedEnd')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(conversationId, hasReachedEnd);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ConversationData &&
          other.conversationId == this.conversationId &&
          other.hasReachedEnd == this.hasReachedEnd);
}

class ConversationCompanion extends UpdateCompanion<ConversationData> {
  final Value<String> conversationId;
  final Value<bool> hasReachedEnd;
  final Value<int> rowid;
  const ConversationCompanion({
    this.conversationId = const Value.absent(),
    this.hasReachedEnd = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ConversationCompanion.insert({
    required String conversationId,
    this.hasReachedEnd = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : conversationId = Value(conversationId);
  static Insertable<ConversationData> custom({
    Expression<String>? conversationId,
    Expression<bool>? hasReachedEnd,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (conversationId != null) 'conversation_id': conversationId,
      if (hasReachedEnd != null) 'has_reached_end': hasReachedEnd,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ConversationCompanion copyWith(
      {Value<String>? conversationId,
      Value<bool>? hasReachedEnd,
      Value<int>? rowid}) {
    return ConversationCompanion(
      conversationId: conversationId ?? this.conversationId,
      hasReachedEnd: hasReachedEnd ?? this.hasReachedEnd,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (conversationId.present) {
      map['conversation_id'] = Variable<String>(conversationId.value);
    }
    if (hasReachedEnd.present) {
      map['has_reached_end'] = Variable<bool>(hasReachedEnd.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ConversationCompanion(')
          ..write('conversationId: $conversationId, ')
          ..write('hasReachedEnd: $hasReachedEnd, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ChatMessageTable extends ChatMessage
    with TableInfo<$ChatMessageTable, ChatMessageData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChatMessageTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  late final GeneratedColumnWithTypeConverter<ChatMessageStatus, int> status =
      GeneratedColumn<int>('status', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<ChatMessageStatus>($ChatMessageTable.$converterstatus);
  static const VerificationMeta _contentMeta =
      const VerificationMeta('content');
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
      'content', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _conversationMeta =
      const VerificationMeta('conversation');
  @override
  late final GeneratedColumn<String> conversation = GeneratedColumn<String>(
      'conversation', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _creatorMeta =
      const VerificationMeta('creator');
  @override
  late final GeneratedColumn<String> creator = GeneratedColumn<String>(
      'creator', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES user (id)'));
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _parentMessageMeta =
      const VerificationMeta('parentMessage');
  @override
  late final GeneratedColumn<String> parentMessage = GeneratedColumn<String>(
      'parent_message', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES chat_message (id)'));
  @override
  late final GeneratedColumnWithTypeConverter<ChatMessageType, int> type =
      GeneratedColumn<int>('type', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<ChatMessageType>($ChatMessageTable.$convertertype);
  static const VerificationMeta _pendingMeta =
      const VerificationMeta('pending');
  @override
  late final GeneratedColumn<bool> pending = GeneratedColumn<bool>(
      'pending', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("pending" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        status,
        content,
        conversation,
        creator,
        date,
        updatedAt,
        parentMessage,
        type,
        pending
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'chat_message';
  @override
  VerificationContext validateIntegrity(Insertable<ChatMessageData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('conversation')) {
      context.handle(
          _conversationMeta,
          conversation.isAcceptableOrUnknown(
              data['conversation']!, _conversationMeta));
    } else if (isInserting) {
      context.missing(_conversationMeta);
    }
    if (data.containsKey('creator')) {
      context.handle(_creatorMeta,
          creator.isAcceptableOrUnknown(data['creator']!, _creatorMeta));
    } else if (isInserting) {
      context.missing(_creatorMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('parent_message')) {
      context.handle(
          _parentMessageMeta,
          parentMessage.isAcceptableOrUnknown(
              data['parent_message']!, _parentMessageMeta));
    }
    if (data.containsKey('pending')) {
      context.handle(_pendingMeta,
          pending.isAcceptableOrUnknown(data['pending']!, _pendingMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ChatMessageData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChatMessageData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      status: $ChatMessageTable.$converterstatus.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}status'])!),
      content: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content'])!,
      conversation: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}conversation'])!,
      creator: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}creator'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
      parentMessage: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}parent_message']),
      type: $ChatMessageTable.$convertertype.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}type'])!),
      pending: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}pending'])!,
    );
  }

  @override
  $ChatMessageTable createAlias(String alias) {
    return $ChatMessageTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<ChatMessageStatus, int, int> $converterstatus =
      const EnumIndexConverter<ChatMessageStatus>(ChatMessageStatus.values);
  static JsonTypeConverter2<ChatMessageType, int, int> $convertertype =
      const EnumIndexConverter<ChatMessageType>(ChatMessageType.values);
}

class ChatMessageData extends DataClass implements Insertable<ChatMessageData> {
  final String id;
  final ChatMessageStatus status;
  final String content;
  final String conversation;
  final String creator;
  final DateTime date;
  final DateTime? updatedAt;
  final String? parentMessage;
  final ChatMessageType type;
  final bool pending;
  const ChatMessageData(
      {required this.id,
      required this.status,
      required this.content,
      required this.conversation,
      required this.creator,
      required this.date,
      this.updatedAt,
      this.parentMessage,
      required this.type,
      required this.pending});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    {
      map['status'] =
          Variable<int>($ChatMessageTable.$converterstatus.toSql(status));
    }
    map['content'] = Variable<String>(content);
    map['conversation'] = Variable<String>(conversation);
    map['creator'] = Variable<String>(creator);
    map['date'] = Variable<DateTime>(date);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    if (!nullToAbsent || parentMessage != null) {
      map['parent_message'] = Variable<String>(parentMessage);
    }
    {
      map['type'] = Variable<int>($ChatMessageTable.$convertertype.toSql(type));
    }
    map['pending'] = Variable<bool>(pending);
    return map;
  }

  ChatMessageCompanion toCompanion(bool nullToAbsent) {
    return ChatMessageCompanion(
      id: Value(id),
      status: Value(status),
      content: Value(content),
      conversation: Value(conversation),
      creator: Value(creator),
      date: Value(date),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
      parentMessage: parentMessage == null && nullToAbsent
          ? const Value.absent()
          : Value(parentMessage),
      type: Value(type),
      pending: Value(pending),
    );
  }

  factory ChatMessageData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChatMessageData(
      id: serializer.fromJson<String>(json['id']),
      status: $ChatMessageTable.$converterstatus
          .fromJson(serializer.fromJson<int>(json['status'])),
      content: serializer.fromJson<String>(json['content']),
      conversation: serializer.fromJson<String>(json['conversation']),
      creator: serializer.fromJson<String>(json['creator']),
      date: serializer.fromJson<DateTime>(json['date']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
      parentMessage: serializer.fromJson<String?>(json['parentMessage']),
      type: $ChatMessageTable.$convertertype
          .fromJson(serializer.fromJson<int>(json['type'])),
      pending: serializer.fromJson<bool>(json['pending']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'status': serializer
          .toJson<int>($ChatMessageTable.$converterstatus.toJson(status)),
      'content': serializer.toJson<String>(content),
      'conversation': serializer.toJson<String>(conversation),
      'creator': serializer.toJson<String>(creator),
      'date': serializer.toJson<DateTime>(date),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
      'parentMessage': serializer.toJson<String?>(parentMessage),
      'type':
          serializer.toJson<int>($ChatMessageTable.$convertertype.toJson(type)),
      'pending': serializer.toJson<bool>(pending),
    };
  }

  ChatMessageData copyWith(
          {String? id,
          ChatMessageStatus? status,
          String? content,
          String? conversation,
          String? creator,
          DateTime? date,
          Value<DateTime?> updatedAt = const Value.absent(),
          Value<String?> parentMessage = const Value.absent(),
          ChatMessageType? type,
          bool? pending}) =>
      ChatMessageData(
        id: id ?? this.id,
        status: status ?? this.status,
        content: content ?? this.content,
        conversation: conversation ?? this.conversation,
        creator: creator ?? this.creator,
        date: date ?? this.date,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
        parentMessage:
            parentMessage.present ? parentMessage.value : this.parentMessage,
        type: type ?? this.type,
        pending: pending ?? this.pending,
      );
  ChatMessageData copyWithCompanion(ChatMessageCompanion data) {
    return ChatMessageData(
      id: data.id.present ? data.id.value : this.id,
      status: data.status.present ? data.status.value : this.status,
      content: data.content.present ? data.content.value : this.content,
      conversation: data.conversation.present
          ? data.conversation.value
          : this.conversation,
      creator: data.creator.present ? data.creator.value : this.creator,
      date: data.date.present ? data.date.value : this.date,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      parentMessage: data.parentMessage.present
          ? data.parentMessage.value
          : this.parentMessage,
      type: data.type.present ? data.type.value : this.type,
      pending: data.pending.present ? data.pending.value : this.pending,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ChatMessageData(')
          ..write('id: $id, ')
          ..write('status: $status, ')
          ..write('content: $content, ')
          ..write('conversation: $conversation, ')
          ..write('creator: $creator, ')
          ..write('date: $date, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('parentMessage: $parentMessage, ')
          ..write('type: $type, ')
          ..write('pending: $pending')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, status, content, conversation, creator,
      date, updatedAt, parentMessage, type, pending);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChatMessageData &&
          other.id == this.id &&
          other.status == this.status &&
          other.content == this.content &&
          other.conversation == this.conversation &&
          other.creator == this.creator &&
          other.date == this.date &&
          other.updatedAt == this.updatedAt &&
          other.parentMessage == this.parentMessage &&
          other.type == this.type &&
          other.pending == this.pending);
}

class ChatMessageCompanion extends UpdateCompanion<ChatMessageData> {
  final Value<String> id;
  final Value<ChatMessageStatus> status;
  final Value<String> content;
  final Value<String> conversation;
  final Value<String> creator;
  final Value<DateTime> date;
  final Value<DateTime?> updatedAt;
  final Value<String?> parentMessage;
  final Value<ChatMessageType> type;
  final Value<bool> pending;
  final Value<int> rowid;
  const ChatMessageCompanion({
    this.id = const Value.absent(),
    this.status = const Value.absent(),
    this.content = const Value.absent(),
    this.conversation = const Value.absent(),
    this.creator = const Value.absent(),
    this.date = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.parentMessage = const Value.absent(),
    this.type = const Value.absent(),
    this.pending = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ChatMessageCompanion.insert({
    required String id,
    required ChatMessageStatus status,
    required String content,
    required String conversation,
    required String creator,
    required DateTime date,
    this.updatedAt = const Value.absent(),
    this.parentMessage = const Value.absent(),
    required ChatMessageType type,
    this.pending = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        status = Value(status),
        content = Value(content),
        conversation = Value(conversation),
        creator = Value(creator),
        date = Value(date),
        type = Value(type);
  static Insertable<ChatMessageData> custom({
    Expression<String>? id,
    Expression<int>? status,
    Expression<String>? content,
    Expression<String>? conversation,
    Expression<String>? creator,
    Expression<DateTime>? date,
    Expression<DateTime>? updatedAt,
    Expression<String>? parentMessage,
    Expression<int>? type,
    Expression<bool>? pending,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (status != null) 'status': status,
      if (content != null) 'content': content,
      if (conversation != null) 'conversation': conversation,
      if (creator != null) 'creator': creator,
      if (date != null) 'date': date,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (parentMessage != null) 'parent_message': parentMessage,
      if (type != null) 'type': type,
      if (pending != null) 'pending': pending,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ChatMessageCompanion copyWith(
      {Value<String>? id,
      Value<ChatMessageStatus>? status,
      Value<String>? content,
      Value<String>? conversation,
      Value<String>? creator,
      Value<DateTime>? date,
      Value<DateTime?>? updatedAt,
      Value<String?>? parentMessage,
      Value<ChatMessageType>? type,
      Value<bool>? pending,
      Value<int>? rowid}) {
    return ChatMessageCompanion(
      id: id ?? this.id,
      status: status ?? this.status,
      content: content ?? this.content,
      conversation: conversation ?? this.conversation,
      creator: creator ?? this.creator,
      date: date ?? this.date,
      updatedAt: updatedAt ?? this.updatedAt,
      parentMessage: parentMessage ?? this.parentMessage,
      type: type ?? this.type,
      pending: pending ?? this.pending,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (status.present) {
      map['status'] =
          Variable<int>($ChatMessageTable.$converterstatus.toSql(status.value));
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (conversation.present) {
      map['conversation'] = Variable<String>(conversation.value);
    }
    if (creator.present) {
      map['creator'] = Variable<String>(creator.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (parentMessage.present) {
      map['parent_message'] = Variable<String>(parentMessage.value);
    }
    if (type.present) {
      map['type'] =
          Variable<int>($ChatMessageTable.$convertertype.toSql(type.value));
    }
    if (pending.present) {
      map['pending'] = Variable<bool>(pending.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChatMessageCompanion(')
          ..write('id: $id, ')
          ..write('status: $status, ')
          ..write('content: $content, ')
          ..write('conversation: $conversation, ')
          ..write('creator: $creator, ')
          ..write('date: $date, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('parentMessage: $parentMessage, ')
          ..write('type: $type, ')
          ..write('pending: $pending, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AttachmentTable extends Attachment
    with TableInfo<$AttachmentTable, AttachmentData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AttachmentTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _messageMeta =
      const VerificationMeta('message');
  @override
  late final GeneratedColumn<String> message = GeneratedColumn<String>(
      'message', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES chat_message (id)'));
  static const VerificationMeta _thumbMeta = const VerificationMeta('thumb');
  @override
  late final GeneratedColumn<String> thumb = GeneratedColumn<String>(
      'thumb', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _fileMeta = const VerificationMeta('file');
  @override
  late final GeneratedColumn<String> file = GeneratedColumn<String>(
      'file', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  late final GeneratedColumnWithTypeConverter<AttachmentType, int> type =
      GeneratedColumn<int>('type', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<AttachmentType>($AttachmentTable.$convertertype);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, message, thumb, file, type, createdAt, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'attachment';
  @override
  VerificationContext validateIntegrity(Insertable<AttachmentData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('message')) {
      context.handle(_messageMeta,
          message.isAcceptableOrUnknown(data['message']!, _messageMeta));
    } else if (isInserting) {
      context.missing(_messageMeta);
    }
    if (data.containsKey('thumb')) {
      context.handle(
          _thumbMeta, thumb.isAcceptableOrUnknown(data['thumb']!, _thumbMeta));
    }
    if (data.containsKey('file')) {
      context.handle(
          _fileMeta, file.isAcceptableOrUnknown(data['file']!, _fileMeta));
    } else if (isInserting) {
      context.missing(_fileMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AttachmentData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AttachmentData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      message: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}message'])!,
      thumb: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}thumb']),
      file: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}file'])!,
      type: $AttachmentTable.$convertertype.fromSql(attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}type'])!),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
    );
  }

  @override
  $AttachmentTable createAlias(String alias) {
    return $AttachmentTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<AttachmentType, int, int> $convertertype =
      const EnumIndexConverter<AttachmentType>(AttachmentType.values);
}

class AttachmentData extends DataClass implements Insertable<AttachmentData> {
  final String id;
  final String message;
  final String? thumb;
  final String file;
  final AttachmentType type;
  final DateTime createdAt;
  final DateTime? updatedAt;
  const AttachmentData(
      {required this.id,
      required this.message,
      this.thumb,
      required this.file,
      required this.type,
      required this.createdAt,
      this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['message'] = Variable<String>(message);
    if (!nullToAbsent || thumb != null) {
      map['thumb'] = Variable<String>(thumb);
    }
    map['file'] = Variable<String>(file);
    {
      map['type'] = Variable<int>($AttachmentTable.$convertertype.toSql(type));
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  AttachmentCompanion toCompanion(bool nullToAbsent) {
    return AttachmentCompanion(
      id: Value(id),
      message: Value(message),
      thumb:
          thumb == null && nullToAbsent ? const Value.absent() : Value(thumb),
      file: Value(file),
      type: Value(type),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory AttachmentData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AttachmentData(
      id: serializer.fromJson<String>(json['id']),
      message: serializer.fromJson<String>(json['message']),
      thumb: serializer.fromJson<String?>(json['thumb']),
      file: serializer.fromJson<String>(json['file']),
      type: $AttachmentTable.$convertertype
          .fromJson(serializer.fromJson<int>(json['type'])),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'message': serializer.toJson<String>(message),
      'thumb': serializer.toJson<String?>(thumb),
      'file': serializer.toJson<String>(file),
      'type':
          serializer.toJson<int>($AttachmentTable.$convertertype.toJson(type)),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  AttachmentData copyWith(
          {String? id,
          String? message,
          Value<String?> thumb = const Value.absent(),
          String? file,
          AttachmentType? type,
          DateTime? createdAt,
          Value<DateTime?> updatedAt = const Value.absent()}) =>
      AttachmentData(
        id: id ?? this.id,
        message: message ?? this.message,
        thumb: thumb.present ? thumb.value : this.thumb,
        file: file ?? this.file,
        type: type ?? this.type,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
      );
  AttachmentData copyWithCompanion(AttachmentCompanion data) {
    return AttachmentData(
      id: data.id.present ? data.id.value : this.id,
      message: data.message.present ? data.message.value : this.message,
      thumb: data.thumb.present ? data.thumb.value : this.thumb,
      file: data.file.present ? data.file.value : this.file,
      type: data.type.present ? data.type.value : this.type,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AttachmentData(')
          ..write('id: $id, ')
          ..write('message: $message, ')
          ..write('thumb: $thumb, ')
          ..write('file: $file, ')
          ..write('type: $type, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, message, thumb, file, type, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AttachmentData &&
          other.id == this.id &&
          other.message == this.message &&
          other.thumb == this.thumb &&
          other.file == this.file &&
          other.type == this.type &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class AttachmentCompanion extends UpdateCompanion<AttachmentData> {
  final Value<String> id;
  final Value<String> message;
  final Value<String?> thumb;
  final Value<String> file;
  final Value<AttachmentType> type;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<int> rowid;
  const AttachmentCompanion({
    this.id = const Value.absent(),
    this.message = const Value.absent(),
    this.thumb = const Value.absent(),
    this.file = const Value.absent(),
    this.type = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AttachmentCompanion.insert({
    required String id,
    required String message,
    this.thumb = const Value.absent(),
    required String file,
    required AttachmentType type,
    required DateTime createdAt,
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        message = Value(message),
        file = Value(file),
        type = Value(type),
        createdAt = Value(createdAt);
  static Insertable<AttachmentData> custom({
    Expression<String>? id,
    Expression<String>? message,
    Expression<String>? thumb,
    Expression<String>? file,
    Expression<int>? type,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (message != null) 'message': message,
      if (thumb != null) 'thumb': thumb,
      if (file != null) 'file': file,
      if (type != null) 'type': type,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AttachmentCompanion copyWith(
      {Value<String>? id,
      Value<String>? message,
      Value<String?>? thumb,
      Value<String>? file,
      Value<AttachmentType>? type,
      Value<DateTime>? createdAt,
      Value<DateTime?>? updatedAt,
      Value<int>? rowid}) {
    return AttachmentCompanion(
      id: id ?? this.id,
      message: message ?? this.message,
      thumb: thumb ?? this.thumb,
      file: file ?? this.file,
      type: type ?? this.type,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (message.present) {
      map['message'] = Variable<String>(message.value);
    }
    if (thumb.present) {
      map['thumb'] = Variable<String>(thumb.value);
    }
    if (file.present) {
      map['file'] = Variable<String>(file.value);
    }
    if (type.present) {
      map['type'] =
          Variable<int>($AttachmentTable.$convertertype.toSql(type.value));
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AttachmentCompanion(')
          ..write('id: $id, ')
          ..write('message: $message, ')
          ..write('thumb: $thumb, ')
          ..write('file: $file, ')
          ..write('type: $type, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $NotificationTable extends Notification
    with TableInfo<$NotificationTable, NotificationData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NotificationTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  late final GeneratedColumnWithTypeConverter<NotificationType, int> type =
      GeneratedColumn<int>('type', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<NotificationType>($NotificationTable.$convertertype);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _thumbMeta = const VerificationMeta('thumb');
  @override
  late final GeneratedColumn<String> thumb = GeneratedColumn<String>(
      'thumb', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _senderMeta = const VerificationMeta('sender');
  @override
  late final GeneratedColumn<String> sender = GeneratedColumn<String>(
      'sender', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES user (id)'));
  static const VerificationMeta _pathMeta = const VerificationMeta('path');
  @override
  late final GeneratedColumn<String> path = GeneratedColumn<String>(
      'path', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _readMeta = const VerificationMeta('read');
  @override
  late final GeneratedColumn<bool> read = GeneratedColumn<bool>(
      'read', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("read" IN (0, 1))'));
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, type, title, thumb, sender, path, read, date];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'notification';
  @override
  VerificationContext validateIntegrity(Insertable<NotificationData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('thumb')) {
      context.handle(
          _thumbMeta, thumb.isAcceptableOrUnknown(data['thumb']!, _thumbMeta));
    } else if (isInserting) {
      context.missing(_thumbMeta);
    }
    if (data.containsKey('sender')) {
      context.handle(_senderMeta,
          sender.isAcceptableOrUnknown(data['sender']!, _senderMeta));
    }
    if (data.containsKey('path')) {
      context.handle(
          _pathMeta, path.isAcceptableOrUnknown(data['path']!, _pathMeta));
    } else if (isInserting) {
      context.missing(_pathMeta);
    }
    if (data.containsKey('read')) {
      context.handle(
          _readMeta, read.isAcceptableOrUnknown(data['read']!, _readMeta));
    } else if (isInserting) {
      context.missing(_readMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NotificationData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NotificationData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      type: $NotificationTable.$convertertype.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}type'])!),
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      thumb: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}thumb'])!,
      sender: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sender']),
      path: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}path'])!,
      read: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}read'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
    );
  }

  @override
  $NotificationTable createAlias(String alias) {
    return $NotificationTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<NotificationType, int, int> $convertertype =
      const EnumIndexConverter<NotificationType>(NotificationType.values);
}

class NotificationData extends DataClass
    implements Insertable<NotificationData> {
  final String id;
  final NotificationType type;
  final String title;
  final String thumb;
  final String? sender;
  final String path;
  final bool read;
  final DateTime date;
  const NotificationData(
      {required this.id,
      required this.type,
      required this.title,
      required this.thumb,
      this.sender,
      required this.path,
      required this.read,
      required this.date});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    {
      map['type'] =
          Variable<int>($NotificationTable.$convertertype.toSql(type));
    }
    map['title'] = Variable<String>(title);
    map['thumb'] = Variable<String>(thumb);
    if (!nullToAbsent || sender != null) {
      map['sender'] = Variable<String>(sender);
    }
    map['path'] = Variable<String>(path);
    map['read'] = Variable<bool>(read);
    map['date'] = Variable<DateTime>(date);
    return map;
  }

  NotificationCompanion toCompanion(bool nullToAbsent) {
    return NotificationCompanion(
      id: Value(id),
      type: Value(type),
      title: Value(title),
      thumb: Value(thumb),
      sender:
          sender == null && nullToAbsent ? const Value.absent() : Value(sender),
      path: Value(path),
      read: Value(read),
      date: Value(date),
    );
  }

  factory NotificationData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NotificationData(
      id: serializer.fromJson<String>(json['id']),
      type: $NotificationTable.$convertertype
          .fromJson(serializer.fromJson<int>(json['type'])),
      title: serializer.fromJson<String>(json['title']),
      thumb: serializer.fromJson<String>(json['thumb']),
      sender: serializer.fromJson<String?>(json['sender']),
      path: serializer.fromJson<String>(json['path']),
      read: serializer.fromJson<bool>(json['read']),
      date: serializer.fromJson<DateTime>(json['date']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'type': serializer
          .toJson<int>($NotificationTable.$convertertype.toJson(type)),
      'title': serializer.toJson<String>(title),
      'thumb': serializer.toJson<String>(thumb),
      'sender': serializer.toJson<String?>(sender),
      'path': serializer.toJson<String>(path),
      'read': serializer.toJson<bool>(read),
      'date': serializer.toJson<DateTime>(date),
    };
  }

  NotificationData copyWith(
          {String? id,
          NotificationType? type,
          String? title,
          String? thumb,
          Value<String?> sender = const Value.absent(),
          String? path,
          bool? read,
          DateTime? date}) =>
      NotificationData(
        id: id ?? this.id,
        type: type ?? this.type,
        title: title ?? this.title,
        thumb: thumb ?? this.thumb,
        sender: sender.present ? sender.value : this.sender,
        path: path ?? this.path,
        read: read ?? this.read,
        date: date ?? this.date,
      );
  NotificationData copyWithCompanion(NotificationCompanion data) {
    return NotificationData(
      id: data.id.present ? data.id.value : this.id,
      type: data.type.present ? data.type.value : this.type,
      title: data.title.present ? data.title.value : this.title,
      thumb: data.thumb.present ? data.thumb.value : this.thumb,
      sender: data.sender.present ? data.sender.value : this.sender,
      path: data.path.present ? data.path.value : this.path,
      read: data.read.present ? data.read.value : this.read,
      date: data.date.present ? data.date.value : this.date,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NotificationData(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('title: $title, ')
          ..write('thumb: $thumb, ')
          ..write('sender: $sender, ')
          ..write('path: $path, ')
          ..write('read: $read, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, type, title, thumb, sender, path, read, date);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NotificationData &&
          other.id == this.id &&
          other.type == this.type &&
          other.title == this.title &&
          other.thumb == this.thumb &&
          other.sender == this.sender &&
          other.path == this.path &&
          other.read == this.read &&
          other.date == this.date);
}

class NotificationCompanion extends UpdateCompanion<NotificationData> {
  final Value<String> id;
  final Value<NotificationType> type;
  final Value<String> title;
  final Value<String> thumb;
  final Value<String?> sender;
  final Value<String> path;
  final Value<bool> read;
  final Value<DateTime> date;
  final Value<int> rowid;
  const NotificationCompanion({
    this.id = const Value.absent(),
    this.type = const Value.absent(),
    this.title = const Value.absent(),
    this.thumb = const Value.absent(),
    this.sender = const Value.absent(),
    this.path = const Value.absent(),
    this.read = const Value.absent(),
    this.date = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  NotificationCompanion.insert({
    required String id,
    required NotificationType type,
    required String title,
    required String thumb,
    this.sender = const Value.absent(),
    required String path,
    required bool read,
    required DateTime date,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        type = Value(type),
        title = Value(title),
        thumb = Value(thumb),
        path = Value(path),
        read = Value(read),
        date = Value(date);
  static Insertable<NotificationData> custom({
    Expression<String>? id,
    Expression<int>? type,
    Expression<String>? title,
    Expression<String>? thumb,
    Expression<String>? sender,
    Expression<String>? path,
    Expression<bool>? read,
    Expression<DateTime>? date,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (type != null) 'type': type,
      if (title != null) 'title': title,
      if (thumb != null) 'thumb': thumb,
      if (sender != null) 'sender': sender,
      if (path != null) 'path': path,
      if (read != null) 'read': read,
      if (date != null) 'date': date,
      if (rowid != null) 'rowid': rowid,
    });
  }

  NotificationCompanion copyWith(
      {Value<String>? id,
      Value<NotificationType>? type,
      Value<String>? title,
      Value<String>? thumb,
      Value<String?>? sender,
      Value<String>? path,
      Value<bool>? read,
      Value<DateTime>? date,
      Value<int>? rowid}) {
    return NotificationCompanion(
      id: id ?? this.id,
      type: type ?? this.type,
      title: title ?? this.title,
      thumb: thumb ?? this.thumb,
      sender: sender ?? this.sender,
      path: path ?? this.path,
      read: read ?? this.read,
      date: date ?? this.date,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (type.present) {
      map['type'] =
          Variable<int>($NotificationTable.$convertertype.toSql(type.value));
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (thumb.present) {
      map['thumb'] = Variable<String>(thumb.value);
    }
    if (sender.present) {
      map['sender'] = Variable<String>(sender.value);
    }
    if (path.present) {
      map['path'] = Variable<String>(path.value);
    }
    if (read.present) {
      map['read'] = Variable<bool>(read.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NotificationCompanion(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('title: $title, ')
          ..write('thumb: $thumb, ')
          ..write('sender: $sender, ')
          ..write('path: $path, ')
          ..write('read: $read, ')
          ..write('date: $date, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $NotificationsConfigTable extends NotificationsConfig
    with TableInfo<$NotificationsConfigTable, NotificationsConfigData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NotificationsConfigTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _originMeta = const VerificationMeta('origin');
  @override
  late final GeneratedColumn<String> origin = GeneratedColumn<String>(
      'origin', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  late final GeneratedColumnWithTypeConverter<NotificationConfigurationType,
      int> type = GeneratedColumn<int>('type', aliasedName, false,
          type: DriftSqlType.int, requiredDuringInsert: true)
      .withConverter<NotificationConfigurationType>(
          $NotificationsConfigTable.$convertertype);
  @override
  late final GeneratedColumnWithTypeConverter<NotificationConfigurationStatus,
      int> status = GeneratedColumn<int>('status', aliasedName, false,
          type: DriftSqlType.int, requiredDuringInsert: true)
      .withConverter<NotificationConfigurationStatus>(
          $NotificationsConfigTable.$converterstatus);
  static const VerificationMeta _changeAtMeta =
      const VerificationMeta('changeAt');
  @override
  late final GeneratedColumn<DateTime> changeAt = GeneratedColumn<DateTime>(
      'change_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [origin, type, status, changeAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'notifications_config';
  @override
  VerificationContext validateIntegrity(
      Insertable<NotificationsConfigData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('origin')) {
      context.handle(_originMeta,
          origin.isAcceptableOrUnknown(data['origin']!, _originMeta));
    } else if (isInserting) {
      context.missing(_originMeta);
    }
    if (data.containsKey('change_at')) {
      context.handle(_changeAtMeta,
          changeAt.isAcceptableOrUnknown(data['change_at']!, _changeAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  NotificationsConfigData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NotificationsConfigData(
      origin: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}origin'])!,
      type: $NotificationsConfigTable.$convertertype.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}type'])!),
      status: $NotificationsConfigTable.$converterstatus.fromSql(
          attachedDatabase.typeMapping
              .read(DriftSqlType.int, data['${effectivePrefix}status'])!),
      changeAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}change_at']),
    );
  }

  @override
  $NotificationsConfigTable createAlias(String alias) {
    return $NotificationsConfigTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<NotificationConfigurationType, int, int>
      $convertertype = const EnumIndexConverter<NotificationConfigurationType>(
          NotificationConfigurationType.values);
  static JsonTypeConverter2<NotificationConfigurationStatus, int, int>
      $converterstatus =
      const EnumIndexConverter<NotificationConfigurationStatus>(
          NotificationConfigurationStatus.values);
}

class NotificationsConfigData extends DataClass
    implements Insertable<NotificationsConfigData> {
  final String origin;
  final NotificationConfigurationType type;
  final NotificationConfigurationStatus status;
  final DateTime? changeAt;
  const NotificationsConfigData(
      {required this.origin,
      required this.type,
      required this.status,
      this.changeAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['origin'] = Variable<String>(origin);
    {
      map['type'] =
          Variable<int>($NotificationsConfigTable.$convertertype.toSql(type));
    }
    {
      map['status'] = Variable<int>(
          $NotificationsConfigTable.$converterstatus.toSql(status));
    }
    if (!nullToAbsent || changeAt != null) {
      map['change_at'] = Variable<DateTime>(changeAt);
    }
    return map;
  }

  NotificationsConfigCompanion toCompanion(bool nullToAbsent) {
    return NotificationsConfigCompanion(
      origin: Value(origin),
      type: Value(type),
      status: Value(status),
      changeAt: changeAt == null && nullToAbsent
          ? const Value.absent()
          : Value(changeAt),
    );
  }

  factory NotificationsConfigData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NotificationsConfigData(
      origin: serializer.fromJson<String>(json['origin']),
      type: $NotificationsConfigTable.$convertertype
          .fromJson(serializer.fromJson<int>(json['type'])),
      status: $NotificationsConfigTable.$converterstatus
          .fromJson(serializer.fromJson<int>(json['status'])),
      changeAt: serializer.fromJson<DateTime?>(json['changeAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'origin': serializer.toJson<String>(origin),
      'type': serializer
          .toJson<int>($NotificationsConfigTable.$convertertype.toJson(type)),
      'status': serializer.toJson<int>(
          $NotificationsConfigTable.$converterstatus.toJson(status)),
      'changeAt': serializer.toJson<DateTime?>(changeAt),
    };
  }

  NotificationsConfigData copyWith(
          {String? origin,
          NotificationConfigurationType? type,
          NotificationConfigurationStatus? status,
          Value<DateTime?> changeAt = const Value.absent()}) =>
      NotificationsConfigData(
        origin: origin ?? this.origin,
        type: type ?? this.type,
        status: status ?? this.status,
        changeAt: changeAt.present ? changeAt.value : this.changeAt,
      );
  NotificationsConfigData copyWithCompanion(NotificationsConfigCompanion data) {
    return NotificationsConfigData(
      origin: data.origin.present ? data.origin.value : this.origin,
      type: data.type.present ? data.type.value : this.type,
      status: data.status.present ? data.status.value : this.status,
      changeAt: data.changeAt.present ? data.changeAt.value : this.changeAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NotificationsConfigData(')
          ..write('origin: $origin, ')
          ..write('type: $type, ')
          ..write('status: $status, ')
          ..write('changeAt: $changeAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(origin, type, status, changeAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NotificationsConfigData &&
          other.origin == this.origin &&
          other.type == this.type &&
          other.status == this.status &&
          other.changeAt == this.changeAt);
}

class NotificationsConfigCompanion
    extends UpdateCompanion<NotificationsConfigData> {
  final Value<String> origin;
  final Value<NotificationConfigurationType> type;
  final Value<NotificationConfigurationStatus> status;
  final Value<DateTime?> changeAt;
  final Value<int> rowid;
  const NotificationsConfigCompanion({
    this.origin = const Value.absent(),
    this.type = const Value.absent(),
    this.status = const Value.absent(),
    this.changeAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  NotificationsConfigCompanion.insert({
    required String origin,
    required NotificationConfigurationType type,
    required NotificationConfigurationStatus status,
    this.changeAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : origin = Value(origin),
        type = Value(type),
        status = Value(status);
  static Insertable<NotificationsConfigData> custom({
    Expression<String>? origin,
    Expression<int>? type,
    Expression<int>? status,
    Expression<DateTime>? changeAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (origin != null) 'origin': origin,
      if (type != null) 'type': type,
      if (status != null) 'status': status,
      if (changeAt != null) 'change_at': changeAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  NotificationsConfigCompanion copyWith(
      {Value<String>? origin,
      Value<NotificationConfigurationType>? type,
      Value<NotificationConfigurationStatus>? status,
      Value<DateTime?>? changeAt,
      Value<int>? rowid}) {
    return NotificationsConfigCompanion(
      origin: origin ?? this.origin,
      type: type ?? this.type,
      status: status ?? this.status,
      changeAt: changeAt ?? this.changeAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (origin.present) {
      map['origin'] = Variable<String>(origin.value);
    }
    if (type.present) {
      map['type'] = Variable<int>(
          $NotificationsConfigTable.$convertertype.toSql(type.value));
    }
    if (status.present) {
      map['status'] = Variable<int>(
          $NotificationsConfigTable.$converterstatus.toSql(status.value));
    }
    if (changeAt.present) {
      map['change_at'] = Variable<DateTime>(changeAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NotificationsConfigCompanion(')
          ..write('origin: $origin, ')
          ..write('type: $type, ')
          ..write('status: $status, ')
          ..write('changeAt: $changeAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UserTable user = $UserTable(this);
  late final $FriendshipTable friendship = $FriendshipTable(this);
  late final $GameTable game = $GameTable(this);
  late final $MatchTable match = $MatchTable(this);
  late final $ConversationTable conversation = $ConversationTable(this);
  late final $ChatMessageTable chatMessage = $ChatMessageTable(this);
  late final $AttachmentTable attachment = $AttachmentTable(this);
  late final $NotificationTable notification = $NotificationTable(this);
  late final $NotificationsConfigTable notificationsConfig =
      $NotificationsConfigTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        user,
        friendship,
        game,
        match,
        conversation,
        chatMessage,
        attachment,
        notification,
        notificationsConfig
      ];
}

typedef $$UserTableCreateCompanionBuilder = UserCompanion Function({
  required String id,
  required String name,
  required String username,
  required String thumb,
  required String image,
  Value<DateTime> lastUpdated,
  Value<int> rowid,
});
typedef $$UserTableUpdateCompanionBuilder = UserCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String> username,
  Value<String> thumb,
  Value<String> image,
  Value<DateTime> lastUpdated,
  Value<int> rowid,
});

final class $$UserTableReferences
    extends BaseReferences<_$AppDatabase, $UserTable, UserData> {
  $$UserTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$FriendshipTable, List<FriendshipData>>
      _friendshipRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.friendship,
              aliasName: $_aliasNameGenerator(db.user.id, db.friendship.user));

  $$FriendshipTableProcessedTableManager get friendshipRefs {
    final manager = $$FriendshipTableTableManager($_db, $_db.friendship)
        .filter((f) => f.user.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_friendshipRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$MatchTable, List<MatchData>> _matchRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.match,
          aliasName: $_aliasNameGenerator(db.user.id, db.match.user));

  $$MatchTableProcessedTableManager get matchRefs {
    final manager = $$MatchTableTableManager($_db, $_db.match)
        .filter((f) => f.user.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_matchRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$ChatMessageTable, List<ChatMessageData>>
      _chatMessageRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
          db.chatMessage,
          aliasName: $_aliasNameGenerator(db.user.id, db.chatMessage.creator));

  $$ChatMessageTableProcessedTableManager get chatMessageRefs {
    final manager = $$ChatMessageTableTableManager($_db, $_db.chatMessage)
        .filter((f) => f.creator.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_chatMessageRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$NotificationTable, List<NotificationData>>
      _notificationRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
          db.notification,
          aliasName: $_aliasNameGenerator(db.user.id, db.notification.sender));

  $$NotificationTableProcessedTableManager get notificationRefs {
    final manager = $$NotificationTableTableManager($_db, $_db.notification)
        .filter((f) => f.sender.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_notificationRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$UserTableFilterComposer extends Composer<_$AppDatabase, $UserTable> {
  $$UserTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get username => $composableBuilder(
      column: $table.username, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get thumb => $composableBuilder(
      column: $table.thumb, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get image => $composableBuilder(
      column: $table.image, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastUpdated => $composableBuilder(
      column: $table.lastUpdated, builder: (column) => ColumnFilters(column));

  Expression<bool> friendshipRefs(
      Expression<bool> Function($$FriendshipTableFilterComposer f) f) {
    final $$FriendshipTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.friendship,
        getReferencedColumn: (t) => t.user,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FriendshipTableFilterComposer(
              $db: $db,
              $table: $db.friendship,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> matchRefs(
      Expression<bool> Function($$MatchTableFilterComposer f) f) {
    final $$MatchTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.match,
        getReferencedColumn: (t) => t.user,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MatchTableFilterComposer(
              $db: $db,
              $table: $db.match,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> chatMessageRefs(
      Expression<bool> Function($$ChatMessageTableFilterComposer f) f) {
    final $$ChatMessageTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.chatMessage,
        getReferencedColumn: (t) => t.creator,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ChatMessageTableFilterComposer(
              $db: $db,
              $table: $db.chatMessage,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> notificationRefs(
      Expression<bool> Function($$NotificationTableFilterComposer f) f) {
    final $$NotificationTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.notification,
        getReferencedColumn: (t) => t.sender,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$NotificationTableFilterComposer(
              $db: $db,
              $table: $db.notification,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$UserTableOrderingComposer extends Composer<_$AppDatabase, $UserTable> {
  $$UserTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get username => $composableBuilder(
      column: $table.username, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get thumb => $composableBuilder(
      column: $table.thumb, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get image => $composableBuilder(
      column: $table.image, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastUpdated => $composableBuilder(
      column: $table.lastUpdated, builder: (column) => ColumnOrderings(column));
}

class $$UserTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserTable> {
  $$UserTableAnnotationComposer({
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

  GeneratedColumn<String> get username =>
      $composableBuilder(column: $table.username, builder: (column) => column);

  GeneratedColumn<String> get thumb =>
      $composableBuilder(column: $table.thumb, builder: (column) => column);

  GeneratedColumn<String> get image =>
      $composableBuilder(column: $table.image, builder: (column) => column);

  GeneratedColumn<DateTime> get lastUpdated => $composableBuilder(
      column: $table.lastUpdated, builder: (column) => column);

  Expression<T> friendshipRefs<T extends Object>(
      Expression<T> Function($$FriendshipTableAnnotationComposer a) f) {
    final $$FriendshipTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.friendship,
        getReferencedColumn: (t) => t.user,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FriendshipTableAnnotationComposer(
              $db: $db,
              $table: $db.friendship,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> matchRefs<T extends Object>(
      Expression<T> Function($$MatchTableAnnotationComposer a) f) {
    final $$MatchTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.match,
        getReferencedColumn: (t) => t.user,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MatchTableAnnotationComposer(
              $db: $db,
              $table: $db.match,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> chatMessageRefs<T extends Object>(
      Expression<T> Function($$ChatMessageTableAnnotationComposer a) f) {
    final $$ChatMessageTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.chatMessage,
        getReferencedColumn: (t) => t.creator,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ChatMessageTableAnnotationComposer(
              $db: $db,
              $table: $db.chatMessage,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> notificationRefs<T extends Object>(
      Expression<T> Function($$NotificationTableAnnotationComposer a) f) {
    final $$NotificationTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.notification,
        getReferencedColumn: (t) => t.sender,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$NotificationTableAnnotationComposer(
              $db: $db,
              $table: $db.notification,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$UserTableTableManager extends RootTableManager<
    _$AppDatabase,
    $UserTable,
    UserData,
    $$UserTableFilterComposer,
    $$UserTableOrderingComposer,
    $$UserTableAnnotationComposer,
    $$UserTableCreateCompanionBuilder,
    $$UserTableUpdateCompanionBuilder,
    (UserData, $$UserTableReferences),
    UserData,
    PrefetchHooks Function(
        {bool friendshipRefs,
        bool matchRefs,
        bool chatMessageRefs,
        bool notificationRefs})> {
  $$UserTableTableManager(_$AppDatabase db, $UserTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> username = const Value.absent(),
            Value<String> thumb = const Value.absent(),
            Value<String> image = const Value.absent(),
            Value<DateTime> lastUpdated = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              UserCompanion(
            id: id,
            name: name,
            username: username,
            thumb: thumb,
            image: image,
            lastUpdated: lastUpdated,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            required String username,
            required String thumb,
            required String image,
            Value<DateTime> lastUpdated = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              UserCompanion.insert(
            id: id,
            name: name,
            username: username,
            thumb: thumb,
            image: image,
            lastUpdated: lastUpdated,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$UserTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {friendshipRefs = false,
              matchRefs = false,
              chatMessageRefs = false,
              notificationRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (friendshipRefs) db.friendship,
                if (matchRefs) db.match,
                if (chatMessageRefs) db.chatMessage,
                if (notificationRefs) db.notification
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (friendshipRefs)
                    await $_getPrefetchedData<UserData, $UserTable,
                            FriendshipData>(
                        currentTable: table,
                        referencedTable:
                            $$UserTableReferences._friendshipRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$UserTableReferences(db, table, p0).friendshipRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) =>
                                referencedItems.where((e) => e.user == item.id),
                        typedResults: items),
                  if (matchRefs)
                    await $_getPrefetchedData<UserData, $UserTable, MatchData>(
                        currentTable: table,
                        referencedTable:
                            $$UserTableReferences._matchRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$UserTableReferences(db, table, p0).matchRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) =>
                                referencedItems.where((e) => e.user == item.id),
                        typedResults: items),
                  if (chatMessageRefs)
                    await $_getPrefetchedData<UserData, $UserTable,
                            ChatMessageData>(
                        currentTable: table,
                        referencedTable:
                            $$UserTableReferences._chatMessageRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$UserTableReferences(db, table, p0)
                                .chatMessageRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.creator == item.id),
                        typedResults: items),
                  if (notificationRefs)
                    await $_getPrefetchedData<UserData, $UserTable,
                            NotificationData>(
                        currentTable: table,
                        referencedTable:
                            $$UserTableReferences._notificationRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$UserTableReferences(db, table, p0)
                                .notificationRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.sender == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$UserTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $UserTable,
    UserData,
    $$UserTableFilterComposer,
    $$UserTableOrderingComposer,
    $$UserTableAnnotationComposer,
    $$UserTableCreateCompanionBuilder,
    $$UserTableUpdateCompanionBuilder,
    (UserData, $$UserTableReferences),
    UserData,
    PrefetchHooks Function(
        {bool friendshipRefs,
        bool matchRefs,
        bool chatMessageRefs,
        bool notificationRefs})>;
typedef $$FriendshipTableCreateCompanionBuilder = FriendshipCompanion Function({
  required String id,
  required String user,
  required FriendshipStatus status,
  required DateTime createdAt,
  Value<DateTime> lastUpdated,
  Value<int> rowid,
});
typedef $$FriendshipTableUpdateCompanionBuilder = FriendshipCompanion Function({
  Value<String> id,
  Value<String> user,
  Value<FriendshipStatus> status,
  Value<DateTime> createdAt,
  Value<DateTime> lastUpdated,
  Value<int> rowid,
});

final class $$FriendshipTableReferences
    extends BaseReferences<_$AppDatabase, $FriendshipTable, FriendshipData> {
  $$FriendshipTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $UserTable _userTable(_$AppDatabase db) =>
      db.user.createAlias($_aliasNameGenerator(db.friendship.user, db.user.id));

  $$UserTableProcessedTableManager get user {
    final $_column = $_itemColumn<String>('user')!;

    final manager = $$UserTableTableManager($_db, $_db.user)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$FriendshipTableFilterComposer
    extends Composer<_$AppDatabase, $FriendshipTable> {
  $$FriendshipTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<FriendshipStatus, FriendshipStatus, int>
      get status => $composableBuilder(
          column: $table.status,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastUpdated => $composableBuilder(
      column: $table.lastUpdated, builder: (column) => ColumnFilters(column));

  $$UserTableFilterComposer get user {
    final $$UserTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.user,
        referencedTable: $db.user,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UserTableFilterComposer(
              $db: $db,
              $table: $db.user,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$FriendshipTableOrderingComposer
    extends Composer<_$AppDatabase, $FriendshipTable> {
  $$FriendshipTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastUpdated => $composableBuilder(
      column: $table.lastUpdated, builder: (column) => ColumnOrderings(column));

  $$UserTableOrderingComposer get user {
    final $$UserTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.user,
        referencedTable: $db.user,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UserTableOrderingComposer(
              $db: $db,
              $table: $db.user,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$FriendshipTableAnnotationComposer
    extends Composer<_$AppDatabase, $FriendshipTable> {
  $$FriendshipTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<FriendshipStatus, int> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get lastUpdated => $composableBuilder(
      column: $table.lastUpdated, builder: (column) => column);

  $$UserTableAnnotationComposer get user {
    final $$UserTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.user,
        referencedTable: $db.user,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UserTableAnnotationComposer(
              $db: $db,
              $table: $db.user,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$FriendshipTableTableManager extends RootTableManager<
    _$AppDatabase,
    $FriendshipTable,
    FriendshipData,
    $$FriendshipTableFilterComposer,
    $$FriendshipTableOrderingComposer,
    $$FriendshipTableAnnotationComposer,
    $$FriendshipTableCreateCompanionBuilder,
    $$FriendshipTableUpdateCompanionBuilder,
    (FriendshipData, $$FriendshipTableReferences),
    FriendshipData,
    PrefetchHooks Function({bool user})> {
  $$FriendshipTableTableManager(_$AppDatabase db, $FriendshipTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FriendshipTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FriendshipTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FriendshipTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> user = const Value.absent(),
            Value<FriendshipStatus> status = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> lastUpdated = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              FriendshipCompanion(
            id: id,
            user: user,
            status: status,
            createdAt: createdAt,
            lastUpdated: lastUpdated,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String user,
            required FriendshipStatus status,
            required DateTime createdAt,
            Value<DateTime> lastUpdated = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              FriendshipCompanion.insert(
            id: id,
            user: user,
            status: status,
            createdAt: createdAt,
            lastUpdated: lastUpdated,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$FriendshipTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({user = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (user) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.user,
                    referencedTable: $$FriendshipTableReferences._userTable(db),
                    referencedColumn:
                        $$FriendshipTableReferences._userTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$FriendshipTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $FriendshipTable,
    FriendshipData,
    $$FriendshipTableFilterComposer,
    $$FriendshipTableOrderingComposer,
    $$FriendshipTableAnnotationComposer,
    $$FriendshipTableCreateCompanionBuilder,
    $$FriendshipTableUpdateCompanionBuilder,
    (FriendshipData, $$FriendshipTableReferences),
    FriendshipData,
    PrefetchHooks Function({bool user})>;
typedef $$GameTableCreateCompanionBuilder = GameCompanion Function({
  required String id,
  required String name,
  required String slug,
  required int apiId,
  required List<PlatformId> platforms,
  Value<String?> background,
  required List<String> screenshots,
  required String description,
  Value<DateTime> lastUpdated,
  Value<int> rowid,
});
typedef $$GameTableUpdateCompanionBuilder = GameCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String> slug,
  Value<int> apiId,
  Value<List<PlatformId>> platforms,
  Value<String?> background,
  Value<List<String>> screenshots,
  Value<String> description,
  Value<DateTime> lastUpdated,
  Value<int> rowid,
});

final class $$GameTableReferences
    extends BaseReferences<_$AppDatabase, $GameTable, GameData> {
  $$GameTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$MatchTable, List<MatchData>> _matchRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.match,
          aliasName: $_aliasNameGenerator(db.game.id, db.match.game));

  $$MatchTableProcessedTableManager get matchRefs {
    final manager = $$MatchTableTableManager($_db, $_db.match)
        .filter((f) => f.game.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_matchRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$GameTableFilterComposer extends Composer<_$AppDatabase, $GameTable> {
  $$GameTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get slug => $composableBuilder(
      column: $table.slug, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get apiId => $composableBuilder(
      column: $table.apiId, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<List<PlatformId>, List<PlatformId>, String>
      get platforms => $composableBuilder(
          column: $table.platforms,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<String> get background => $composableBuilder(
      column: $table.background, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<List<String>, List<String>, String>
      get screenshots => $composableBuilder(
          column: $table.screenshots,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastUpdated => $composableBuilder(
      column: $table.lastUpdated, builder: (column) => ColumnFilters(column));

  Expression<bool> matchRefs(
      Expression<bool> Function($$MatchTableFilterComposer f) f) {
    final $$MatchTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.match,
        getReferencedColumn: (t) => t.game,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MatchTableFilterComposer(
              $db: $db,
              $table: $db.match,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$GameTableOrderingComposer extends Composer<_$AppDatabase, $GameTable> {
  $$GameTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get slug => $composableBuilder(
      column: $table.slug, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get apiId => $composableBuilder(
      column: $table.apiId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get platforms => $composableBuilder(
      column: $table.platforms, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get background => $composableBuilder(
      column: $table.background, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get screenshots => $composableBuilder(
      column: $table.screenshots, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastUpdated => $composableBuilder(
      column: $table.lastUpdated, builder: (column) => ColumnOrderings(column));
}

class $$GameTableAnnotationComposer
    extends Composer<_$AppDatabase, $GameTable> {
  $$GameTableAnnotationComposer({
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

  GeneratedColumn<String> get slug =>
      $composableBuilder(column: $table.slug, builder: (column) => column);

  GeneratedColumn<int> get apiId =>
      $composableBuilder(column: $table.apiId, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<PlatformId>, String> get platforms =>
      $composableBuilder(column: $table.platforms, builder: (column) => column);

  GeneratedColumn<String> get background => $composableBuilder(
      column: $table.background, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<String>, String> get screenshots =>
      $composableBuilder(
          column: $table.screenshots, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<DateTime> get lastUpdated => $composableBuilder(
      column: $table.lastUpdated, builder: (column) => column);

  Expression<T> matchRefs<T extends Object>(
      Expression<T> Function($$MatchTableAnnotationComposer a) f) {
    final $$MatchTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.match,
        getReferencedColumn: (t) => t.game,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MatchTableAnnotationComposer(
              $db: $db,
              $table: $db.match,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$GameTableTableManager extends RootTableManager<
    _$AppDatabase,
    $GameTable,
    GameData,
    $$GameTableFilterComposer,
    $$GameTableOrderingComposer,
    $$GameTableAnnotationComposer,
    $$GameTableCreateCompanionBuilder,
    $$GameTableUpdateCompanionBuilder,
    (GameData, $$GameTableReferences),
    GameData,
    PrefetchHooks Function({bool matchRefs})> {
  $$GameTableTableManager(_$AppDatabase db, $GameTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GameTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GameTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GameTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> slug = const Value.absent(),
            Value<int> apiId = const Value.absent(),
            Value<List<PlatformId>> platforms = const Value.absent(),
            Value<String?> background = const Value.absent(),
            Value<List<String>> screenshots = const Value.absent(),
            Value<String> description = const Value.absent(),
            Value<DateTime> lastUpdated = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              GameCompanion(
            id: id,
            name: name,
            slug: slug,
            apiId: apiId,
            platforms: platforms,
            background: background,
            screenshots: screenshots,
            description: description,
            lastUpdated: lastUpdated,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            required String slug,
            required int apiId,
            required List<PlatformId> platforms,
            Value<String?> background = const Value.absent(),
            required List<String> screenshots,
            required String description,
            Value<DateTime> lastUpdated = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              GameCompanion.insert(
            id: id,
            name: name,
            slug: slug,
            apiId: apiId,
            platforms: platforms,
            background: background,
            screenshots: screenshots,
            description: description,
            lastUpdated: lastUpdated,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$GameTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({matchRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (matchRefs) db.match],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (matchRefs)
                    await $_getPrefetchedData<GameData, $GameTable, MatchData>(
                        currentTable: table,
                        referencedTable:
                            $$GameTableReferences._matchRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$GameTableReferences(db, table, p0).matchRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) =>
                                referencedItems.where((e) => e.game == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$GameTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $GameTable,
    GameData,
    $$GameTableFilterComposer,
    $$GameTableOrderingComposer,
    $$GameTableAnnotationComposer,
    $$GameTableCreateCompanionBuilder,
    $$GameTableUpdateCompanionBuilder,
    (GameData, $$GameTableReferences),
    GameData,
    PrefetchHooks Function({bool matchRefs})>;
typedef $$MatchTableCreateCompanionBuilder = MatchCompanion Function({
  required String id,
  required String game,
  required String title,
  required PlatformId platform,
  required DateTime date,
  required String user,
  required String description,
  required int duration,
  required bool private,
  Value<String?> tournament,
  required MatchStatus status,
  required List<String> joined,
  required List<String> inviteds,
  Value<DateTime> lastUpdated,
  Value<int> rowid,
});
typedef $$MatchTableUpdateCompanionBuilder = MatchCompanion Function({
  Value<String> id,
  Value<String> game,
  Value<String> title,
  Value<PlatformId> platform,
  Value<DateTime> date,
  Value<String> user,
  Value<String> description,
  Value<int> duration,
  Value<bool> private,
  Value<String?> tournament,
  Value<MatchStatus> status,
  Value<List<String>> joined,
  Value<List<String>> inviteds,
  Value<DateTime> lastUpdated,
  Value<int> rowid,
});

final class $$MatchTableReferences
    extends BaseReferences<_$AppDatabase, $MatchTable, MatchData> {
  $$MatchTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $GameTable _gameTable(_$AppDatabase db) =>
      db.game.createAlias($_aliasNameGenerator(db.match.game, db.game.id));

  $$GameTableProcessedTableManager get game {
    final $_column = $_itemColumn<String>('game')!;

    final manager = $$GameTableTableManager($_db, $_db.game)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_gameTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $UserTable _userTable(_$AppDatabase db) =>
      db.user.createAlias($_aliasNameGenerator(db.match.user, db.user.id));

  $$UserTableProcessedTableManager get user {
    final $_column = $_itemColumn<String>('user')!;

    final manager = $$UserTableTableManager($_db, $_db.user)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$MatchTableFilterComposer extends Composer<_$AppDatabase, $MatchTable> {
  $$MatchTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<PlatformId, PlatformId, int> get platform =>
      $composableBuilder(
          column: $table.platform,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get duration => $composableBuilder(
      column: $table.duration, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get private => $composableBuilder(
      column: $table.private, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tournament => $composableBuilder(
      column: $table.tournament, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<MatchStatus, MatchStatus, int> get status =>
      $composableBuilder(
          column: $table.status,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnWithTypeConverterFilters<List<String>, List<String>, String>
      get joined => $composableBuilder(
          column: $table.joined,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnWithTypeConverterFilters<List<String>, List<String>, String>
      get inviteds => $composableBuilder(
          column: $table.inviteds,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<DateTime> get lastUpdated => $composableBuilder(
      column: $table.lastUpdated, builder: (column) => ColumnFilters(column));

  $$GameTableFilterComposer get game {
    final $$GameTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.game,
        referencedTable: $db.game,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GameTableFilterComposer(
              $db: $db,
              $table: $db.game,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$UserTableFilterComposer get user {
    final $$UserTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.user,
        referencedTable: $db.user,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UserTableFilterComposer(
              $db: $db,
              $table: $db.user,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$MatchTableOrderingComposer
    extends Composer<_$AppDatabase, $MatchTable> {
  $$MatchTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get platform => $composableBuilder(
      column: $table.platform, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get duration => $composableBuilder(
      column: $table.duration, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get private => $composableBuilder(
      column: $table.private, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tournament => $composableBuilder(
      column: $table.tournament, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get joined => $composableBuilder(
      column: $table.joined, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get inviteds => $composableBuilder(
      column: $table.inviteds, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastUpdated => $composableBuilder(
      column: $table.lastUpdated, builder: (column) => ColumnOrderings(column));

  $$GameTableOrderingComposer get game {
    final $$GameTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.game,
        referencedTable: $db.game,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GameTableOrderingComposer(
              $db: $db,
              $table: $db.game,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$UserTableOrderingComposer get user {
    final $$UserTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.user,
        referencedTable: $db.user,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UserTableOrderingComposer(
              $db: $db,
              $table: $db.user,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$MatchTableAnnotationComposer
    extends Composer<_$AppDatabase, $MatchTable> {
  $$MatchTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumnWithTypeConverter<PlatformId, int> get platform =>
      $composableBuilder(column: $table.platform, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<int> get duration =>
      $composableBuilder(column: $table.duration, builder: (column) => column);

  GeneratedColumn<bool> get private =>
      $composableBuilder(column: $table.private, builder: (column) => column);

  GeneratedColumn<String> get tournament => $composableBuilder(
      column: $table.tournament, builder: (column) => column);

  GeneratedColumnWithTypeConverter<MatchStatus, int> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<String>, String> get joined =>
      $composableBuilder(column: $table.joined, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<String>, String> get inviteds =>
      $composableBuilder(column: $table.inviteds, builder: (column) => column);

  GeneratedColumn<DateTime> get lastUpdated => $composableBuilder(
      column: $table.lastUpdated, builder: (column) => column);

  $$GameTableAnnotationComposer get game {
    final $$GameTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.game,
        referencedTable: $db.game,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GameTableAnnotationComposer(
              $db: $db,
              $table: $db.game,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$UserTableAnnotationComposer get user {
    final $$UserTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.user,
        referencedTable: $db.user,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UserTableAnnotationComposer(
              $db: $db,
              $table: $db.user,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$MatchTableTableManager extends RootTableManager<
    _$AppDatabase,
    $MatchTable,
    MatchData,
    $$MatchTableFilterComposer,
    $$MatchTableOrderingComposer,
    $$MatchTableAnnotationComposer,
    $$MatchTableCreateCompanionBuilder,
    $$MatchTableUpdateCompanionBuilder,
    (MatchData, $$MatchTableReferences),
    MatchData,
    PrefetchHooks Function({bool game, bool user})> {
  $$MatchTableTableManager(_$AppDatabase db, $MatchTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MatchTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MatchTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MatchTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> game = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<PlatformId> platform = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            Value<String> user = const Value.absent(),
            Value<String> description = const Value.absent(),
            Value<int> duration = const Value.absent(),
            Value<bool> private = const Value.absent(),
            Value<String?> tournament = const Value.absent(),
            Value<MatchStatus> status = const Value.absent(),
            Value<List<String>> joined = const Value.absent(),
            Value<List<String>> inviteds = const Value.absent(),
            Value<DateTime> lastUpdated = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              MatchCompanion(
            id: id,
            game: game,
            title: title,
            platform: platform,
            date: date,
            user: user,
            description: description,
            duration: duration,
            private: private,
            tournament: tournament,
            status: status,
            joined: joined,
            inviteds: inviteds,
            lastUpdated: lastUpdated,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String game,
            required String title,
            required PlatformId platform,
            required DateTime date,
            required String user,
            required String description,
            required int duration,
            required bool private,
            Value<String?> tournament = const Value.absent(),
            required MatchStatus status,
            required List<String> joined,
            required List<String> inviteds,
            Value<DateTime> lastUpdated = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              MatchCompanion.insert(
            id: id,
            game: game,
            title: title,
            platform: platform,
            date: date,
            user: user,
            description: description,
            duration: duration,
            private: private,
            tournament: tournament,
            status: status,
            joined: joined,
            inviteds: inviteds,
            lastUpdated: lastUpdated,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$MatchTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({game = false, user = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (game) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.game,
                    referencedTable: $$MatchTableReferences._gameTable(db),
                    referencedColumn: $$MatchTableReferences._gameTable(db).id,
                  ) as T;
                }
                if (user) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.user,
                    referencedTable: $$MatchTableReferences._userTable(db),
                    referencedColumn: $$MatchTableReferences._userTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$MatchTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $MatchTable,
    MatchData,
    $$MatchTableFilterComposer,
    $$MatchTableOrderingComposer,
    $$MatchTableAnnotationComposer,
    $$MatchTableCreateCompanionBuilder,
    $$MatchTableUpdateCompanionBuilder,
    (MatchData, $$MatchTableReferences),
    MatchData,
    PrefetchHooks Function({bool game, bool user})>;
typedef $$ConversationTableCreateCompanionBuilder = ConversationCompanion
    Function({
  required String conversationId,
  Value<bool> hasReachedEnd,
  Value<int> rowid,
});
typedef $$ConversationTableUpdateCompanionBuilder = ConversationCompanion
    Function({
  Value<String> conversationId,
  Value<bool> hasReachedEnd,
  Value<int> rowid,
});

class $$ConversationTableFilterComposer
    extends Composer<_$AppDatabase, $ConversationTable> {
  $$ConversationTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get conversationId => $composableBuilder(
      column: $table.conversationId,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get hasReachedEnd => $composableBuilder(
      column: $table.hasReachedEnd, builder: (column) => ColumnFilters(column));
}

class $$ConversationTableOrderingComposer
    extends Composer<_$AppDatabase, $ConversationTable> {
  $$ConversationTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get conversationId => $composableBuilder(
      column: $table.conversationId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get hasReachedEnd => $composableBuilder(
      column: $table.hasReachedEnd,
      builder: (column) => ColumnOrderings(column));
}

class $$ConversationTableAnnotationComposer
    extends Composer<_$AppDatabase, $ConversationTable> {
  $$ConversationTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get conversationId => $composableBuilder(
      column: $table.conversationId, builder: (column) => column);

  GeneratedColumn<bool> get hasReachedEnd => $composableBuilder(
      column: $table.hasReachedEnd, builder: (column) => column);
}

class $$ConversationTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ConversationTable,
    ConversationData,
    $$ConversationTableFilterComposer,
    $$ConversationTableOrderingComposer,
    $$ConversationTableAnnotationComposer,
    $$ConversationTableCreateCompanionBuilder,
    $$ConversationTableUpdateCompanionBuilder,
    (
      ConversationData,
      BaseReferences<_$AppDatabase, $ConversationTable, ConversationData>
    ),
    ConversationData,
    PrefetchHooks Function()> {
  $$ConversationTableTableManager(_$AppDatabase db, $ConversationTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ConversationTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ConversationTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ConversationTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> conversationId = const Value.absent(),
            Value<bool> hasReachedEnd = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ConversationCompanion(
            conversationId: conversationId,
            hasReachedEnd: hasReachedEnd,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String conversationId,
            Value<bool> hasReachedEnd = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ConversationCompanion.insert(
            conversationId: conversationId,
            hasReachedEnd: hasReachedEnd,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ConversationTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ConversationTable,
    ConversationData,
    $$ConversationTableFilterComposer,
    $$ConversationTableOrderingComposer,
    $$ConversationTableAnnotationComposer,
    $$ConversationTableCreateCompanionBuilder,
    $$ConversationTableUpdateCompanionBuilder,
    (
      ConversationData,
      BaseReferences<_$AppDatabase, $ConversationTable, ConversationData>
    ),
    ConversationData,
    PrefetchHooks Function()>;
typedef $$ChatMessageTableCreateCompanionBuilder = ChatMessageCompanion
    Function({
  required String id,
  required ChatMessageStatus status,
  required String content,
  required String conversation,
  required String creator,
  required DateTime date,
  Value<DateTime?> updatedAt,
  Value<String?> parentMessage,
  required ChatMessageType type,
  Value<bool> pending,
  Value<int> rowid,
});
typedef $$ChatMessageTableUpdateCompanionBuilder = ChatMessageCompanion
    Function({
  Value<String> id,
  Value<ChatMessageStatus> status,
  Value<String> content,
  Value<String> conversation,
  Value<String> creator,
  Value<DateTime> date,
  Value<DateTime?> updatedAt,
  Value<String?> parentMessage,
  Value<ChatMessageType> type,
  Value<bool> pending,
  Value<int> rowid,
});

final class $$ChatMessageTableReferences
    extends BaseReferences<_$AppDatabase, $ChatMessageTable, ChatMessageData> {
  $$ChatMessageTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $UserTable _creatorTable(_$AppDatabase db) => db.user
      .createAlias($_aliasNameGenerator(db.chatMessage.creator, db.user.id));

  $$UserTableProcessedTableManager get creator {
    final $_column = $_itemColumn<String>('creator')!;

    final manager = $$UserTableTableManager($_db, $_db.user)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_creatorTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $ChatMessageTable _parentMessageTable(_$AppDatabase db) =>
      db.chatMessage.createAlias($_aliasNameGenerator(
          db.chatMessage.parentMessage, db.chatMessage.id));

  $$ChatMessageTableProcessedTableManager? get parentMessage {
    final $_column = $_itemColumn<String>('parent_message');
    if ($_column == null) return null;
    final manager = $$ChatMessageTableTableManager($_db, $_db.chatMessage)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_parentMessageTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$AttachmentTable, List<AttachmentData>>
      _attachmentRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
          db.attachment,
          aliasName:
              $_aliasNameGenerator(db.chatMessage.id, db.attachment.message));

  $$AttachmentTableProcessedTableManager get attachmentRefs {
    final manager = $$AttachmentTableTableManager($_db, $_db.attachment)
        .filter((f) => f.message.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_attachmentRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$ChatMessageTableFilterComposer
    extends Composer<_$AppDatabase, $ChatMessageTable> {
  $$ChatMessageTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<ChatMessageStatus, ChatMessageStatus, int>
      get status => $composableBuilder(
          column: $table.status,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get conversation => $composableBuilder(
      column: $table.conversation, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<ChatMessageType, ChatMessageType, int>
      get type => $composableBuilder(
          column: $table.type,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<bool> get pending => $composableBuilder(
      column: $table.pending, builder: (column) => ColumnFilters(column));

  $$UserTableFilterComposer get creator {
    final $$UserTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.creator,
        referencedTable: $db.user,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UserTableFilterComposer(
              $db: $db,
              $table: $db.user,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ChatMessageTableFilterComposer get parentMessage {
    final $$ChatMessageTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.parentMessage,
        referencedTable: $db.chatMessage,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ChatMessageTableFilterComposer(
              $db: $db,
              $table: $db.chatMessage,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> attachmentRefs(
      Expression<bool> Function($$AttachmentTableFilterComposer f) f) {
    final $$AttachmentTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.attachment,
        getReferencedColumn: (t) => t.message,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AttachmentTableFilterComposer(
              $db: $db,
              $table: $db.attachment,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ChatMessageTableOrderingComposer
    extends Composer<_$AppDatabase, $ChatMessageTable> {
  $$ChatMessageTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get conversation => $composableBuilder(
      column: $table.conversation,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get pending => $composableBuilder(
      column: $table.pending, builder: (column) => ColumnOrderings(column));

  $$UserTableOrderingComposer get creator {
    final $$UserTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.creator,
        referencedTable: $db.user,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UserTableOrderingComposer(
              $db: $db,
              $table: $db.user,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ChatMessageTableOrderingComposer get parentMessage {
    final $$ChatMessageTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.parentMessage,
        referencedTable: $db.chatMessage,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ChatMessageTableOrderingComposer(
              $db: $db,
              $table: $db.chatMessage,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ChatMessageTableAnnotationComposer
    extends Composer<_$AppDatabase, $ChatMessageTable> {
  $$ChatMessageTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<ChatMessageStatus, int> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<String> get conversation => $composableBuilder(
      column: $table.conversation, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumnWithTypeConverter<ChatMessageType, int> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<bool> get pending =>
      $composableBuilder(column: $table.pending, builder: (column) => column);

  $$UserTableAnnotationComposer get creator {
    final $$UserTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.creator,
        referencedTable: $db.user,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UserTableAnnotationComposer(
              $db: $db,
              $table: $db.user,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ChatMessageTableAnnotationComposer get parentMessage {
    final $$ChatMessageTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.parentMessage,
        referencedTable: $db.chatMessage,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ChatMessageTableAnnotationComposer(
              $db: $db,
              $table: $db.chatMessage,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> attachmentRefs<T extends Object>(
      Expression<T> Function($$AttachmentTableAnnotationComposer a) f) {
    final $$AttachmentTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.attachment,
        getReferencedColumn: (t) => t.message,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AttachmentTableAnnotationComposer(
              $db: $db,
              $table: $db.attachment,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ChatMessageTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ChatMessageTable,
    ChatMessageData,
    $$ChatMessageTableFilterComposer,
    $$ChatMessageTableOrderingComposer,
    $$ChatMessageTableAnnotationComposer,
    $$ChatMessageTableCreateCompanionBuilder,
    $$ChatMessageTableUpdateCompanionBuilder,
    (ChatMessageData, $$ChatMessageTableReferences),
    ChatMessageData,
    PrefetchHooks Function(
        {bool creator, bool parentMessage, bool attachmentRefs})> {
  $$ChatMessageTableTableManager(_$AppDatabase db, $ChatMessageTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ChatMessageTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ChatMessageTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ChatMessageTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<ChatMessageStatus> status = const Value.absent(),
            Value<String> content = const Value.absent(),
            Value<String> conversation = const Value.absent(),
            Value<String> creator = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<String?> parentMessage = const Value.absent(),
            Value<ChatMessageType> type = const Value.absent(),
            Value<bool> pending = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ChatMessageCompanion(
            id: id,
            status: status,
            content: content,
            conversation: conversation,
            creator: creator,
            date: date,
            updatedAt: updatedAt,
            parentMessage: parentMessage,
            type: type,
            pending: pending,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required ChatMessageStatus status,
            required String content,
            required String conversation,
            required String creator,
            required DateTime date,
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<String?> parentMessage = const Value.absent(),
            required ChatMessageType type,
            Value<bool> pending = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ChatMessageCompanion.insert(
            id: id,
            status: status,
            content: content,
            conversation: conversation,
            creator: creator,
            date: date,
            updatedAt: updatedAt,
            parentMessage: parentMessage,
            type: type,
            pending: pending,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$ChatMessageTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {creator = false,
              parentMessage = false,
              attachmentRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (attachmentRefs) db.attachment],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (creator) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.creator,
                    referencedTable:
                        $$ChatMessageTableReferences._creatorTable(db),
                    referencedColumn:
                        $$ChatMessageTableReferences._creatorTable(db).id,
                  ) as T;
                }
                if (parentMessage) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.parentMessage,
                    referencedTable:
                        $$ChatMessageTableReferences._parentMessageTable(db),
                    referencedColumn:
                        $$ChatMessageTableReferences._parentMessageTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (attachmentRefs)
                    await $_getPrefetchedData<ChatMessageData,
                            $ChatMessageTable, AttachmentData>(
                        currentTable: table,
                        referencedTable: $$ChatMessageTableReferences
                            ._attachmentRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ChatMessageTableReferences(db, table, p0)
                                .attachmentRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.message == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$ChatMessageTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ChatMessageTable,
    ChatMessageData,
    $$ChatMessageTableFilterComposer,
    $$ChatMessageTableOrderingComposer,
    $$ChatMessageTableAnnotationComposer,
    $$ChatMessageTableCreateCompanionBuilder,
    $$ChatMessageTableUpdateCompanionBuilder,
    (ChatMessageData, $$ChatMessageTableReferences),
    ChatMessageData,
    PrefetchHooks Function(
        {bool creator, bool parentMessage, bool attachmentRefs})>;
typedef $$AttachmentTableCreateCompanionBuilder = AttachmentCompanion Function({
  required String id,
  required String message,
  Value<String?> thumb,
  required String file,
  required AttachmentType type,
  required DateTime createdAt,
  Value<DateTime?> updatedAt,
  Value<int> rowid,
});
typedef $$AttachmentTableUpdateCompanionBuilder = AttachmentCompanion Function({
  Value<String> id,
  Value<String> message,
  Value<String?> thumb,
  Value<String> file,
  Value<AttachmentType> type,
  Value<DateTime> createdAt,
  Value<DateTime?> updatedAt,
  Value<int> rowid,
});

final class $$AttachmentTableReferences
    extends BaseReferences<_$AppDatabase, $AttachmentTable, AttachmentData> {
  $$AttachmentTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ChatMessageTable _messageTable(_$AppDatabase db) =>
      db.chatMessage.createAlias(
          $_aliasNameGenerator(db.attachment.message, db.chatMessage.id));

  $$ChatMessageTableProcessedTableManager get message {
    final $_column = $_itemColumn<String>('message')!;

    final manager = $$ChatMessageTableTableManager($_db, $_db.chatMessage)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_messageTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$AttachmentTableFilterComposer
    extends Composer<_$AppDatabase, $AttachmentTable> {
  $$AttachmentTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get thumb => $composableBuilder(
      column: $table.thumb, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get file => $composableBuilder(
      column: $table.file, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<AttachmentType, AttachmentType, int>
      get type => $composableBuilder(
          column: $table.type,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  $$ChatMessageTableFilterComposer get message {
    final $$ChatMessageTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.message,
        referencedTable: $db.chatMessage,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ChatMessageTableFilterComposer(
              $db: $db,
              $table: $db.chatMessage,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$AttachmentTableOrderingComposer
    extends Composer<_$AppDatabase, $AttachmentTable> {
  $$AttachmentTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get thumb => $composableBuilder(
      column: $table.thumb, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get file => $composableBuilder(
      column: $table.file, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  $$ChatMessageTableOrderingComposer get message {
    final $$ChatMessageTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.message,
        referencedTable: $db.chatMessage,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ChatMessageTableOrderingComposer(
              $db: $db,
              $table: $db.chatMessage,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$AttachmentTableAnnotationComposer
    extends Composer<_$AppDatabase, $AttachmentTable> {
  $$AttachmentTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get thumb =>
      $composableBuilder(column: $table.thumb, builder: (column) => column);

  GeneratedColumn<String> get file =>
      $composableBuilder(column: $table.file, builder: (column) => column);

  GeneratedColumnWithTypeConverter<AttachmentType, int> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$ChatMessageTableAnnotationComposer get message {
    final $$ChatMessageTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.message,
        referencedTable: $db.chatMessage,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ChatMessageTableAnnotationComposer(
              $db: $db,
              $table: $db.chatMessage,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$AttachmentTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AttachmentTable,
    AttachmentData,
    $$AttachmentTableFilterComposer,
    $$AttachmentTableOrderingComposer,
    $$AttachmentTableAnnotationComposer,
    $$AttachmentTableCreateCompanionBuilder,
    $$AttachmentTableUpdateCompanionBuilder,
    (AttachmentData, $$AttachmentTableReferences),
    AttachmentData,
    PrefetchHooks Function({bool message})> {
  $$AttachmentTableTableManager(_$AppDatabase db, $AttachmentTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AttachmentTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AttachmentTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AttachmentTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> message = const Value.absent(),
            Value<String?> thumb = const Value.absent(),
            Value<String> file = const Value.absent(),
            Value<AttachmentType> type = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AttachmentCompanion(
            id: id,
            message: message,
            thumb: thumb,
            file: file,
            type: type,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String message,
            Value<String?> thumb = const Value.absent(),
            required String file,
            required AttachmentType type,
            required DateTime createdAt,
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AttachmentCompanion.insert(
            id: id,
            message: message,
            thumb: thumb,
            file: file,
            type: type,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$AttachmentTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({message = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (message) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.message,
                    referencedTable:
                        $$AttachmentTableReferences._messageTable(db),
                    referencedColumn:
                        $$AttachmentTableReferences._messageTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$AttachmentTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $AttachmentTable,
    AttachmentData,
    $$AttachmentTableFilterComposer,
    $$AttachmentTableOrderingComposer,
    $$AttachmentTableAnnotationComposer,
    $$AttachmentTableCreateCompanionBuilder,
    $$AttachmentTableUpdateCompanionBuilder,
    (AttachmentData, $$AttachmentTableReferences),
    AttachmentData,
    PrefetchHooks Function({bool message})>;
typedef $$NotificationTableCreateCompanionBuilder = NotificationCompanion
    Function({
  required String id,
  required NotificationType type,
  required String title,
  required String thumb,
  Value<String?> sender,
  required String path,
  required bool read,
  required DateTime date,
  Value<int> rowid,
});
typedef $$NotificationTableUpdateCompanionBuilder = NotificationCompanion
    Function({
  Value<String> id,
  Value<NotificationType> type,
  Value<String> title,
  Value<String> thumb,
  Value<String?> sender,
  Value<String> path,
  Value<bool> read,
  Value<DateTime> date,
  Value<int> rowid,
});

final class $$NotificationTableReferences extends BaseReferences<_$AppDatabase,
    $NotificationTable, NotificationData> {
  $$NotificationTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $UserTable _senderTable(_$AppDatabase db) => db.user
      .createAlias($_aliasNameGenerator(db.notification.sender, db.user.id));

  $$UserTableProcessedTableManager? get sender {
    final $_column = $_itemColumn<String>('sender');
    if ($_column == null) return null;
    final manager = $$UserTableTableManager($_db, $_db.user)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_senderTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$NotificationTableFilterComposer
    extends Composer<_$AppDatabase, $NotificationTable> {
  $$NotificationTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<NotificationType, NotificationType, int>
      get type => $composableBuilder(
          column: $table.type,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get thumb => $composableBuilder(
      column: $table.thumb, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get path => $composableBuilder(
      column: $table.path, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get read => $composableBuilder(
      column: $table.read, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  $$UserTableFilterComposer get sender {
    final $$UserTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.sender,
        referencedTable: $db.user,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UserTableFilterComposer(
              $db: $db,
              $table: $db.user,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$NotificationTableOrderingComposer
    extends Composer<_$AppDatabase, $NotificationTable> {
  $$NotificationTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get thumb => $composableBuilder(
      column: $table.thumb, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get path => $composableBuilder(
      column: $table.path, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get read => $composableBuilder(
      column: $table.read, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  $$UserTableOrderingComposer get sender {
    final $$UserTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.sender,
        referencedTable: $db.user,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UserTableOrderingComposer(
              $db: $db,
              $table: $db.user,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$NotificationTableAnnotationComposer
    extends Composer<_$AppDatabase, $NotificationTable> {
  $$NotificationTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<NotificationType, int> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get thumb =>
      $composableBuilder(column: $table.thumb, builder: (column) => column);

  GeneratedColumn<String> get path =>
      $composableBuilder(column: $table.path, builder: (column) => column);

  GeneratedColumn<bool> get read =>
      $composableBuilder(column: $table.read, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  $$UserTableAnnotationComposer get sender {
    final $$UserTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.sender,
        referencedTable: $db.user,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UserTableAnnotationComposer(
              $db: $db,
              $table: $db.user,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$NotificationTableTableManager extends RootTableManager<
    _$AppDatabase,
    $NotificationTable,
    NotificationData,
    $$NotificationTableFilterComposer,
    $$NotificationTableOrderingComposer,
    $$NotificationTableAnnotationComposer,
    $$NotificationTableCreateCompanionBuilder,
    $$NotificationTableUpdateCompanionBuilder,
    (NotificationData, $$NotificationTableReferences),
    NotificationData,
    PrefetchHooks Function({bool sender})> {
  $$NotificationTableTableManager(_$AppDatabase db, $NotificationTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NotificationTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$NotificationTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$NotificationTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<NotificationType> type = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> thumb = const Value.absent(),
            Value<String?> sender = const Value.absent(),
            Value<String> path = const Value.absent(),
            Value<bool> read = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              NotificationCompanion(
            id: id,
            type: type,
            title: title,
            thumb: thumb,
            sender: sender,
            path: path,
            read: read,
            date: date,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required NotificationType type,
            required String title,
            required String thumb,
            Value<String?> sender = const Value.absent(),
            required String path,
            required bool read,
            required DateTime date,
            Value<int> rowid = const Value.absent(),
          }) =>
              NotificationCompanion.insert(
            id: id,
            type: type,
            title: title,
            thumb: thumb,
            sender: sender,
            path: path,
            read: read,
            date: date,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$NotificationTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({sender = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (sender) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.sender,
                    referencedTable:
                        $$NotificationTableReferences._senderTable(db),
                    referencedColumn:
                        $$NotificationTableReferences._senderTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$NotificationTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $NotificationTable,
    NotificationData,
    $$NotificationTableFilterComposer,
    $$NotificationTableOrderingComposer,
    $$NotificationTableAnnotationComposer,
    $$NotificationTableCreateCompanionBuilder,
    $$NotificationTableUpdateCompanionBuilder,
    (NotificationData, $$NotificationTableReferences),
    NotificationData,
    PrefetchHooks Function({bool sender})>;
typedef $$NotificationsConfigTableCreateCompanionBuilder
    = NotificationsConfigCompanion Function({
  required String origin,
  required NotificationConfigurationType type,
  required NotificationConfigurationStatus status,
  Value<DateTime?> changeAt,
  Value<int> rowid,
});
typedef $$NotificationsConfigTableUpdateCompanionBuilder
    = NotificationsConfigCompanion Function({
  Value<String> origin,
  Value<NotificationConfigurationType> type,
  Value<NotificationConfigurationStatus> status,
  Value<DateTime?> changeAt,
  Value<int> rowid,
});

class $$NotificationsConfigTableFilterComposer
    extends Composer<_$AppDatabase, $NotificationsConfigTable> {
  $$NotificationsConfigTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get origin => $composableBuilder(
      column: $table.origin, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<NotificationConfigurationType,
          NotificationConfigurationType, int>
      get type => $composableBuilder(
          column: $table.type,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnWithTypeConverterFilters<NotificationConfigurationStatus,
          NotificationConfigurationStatus, int>
      get status => $composableBuilder(
          column: $table.status,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<DateTime> get changeAt => $composableBuilder(
      column: $table.changeAt, builder: (column) => ColumnFilters(column));
}

class $$NotificationsConfigTableOrderingComposer
    extends Composer<_$AppDatabase, $NotificationsConfigTable> {
  $$NotificationsConfigTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get origin => $composableBuilder(
      column: $table.origin, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get changeAt => $composableBuilder(
      column: $table.changeAt, builder: (column) => ColumnOrderings(column));
}

class $$NotificationsConfigTableAnnotationComposer
    extends Composer<_$AppDatabase, $NotificationsConfigTable> {
  $$NotificationsConfigTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get origin =>
      $composableBuilder(column: $table.origin, builder: (column) => column);

  GeneratedColumnWithTypeConverter<NotificationConfigurationType, int>
      get type =>
          $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumnWithTypeConverter<NotificationConfigurationStatus, int>
      get status => $composableBuilder(
          column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get changeAt =>
      $composableBuilder(column: $table.changeAt, builder: (column) => column);
}

class $$NotificationsConfigTableTableManager extends RootTableManager<
    _$AppDatabase,
    $NotificationsConfigTable,
    NotificationsConfigData,
    $$NotificationsConfigTableFilterComposer,
    $$NotificationsConfigTableOrderingComposer,
    $$NotificationsConfigTableAnnotationComposer,
    $$NotificationsConfigTableCreateCompanionBuilder,
    $$NotificationsConfigTableUpdateCompanionBuilder,
    (
      NotificationsConfigData,
      BaseReferences<_$AppDatabase, $NotificationsConfigTable,
          NotificationsConfigData>
    ),
    NotificationsConfigData,
    PrefetchHooks Function()> {
  $$NotificationsConfigTableTableManager(
      _$AppDatabase db, $NotificationsConfigTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NotificationsConfigTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$NotificationsConfigTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$NotificationsConfigTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> origin = const Value.absent(),
            Value<NotificationConfigurationType> type = const Value.absent(),
            Value<NotificationConfigurationStatus> status =
                const Value.absent(),
            Value<DateTime?> changeAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              NotificationsConfigCompanion(
            origin: origin,
            type: type,
            status: status,
            changeAt: changeAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String origin,
            required NotificationConfigurationType type,
            required NotificationConfigurationStatus status,
            Value<DateTime?> changeAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              NotificationsConfigCompanion.insert(
            origin: origin,
            type: type,
            status: status,
            changeAt: changeAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$NotificationsConfigTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $NotificationsConfigTable,
    NotificationsConfigData,
    $$NotificationsConfigTableFilterComposer,
    $$NotificationsConfigTableOrderingComposer,
    $$NotificationsConfigTableAnnotationComposer,
    $$NotificationsConfigTableCreateCompanionBuilder,
    $$NotificationsConfigTableUpdateCompanionBuilder,
    (
      NotificationsConfigData,
      BaseReferences<_$AppDatabase, $NotificationsConfigTable,
          NotificationsConfigData>
    ),
    NotificationsConfigData,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UserTableTableManager get user => $$UserTableTableManager(_db, _db.user);
  $$FriendshipTableTableManager get friendship =>
      $$FriendshipTableTableManager(_db, _db.friendship);
  $$GameTableTableManager get game => $$GameTableTableManager(_db, _db.game);
  $$MatchTableTableManager get match =>
      $$MatchTableTableManager(_db, _db.match);
  $$ConversationTableTableManager get conversation =>
      $$ConversationTableTableManager(_db, _db.conversation);
  $$ChatMessageTableTableManager get chatMessage =>
      $$ChatMessageTableTableManager(_db, _db.chatMessage);
  $$AttachmentTableTableManager get attachment =>
      $$AttachmentTableTableManager(_db, _db.attachment);
  $$NotificationTableTableManager get notification =>
      $$NotificationTableTableManager(_db, _db.notification);
  $$NotificationsConfigTableTableManager get notificationsConfig =>
      $$NotificationsConfigTableTableManager(_db, _db.notificationsConfig);
}
