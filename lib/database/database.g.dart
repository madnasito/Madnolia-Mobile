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
      type: DriftSqlType.string, requiredDuringInsert: true);
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
      type: DriftSqlType.string, requiredDuringInsert: true);
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
        inviteds
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
      required this.inviteds});
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
          List<String>? inviteds}) =>
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
          ..write('inviteds: $inviteds')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, game, title, platform, date, user,
      description, duration, private, tournament, status, joined, inviteds);
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
          other.inviteds == this.inviteds);
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
  late final $MatchTable match = $MatchTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [user, friendship, match];
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
    PrefetchHooks Function({bool friendshipRefs})> {
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
          prefetchHooksCallback: ({friendshipRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (friendshipRefs) db.friendship],
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
    PrefetchHooks Function({bool friendshipRefs})>;
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
  Value<int> rowid,
});

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

  ColumnFilters<String> get game => $composableBuilder(
      column: $table.game, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<PlatformId, PlatformId, int> get platform =>
      $composableBuilder(
          column: $table.platform,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get user => $composableBuilder(
      column: $table.user, builder: (column) => ColumnFilters(column));

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

  ColumnOrderings<String> get game => $composableBuilder(
      column: $table.game, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get platform => $composableBuilder(
      column: $table.platform, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get user => $composableBuilder(
      column: $table.user, builder: (column) => ColumnOrderings(column));

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

  GeneratedColumn<String> get game =>
      $composableBuilder(column: $table.game, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumnWithTypeConverter<PlatformId, int> get platform =>
      $composableBuilder(column: $table.platform, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get user =>
      $composableBuilder(column: $table.user, builder: (column) => column);

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
    (MatchData, BaseReferences<_$AppDatabase, $MatchTable, MatchData>),
    MatchData,
    PrefetchHooks Function()> {
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
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
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
    (MatchData, BaseReferences<_$AppDatabase, $MatchTable, MatchData>),
    MatchData,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UserTableTableManager get user => $$UserTableTableManager(_db, _db.user);
  $$FriendshipTableTableManager get friendship =>
      $$FriendshipTableTableManager(_db, _db.friendship);
  $$MatchTableTableManager get match =>
      $$MatchTableTableManager(_db, _db.match);
}
