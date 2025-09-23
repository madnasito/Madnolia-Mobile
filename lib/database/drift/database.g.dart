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
  @override
  late final GeneratedColumnWithTypeConverter<ConnectionStatus, int>
      connection = GeneratedColumn<int>('connection', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<ConnectionStatus>($UserTable.$converterconnection);
  static const VerificationMeta _lastUpdatedMeta =
      const VerificationMeta('lastUpdated');
  @override
  late final GeneratedColumn<DateTime> lastUpdated = GeneratedColumn<DateTime>(
      'last_updated', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _friendshipIdMeta =
      const VerificationMeta('friendshipId');
  @override
  late final GeneratedColumn<String> friendshipId = GeneratedColumn<String>(
      'friendship_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, username, thumb, connection, lastUpdated, friendshipId];
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
    if (data.containsKey('last_updated')) {
      context.handle(
          _lastUpdatedMeta,
          lastUpdated.isAcceptableOrUnknown(
              data['last_updated']!, _lastUpdatedMeta));
    }
    if (data.containsKey('friendship_id')) {
      context.handle(
          _friendshipIdMeta,
          friendshipId.isAcceptableOrUnknown(
              data['friendship_id']!, _friendshipIdMeta));
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
      connection: $UserTable.$converterconnection.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}connection'])!),
      lastUpdated: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}last_updated'])!,
      friendshipId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}friendship_id']),
    );
  }

  @override
  $UserTable createAlias(String alias) {
    return $UserTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<ConnectionStatus, int, int> $converterconnection =
      const EnumIndexConverter<ConnectionStatus>(ConnectionStatus.values);
}

class UserData extends DataClass implements Insertable<UserData> {
  final String id;
  final String name;
  final String username;
  final String thumb;
  final ConnectionStatus connection;
  final DateTime lastUpdated;
  final String? friendshipId;
  const UserData(
      {required this.id,
      required this.name,
      required this.username,
      required this.thumb,
      required this.connection,
      required this.lastUpdated,
      this.friendshipId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['username'] = Variable<String>(username);
    map['thumb'] = Variable<String>(thumb);
    {
      map['connection'] =
          Variable<int>($UserTable.$converterconnection.toSql(connection));
    }
    map['last_updated'] = Variable<DateTime>(lastUpdated);
    if (!nullToAbsent || friendshipId != null) {
      map['friendship_id'] = Variable<String>(friendshipId);
    }
    return map;
  }

  UserCompanion toCompanion(bool nullToAbsent) {
    return UserCompanion(
      id: Value(id),
      name: Value(name),
      username: Value(username),
      thumb: Value(thumb),
      connection: Value(connection),
      lastUpdated: Value(lastUpdated),
      friendshipId: friendshipId == null && nullToAbsent
          ? const Value.absent()
          : Value(friendshipId),
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
      connection: $UserTable.$converterconnection
          .fromJson(serializer.fromJson<int>(json['connection'])),
      lastUpdated: serializer.fromJson<DateTime>(json['lastUpdated']),
      friendshipId: serializer.fromJson<String?>(json['friendshipId']),
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
      'connection': serializer
          .toJson<int>($UserTable.$converterconnection.toJson(connection)),
      'lastUpdated': serializer.toJson<DateTime>(lastUpdated),
      'friendshipId': serializer.toJson<String?>(friendshipId),
    };
  }

  UserData copyWith(
          {String? id,
          String? name,
          String? username,
          String? thumb,
          ConnectionStatus? connection,
          DateTime? lastUpdated,
          Value<String?> friendshipId = const Value.absent()}) =>
      UserData(
        id: id ?? this.id,
        name: name ?? this.name,
        username: username ?? this.username,
        thumb: thumb ?? this.thumb,
        connection: connection ?? this.connection,
        lastUpdated: lastUpdated ?? this.lastUpdated,
        friendshipId:
            friendshipId.present ? friendshipId.value : this.friendshipId,
      );
  UserData copyWithCompanion(UserCompanion data) {
    return UserData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      username: data.username.present ? data.username.value : this.username,
      thumb: data.thumb.present ? data.thumb.value : this.thumb,
      connection:
          data.connection.present ? data.connection.value : this.connection,
      lastUpdated:
          data.lastUpdated.present ? data.lastUpdated.value : this.lastUpdated,
      friendshipId: data.friendshipId.present
          ? data.friendshipId.value
          : this.friendshipId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('username: $username, ')
          ..write('thumb: $thumb, ')
          ..write('connection: $connection, ')
          ..write('lastUpdated: $lastUpdated, ')
          ..write('friendshipId: $friendshipId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, name, username, thumb, connection, lastUpdated, friendshipId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserData &&
          other.id == this.id &&
          other.name == this.name &&
          other.username == this.username &&
          other.thumb == this.thumb &&
          other.connection == this.connection &&
          other.lastUpdated == this.lastUpdated &&
          other.friendshipId == this.friendshipId);
}

class UserCompanion extends UpdateCompanion<UserData> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> username;
  final Value<String> thumb;
  final Value<ConnectionStatus> connection;
  final Value<DateTime> lastUpdated;
  final Value<String?> friendshipId;
  final Value<int> rowid;
  const UserCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.username = const Value.absent(),
    this.thumb = const Value.absent(),
    this.connection = const Value.absent(),
    this.lastUpdated = const Value.absent(),
    this.friendshipId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UserCompanion.insert({
    required String id,
    required String name,
    required String username,
    required String thumb,
    required ConnectionStatus connection,
    this.lastUpdated = const Value.absent(),
    this.friendshipId = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        username = Value(username),
        thumb = Value(thumb),
        connection = Value(connection);
  static Insertable<UserData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? username,
    Expression<String>? thumb,
    Expression<int>? connection,
    Expression<DateTime>? lastUpdated,
    Expression<String>? friendshipId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (username != null) 'username': username,
      if (thumb != null) 'thumb': thumb,
      if (connection != null) 'connection': connection,
      if (lastUpdated != null) 'last_updated': lastUpdated,
      if (friendshipId != null) 'friendship_id': friendshipId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UserCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String>? username,
      Value<String>? thumb,
      Value<ConnectionStatus>? connection,
      Value<DateTime>? lastUpdated,
      Value<String?>? friendshipId,
      Value<int>? rowid}) {
    return UserCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      username: username ?? this.username,
      thumb: thumb ?? this.thumb,
      connection: connection ?? this.connection,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      friendshipId: friendshipId ?? this.friendshipId,
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
    if (connection.present) {
      map['connection'] = Variable<int>(
          $UserTable.$converterconnection.toSql(connection.value));
    }
    if (lastUpdated.present) {
      map['last_updated'] = Variable<DateTime>(lastUpdated.value);
    }
    if (friendshipId.present) {
      map['friendship_id'] = Variable<String>(friendshipId.value);
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
          ..write('connection: $connection, ')
          ..write('lastUpdated: $lastUpdated, ')
          ..write('friendshipId: $friendshipId, ')
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
  static const VerificationMeta _user1Meta = const VerificationMeta('user1');
  @override
  late final GeneratedColumn<String> user1 = GeneratedColumn<String>(
      'user1', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _user2Meta = const VerificationMeta('user2');
  @override
  late final GeneratedColumn<String> user2 = GeneratedColumn<String>(
      'user2', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
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
      [id, user1, user2, status, createdAt, lastUpdated];
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
    if (data.containsKey('user1')) {
      context.handle(
          _user1Meta, user1.isAcceptableOrUnknown(data['user1']!, _user1Meta));
    } else if (isInserting) {
      context.missing(_user1Meta);
    }
    if (data.containsKey('user2')) {
      context.handle(
          _user2Meta, user2.isAcceptableOrUnknown(data['user2']!, _user2Meta));
    } else if (isInserting) {
      context.missing(_user2Meta);
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
      user1: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user1'])!,
      user2: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user2'])!,
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
  final String user1;
  final String user2;
  final FriendshipStatus status;
  final DateTime createdAt;
  final DateTime lastUpdated;
  const FriendshipData(
      {required this.id,
      required this.user1,
      required this.user2,
      required this.status,
      required this.createdAt,
      required this.lastUpdated});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user1'] = Variable<String>(user1);
    map['user2'] = Variable<String>(user2);
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
      user1: Value(user1),
      user2: Value(user2),
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
      user1: serializer.fromJson<String>(json['user1']),
      user2: serializer.fromJson<String>(json['user2']),
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
      'user1': serializer.toJson<String>(user1),
      'user2': serializer.toJson<String>(user2),
      'status': serializer
          .toJson<int>($FriendshipTable.$converterstatus.toJson(status)),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'lastUpdated': serializer.toJson<DateTime>(lastUpdated),
    };
  }

  FriendshipData copyWith(
          {String? id,
          String? user1,
          String? user2,
          FriendshipStatus? status,
          DateTime? createdAt,
          DateTime? lastUpdated}) =>
      FriendshipData(
        id: id ?? this.id,
        user1: user1 ?? this.user1,
        user2: user2 ?? this.user2,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        lastUpdated: lastUpdated ?? this.lastUpdated,
      );
  FriendshipData copyWithCompanion(FriendshipCompanion data) {
    return FriendshipData(
      id: data.id.present ? data.id.value : this.id,
      user1: data.user1.present ? data.user1.value : this.user1,
      user2: data.user2.present ? data.user2.value : this.user2,
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
          ..write('user1: $user1, ')
          ..write('user2: $user2, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastUpdated: $lastUpdated')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, user1, user2, status, createdAt, lastUpdated);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FriendshipData &&
          other.id == this.id &&
          other.user1 == this.user1 &&
          other.user2 == this.user2 &&
          other.status == this.status &&
          other.createdAt == this.createdAt &&
          other.lastUpdated == this.lastUpdated);
}

class FriendshipCompanion extends UpdateCompanion<FriendshipData> {
  final Value<String> id;
  final Value<String> user1;
  final Value<String> user2;
  final Value<FriendshipStatus> status;
  final Value<DateTime> createdAt;
  final Value<DateTime> lastUpdated;
  final Value<int> rowid;
  const FriendshipCompanion({
    this.id = const Value.absent(),
    this.user1 = const Value.absent(),
    this.user2 = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.lastUpdated = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FriendshipCompanion.insert({
    required String id,
    required String user1,
    required String user2,
    required FriendshipStatus status,
    required DateTime createdAt,
    this.lastUpdated = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        user1 = Value(user1),
        user2 = Value(user2),
        status = Value(status),
        createdAt = Value(createdAt);
  static Insertable<FriendshipData> custom({
    Expression<String>? id,
    Expression<String>? user1,
    Expression<String>? user2,
    Expression<int>? status,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? lastUpdated,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (user1 != null) 'user1': user1,
      if (user2 != null) 'user2': user2,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
      if (lastUpdated != null) 'last_updated': lastUpdated,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FriendshipCompanion copyWith(
      {Value<String>? id,
      Value<String>? user1,
      Value<String>? user2,
      Value<FriendshipStatus>? status,
      Value<DateTime>? createdAt,
      Value<DateTime>? lastUpdated,
      Value<int>? rowid}) {
    return FriendshipCompanion(
      id: id ?? this.id,
      user1: user1 ?? this.user1,
      user2: user2 ?? this.user2,
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
    if (user1.present) {
      map['user1'] = Variable<String>(user1.value);
    }
    if (user2.present) {
      map['user2'] = Variable<String>(user2.value);
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
          ..write('user1: $user1, ')
          ..write('user2: $user2, ')
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
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _platformMeta =
      const VerificationMeta('platform');
  @override
  late final GeneratedColumn<int> platform = GeneratedColumn<int>(
      'platform', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, title, platform, date];
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
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('platform')) {
      context.handle(_platformMeta,
          platform.isAcceptableOrUnknown(data['platform']!, _platformMeta));
    } else if (isInserting) {
      context.missing(_platformMeta);
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
  MatchData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MatchData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      platform: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}platform'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
    );
  }

  @override
  $MatchTable createAlias(String alias) {
    return $MatchTable(attachedDatabase, alias);
  }
}

class MatchData extends DataClass implements Insertable<MatchData> {
  final String id;
  final String title;
  final int platform;
  final DateTime date;
  const MatchData(
      {required this.id,
      required this.title,
      required this.platform,
      required this.date});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['platform'] = Variable<int>(platform);
    map['date'] = Variable<DateTime>(date);
    return map;
  }

  MatchCompanion toCompanion(bool nullToAbsent) {
    return MatchCompanion(
      id: Value(id),
      title: Value(title),
      platform: Value(platform),
      date: Value(date),
    );
  }

  factory MatchData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MatchData(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      platform: serializer.fromJson<int>(json['platform']),
      date: serializer.fromJson<DateTime>(json['date']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'platform': serializer.toJson<int>(platform),
      'date': serializer.toJson<DateTime>(date),
    };
  }

  MatchData copyWith(
          {String? id, String? title, int? platform, DateTime? date}) =>
      MatchData(
        id: id ?? this.id,
        title: title ?? this.title,
        platform: platform ?? this.platform,
        date: date ?? this.date,
      );
  MatchData copyWithCompanion(MatchCompanion data) {
    return MatchData(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      platform: data.platform.present ? data.platform.value : this.platform,
      date: data.date.present ? data.date.value : this.date,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MatchData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('platform: $platform, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, platform, date);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MatchData &&
          other.id == this.id &&
          other.title == this.title &&
          other.platform == this.platform &&
          other.date == this.date);
}

class MatchCompanion extends UpdateCompanion<MatchData> {
  final Value<String> id;
  final Value<String> title;
  final Value<int> platform;
  final Value<DateTime> date;
  final Value<int> rowid;
  const MatchCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.platform = const Value.absent(),
    this.date = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MatchCompanion.insert({
    required String id,
    required String title,
    required int platform,
    required DateTime date,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        title = Value(title),
        platform = Value(platform),
        date = Value(date);
  static Insertable<MatchData> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<int>? platform,
    Expression<DateTime>? date,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (platform != null) 'platform': platform,
      if (date != null) 'date': date,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MatchCompanion copyWith(
      {Value<String>? id,
      Value<String>? title,
      Value<int>? platform,
      Value<DateTime>? date,
      Value<int>? rowid}) {
    return MatchCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      platform: platform ?? this.platform,
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
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (platform.present) {
      map['platform'] = Variable<int>(platform.value);
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
    return (StringBuffer('MatchCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('platform: $platform, ')
          ..write('date: $date, ')
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
  required ConnectionStatus connection,
  Value<DateTime> lastUpdated,
  Value<String?> friendshipId,
  Value<int> rowid,
});
typedef $$UserTableUpdateCompanionBuilder = UserCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String> username,
  Value<String> thumb,
  Value<ConnectionStatus> connection,
  Value<DateTime> lastUpdated,
  Value<String?> friendshipId,
  Value<int> rowid,
});

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

  ColumnWithTypeConverterFilters<ConnectionStatus, ConnectionStatus, int>
      get connection => $composableBuilder(
          column: $table.connection,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<DateTime> get lastUpdated => $composableBuilder(
      column: $table.lastUpdated, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get friendshipId => $composableBuilder(
      column: $table.friendshipId, builder: (column) => ColumnFilters(column));
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

  ColumnOrderings<int> get connection => $composableBuilder(
      column: $table.connection, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastUpdated => $composableBuilder(
      column: $table.lastUpdated, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get friendshipId => $composableBuilder(
      column: $table.friendshipId,
      builder: (column) => ColumnOrderings(column));
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

  GeneratedColumnWithTypeConverter<ConnectionStatus, int> get connection =>
      $composableBuilder(
          column: $table.connection, builder: (column) => column);

  GeneratedColumn<DateTime> get lastUpdated => $composableBuilder(
      column: $table.lastUpdated, builder: (column) => column);

  GeneratedColumn<String> get friendshipId => $composableBuilder(
      column: $table.friendshipId, builder: (column) => column);
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
    (UserData, BaseReferences<_$AppDatabase, $UserTable, UserData>),
    UserData,
    PrefetchHooks Function()> {
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
            Value<ConnectionStatus> connection = const Value.absent(),
            Value<DateTime> lastUpdated = const Value.absent(),
            Value<String?> friendshipId = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              UserCompanion(
            id: id,
            name: name,
            username: username,
            thumb: thumb,
            connection: connection,
            lastUpdated: lastUpdated,
            friendshipId: friendshipId,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            required String username,
            required String thumb,
            required ConnectionStatus connection,
            Value<DateTime> lastUpdated = const Value.absent(),
            Value<String?> friendshipId = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              UserCompanion.insert(
            id: id,
            name: name,
            username: username,
            thumb: thumb,
            connection: connection,
            lastUpdated: lastUpdated,
            friendshipId: friendshipId,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
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
    (UserData, BaseReferences<_$AppDatabase, $UserTable, UserData>),
    UserData,
    PrefetchHooks Function()>;
typedef $$FriendshipTableCreateCompanionBuilder = FriendshipCompanion Function({
  required String id,
  required String user1,
  required String user2,
  required FriendshipStatus status,
  required DateTime createdAt,
  Value<DateTime> lastUpdated,
  Value<int> rowid,
});
typedef $$FriendshipTableUpdateCompanionBuilder = FriendshipCompanion Function({
  Value<String> id,
  Value<String> user1,
  Value<String> user2,
  Value<FriendshipStatus> status,
  Value<DateTime> createdAt,
  Value<DateTime> lastUpdated,
  Value<int> rowid,
});

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

  ColumnFilters<String> get user1 => $composableBuilder(
      column: $table.user1, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get user2 => $composableBuilder(
      column: $table.user2, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<FriendshipStatus, FriendshipStatus, int>
      get status => $composableBuilder(
          column: $table.status,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastUpdated => $composableBuilder(
      column: $table.lastUpdated, builder: (column) => ColumnFilters(column));
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

  ColumnOrderings<String> get user1 => $composableBuilder(
      column: $table.user1, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get user2 => $composableBuilder(
      column: $table.user2, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastUpdated => $composableBuilder(
      column: $table.lastUpdated, builder: (column) => ColumnOrderings(column));
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

  GeneratedColumn<String> get user1 =>
      $composableBuilder(column: $table.user1, builder: (column) => column);

  GeneratedColumn<String> get user2 =>
      $composableBuilder(column: $table.user2, builder: (column) => column);

  GeneratedColumnWithTypeConverter<FriendshipStatus, int> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get lastUpdated => $composableBuilder(
      column: $table.lastUpdated, builder: (column) => column);
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
    (
      FriendshipData,
      BaseReferences<_$AppDatabase, $FriendshipTable, FriendshipData>
    ),
    FriendshipData,
    PrefetchHooks Function()> {
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
            Value<String> user1 = const Value.absent(),
            Value<String> user2 = const Value.absent(),
            Value<FriendshipStatus> status = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> lastUpdated = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              FriendshipCompanion(
            id: id,
            user1: user1,
            user2: user2,
            status: status,
            createdAt: createdAt,
            lastUpdated: lastUpdated,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String user1,
            required String user2,
            required FriendshipStatus status,
            required DateTime createdAt,
            Value<DateTime> lastUpdated = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              FriendshipCompanion.insert(
            id: id,
            user1: user1,
            user2: user2,
            status: status,
            createdAt: createdAt,
            lastUpdated: lastUpdated,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
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
    (
      FriendshipData,
      BaseReferences<_$AppDatabase, $FriendshipTable, FriendshipData>
    ),
    FriendshipData,
    PrefetchHooks Function()>;
typedef $$MatchTableCreateCompanionBuilder = MatchCompanion Function({
  required String id,
  required String title,
  required int platform,
  required DateTime date,
  Value<int> rowid,
});
typedef $$MatchTableUpdateCompanionBuilder = MatchCompanion Function({
  Value<String> id,
  Value<String> title,
  Value<int> platform,
  Value<DateTime> date,
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

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get platform => $composableBuilder(
      column: $table.platform, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));
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

  GeneratedColumn<int> get platform =>
      $composableBuilder(column: $table.platform, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);
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
            Value<String> title = const Value.absent(),
            Value<int> platform = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              MatchCompanion(
            id: id,
            title: title,
            platform: platform,
            date: date,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String title,
            required int platform,
            required DateTime date,
            Value<int> rowid = const Value.absent(),
          }) =>
              MatchCompanion.insert(
            id: id,
            title: title,
            platform: platform,
            date: date,
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
