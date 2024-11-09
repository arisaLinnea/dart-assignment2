// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $DBOwnersTable extends DBOwners with TableInfo<$DBOwnersTable, DBOwner> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DBOwnersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => uuid.v4());
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _ssnMeta = const VerificationMeta('ssn');
  @override
  late final GeneratedColumn<String> ssn = GeneratedColumn<String>(
      'ssn', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 10, maxTextLength: 12),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, name, ssn];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'd_b_owners';
  @override
  VerificationContext validateIntegrity(Insertable<DBOwner> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('ssn')) {
      context.handle(
          _ssnMeta, ssn.isAcceptableOrUnknown(data['ssn']!, _ssnMeta));
    } else if (isInserting) {
      context.missing(_ssnMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DBOwner map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DBOwner(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id']),
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      ssn: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}ssn'])!,
    );
  }

  @override
  $DBOwnersTable createAlias(String alias) {
    return $DBOwnersTable(attachedDatabase, alias);
  }
}

class DBOwner extends DataClass implements Insertable<DBOwner> {
  final String? id;
  final String name;
  final String ssn;
  const DBOwner({this.id, required this.name, required this.ssn});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<String>(id);
    }
    map['name'] = Variable<String>(name);
    map['ssn'] = Variable<String>(ssn);
    return map;
  }

  DBOwnersCompanion toCompanion(bool nullToAbsent) {
    return DBOwnersCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: Value(name),
      ssn: Value(ssn),
    );
  }

  factory DBOwner.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DBOwner(
      id: serializer.fromJson<String?>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      ssn: serializer.fromJson<String>(json['ssn']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String?>(id),
      'name': serializer.toJson<String>(name),
      'ssn': serializer.toJson<String>(ssn),
    };
  }

  DBOwner copyWith(
          {Value<String?> id = const Value.absent(),
          String? name,
          String? ssn}) =>
      DBOwner(
        id: id.present ? id.value : this.id,
        name: name ?? this.name,
        ssn: ssn ?? this.ssn,
      );
  DBOwner copyWithCompanion(DBOwnersCompanion data) {
    return DBOwner(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      ssn: data.ssn.present ? data.ssn.value : this.ssn,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DBOwner(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('ssn: $ssn')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, ssn);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DBOwner &&
          other.id == this.id &&
          other.name == this.name &&
          other.ssn == this.ssn);
}

class DBOwnersCompanion extends UpdateCompanion<DBOwner> {
  final Value<String?> id;
  final Value<String> name;
  final Value<String> ssn;
  final Value<int> rowid;
  const DBOwnersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.ssn = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DBOwnersCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String ssn,
    this.rowid = const Value.absent(),
  })  : name = Value(name),
        ssn = Value(ssn);
  static Insertable<DBOwner> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? ssn,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (ssn != null) 'ssn': ssn,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DBOwnersCompanion copyWith(
      {Value<String?>? id,
      Value<String>? name,
      Value<String>? ssn,
      Value<int>? rowid}) {
    return DBOwnersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      ssn: ssn ?? this.ssn,
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
    if (ssn.present) {
      map['ssn'] = Variable<String>(ssn.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DBOwnersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('ssn: $ssn, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DBAddressesTable extends DBAddresses
    with TableInfo<$DBAddressesTable, DBAddress> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DBAddressesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => uuid.v4());
  static const VerificationMeta _streetMeta = const VerificationMeta('street');
  @override
  late final GeneratedColumn<String> street = GeneratedColumn<String>(
      'street', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _zipCodeMeta =
      const VerificationMeta('zipCode');
  @override
  late final GeneratedColumn<String> zipCode = GeneratedColumn<String>(
      'zip_code', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _cityMeta = const VerificationMeta('city');
  @override
  late final GeneratedColumn<String> city = GeneratedColumn<String>(
      'city', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, street, zipCode, city];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'd_b_addresses';
  @override
  VerificationContext validateIntegrity(Insertable<DBAddress> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('street')) {
      context.handle(_streetMeta,
          street.isAcceptableOrUnknown(data['street']!, _streetMeta));
    } else if (isInserting) {
      context.missing(_streetMeta);
    }
    if (data.containsKey('zip_code')) {
      context.handle(_zipCodeMeta,
          zipCode.isAcceptableOrUnknown(data['zip_code']!, _zipCodeMeta));
    } else if (isInserting) {
      context.missing(_zipCodeMeta);
    }
    if (data.containsKey('city')) {
      context.handle(
          _cityMeta, city.isAcceptableOrUnknown(data['city']!, _cityMeta));
    } else if (isInserting) {
      context.missing(_cityMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DBAddress map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DBAddress(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      street: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}street'])!,
      zipCode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}zip_code'])!,
      city: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}city'])!,
    );
  }

  @override
  $DBAddressesTable createAlias(String alias) {
    return $DBAddressesTable(attachedDatabase, alias);
  }
}

class DBAddress extends DataClass implements Insertable<DBAddress> {
  final String id;
  final String street;
  final String zipCode;
  final String city;
  const DBAddress(
      {required this.id,
      required this.street,
      required this.zipCode,
      required this.city});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['street'] = Variable<String>(street);
    map['zip_code'] = Variable<String>(zipCode);
    map['city'] = Variable<String>(city);
    return map;
  }

  DBAddressesCompanion toCompanion(bool nullToAbsent) {
    return DBAddressesCompanion(
      id: Value(id),
      street: Value(street),
      zipCode: Value(zipCode),
      city: Value(city),
    );
  }

  factory DBAddress.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DBAddress(
      id: serializer.fromJson<String>(json['id']),
      street: serializer.fromJson<String>(json['street']),
      zipCode: serializer.fromJson<String>(json['zipCode']),
      city: serializer.fromJson<String>(json['city']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'street': serializer.toJson<String>(street),
      'zipCode': serializer.toJson<String>(zipCode),
      'city': serializer.toJson<String>(city),
    };
  }

  DBAddress copyWith(
          {String? id, String? street, String? zipCode, String? city}) =>
      DBAddress(
        id: id ?? this.id,
        street: street ?? this.street,
        zipCode: zipCode ?? this.zipCode,
        city: city ?? this.city,
      );
  DBAddress copyWithCompanion(DBAddressesCompanion data) {
    return DBAddress(
      id: data.id.present ? data.id.value : this.id,
      street: data.street.present ? data.street.value : this.street,
      zipCode: data.zipCode.present ? data.zipCode.value : this.zipCode,
      city: data.city.present ? data.city.value : this.city,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DBAddress(')
          ..write('id: $id, ')
          ..write('street: $street, ')
          ..write('zipCode: $zipCode, ')
          ..write('city: $city')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, street, zipCode, city);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DBAddress &&
          other.id == this.id &&
          other.street == this.street &&
          other.zipCode == this.zipCode &&
          other.city == this.city);
}

class DBAddressesCompanion extends UpdateCompanion<DBAddress> {
  final Value<String> id;
  final Value<String> street;
  final Value<String> zipCode;
  final Value<String> city;
  final Value<int> rowid;
  const DBAddressesCompanion({
    this.id = const Value.absent(),
    this.street = const Value.absent(),
    this.zipCode = const Value.absent(),
    this.city = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DBAddressesCompanion.insert({
    this.id = const Value.absent(),
    required String street,
    required String zipCode,
    required String city,
    this.rowid = const Value.absent(),
  })  : street = Value(street),
        zipCode = Value(zipCode),
        city = Value(city);
  static Insertable<DBAddress> custom({
    Expression<String>? id,
    Expression<String>? street,
    Expression<String>? zipCode,
    Expression<String>? city,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (street != null) 'street': street,
      if (zipCode != null) 'zip_code': zipCode,
      if (city != null) 'city': city,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DBAddressesCompanion copyWith(
      {Value<String>? id,
      Value<String>? street,
      Value<String>? zipCode,
      Value<String>? city,
      Value<int>? rowid}) {
    return DBAddressesCompanion(
      id: id ?? this.id,
      street: street ?? this.street,
      zipCode: zipCode ?? this.zipCode,
      city: city ?? this.city,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (street.present) {
      map['street'] = Variable<String>(street.value);
    }
    if (zipCode.present) {
      map['zip_code'] = Variable<String>(zipCode.value);
    }
    if (city.present) {
      map['city'] = Variable<String>(city.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DBAddressesCompanion(')
          ..write('id: $id, ')
          ..write('street: $street, ')
          ..write('zipCode: $zipCode, ')
          ..write('city: $city, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DBParkinglotsTable extends DBParkinglots
    with TableInfo<$DBParkinglotsTable, DBParkinglot> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DBParkinglotsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => uuid.v4());
  static const VerificationMeta _addressIdMeta =
      const VerificationMeta('addressId');
  @override
  late final GeneratedColumn<String> addressId = GeneratedColumn<String>(
      'address_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL REFERENCES d_b_addresses(id)');
  static const VerificationMeta _hourlyPriceMeta =
      const VerificationMeta('hourlyPrice');
  @override
  late final GeneratedColumn<double> hourlyPrice = GeneratedColumn<double>(
      'hourly_price', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, addressId, hourlyPrice];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'd_b_parkinglots';
  @override
  VerificationContext validateIntegrity(Insertable<DBParkinglot> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('address_id')) {
      context.handle(_addressIdMeta,
          addressId.isAcceptableOrUnknown(data['address_id']!, _addressIdMeta));
    } else if (isInserting) {
      context.missing(_addressIdMeta);
    }
    if (data.containsKey('hourly_price')) {
      context.handle(
          _hourlyPriceMeta,
          hourlyPrice.isAcceptableOrUnknown(
              data['hourly_price']!, _hourlyPriceMeta));
    } else if (isInserting) {
      context.missing(_hourlyPriceMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DBParkinglot map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DBParkinglot(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      addressId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}address_id'])!,
      hourlyPrice: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}hourly_price'])!,
    );
  }

  @override
  $DBParkinglotsTable createAlias(String alias) {
    return $DBParkinglotsTable(attachedDatabase, alias);
  }
}

class DBParkinglot extends DataClass implements Insertable<DBParkinglot> {
  final String id;
  final String addressId;
  final double hourlyPrice;
  const DBParkinglot(
      {required this.id, required this.addressId, required this.hourlyPrice});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['address_id'] = Variable<String>(addressId);
    map['hourly_price'] = Variable<double>(hourlyPrice);
    return map;
  }

  DBParkinglotsCompanion toCompanion(bool nullToAbsent) {
    return DBParkinglotsCompanion(
      id: Value(id),
      addressId: Value(addressId),
      hourlyPrice: Value(hourlyPrice),
    );
  }

  factory DBParkinglot.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DBParkinglot(
      id: serializer.fromJson<String>(json['id']),
      addressId: serializer.fromJson<String>(json['addressId']),
      hourlyPrice: serializer.fromJson<double>(json['hourlyPrice']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'addressId': serializer.toJson<String>(addressId),
      'hourlyPrice': serializer.toJson<double>(hourlyPrice),
    };
  }

  DBParkinglot copyWith({String? id, String? addressId, double? hourlyPrice}) =>
      DBParkinglot(
        id: id ?? this.id,
        addressId: addressId ?? this.addressId,
        hourlyPrice: hourlyPrice ?? this.hourlyPrice,
      );
  DBParkinglot copyWithCompanion(DBParkinglotsCompanion data) {
    return DBParkinglot(
      id: data.id.present ? data.id.value : this.id,
      addressId: data.addressId.present ? data.addressId.value : this.addressId,
      hourlyPrice:
          data.hourlyPrice.present ? data.hourlyPrice.value : this.hourlyPrice,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DBParkinglot(')
          ..write('id: $id, ')
          ..write('addressId: $addressId, ')
          ..write('hourlyPrice: $hourlyPrice')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, addressId, hourlyPrice);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DBParkinglot &&
          other.id == this.id &&
          other.addressId == this.addressId &&
          other.hourlyPrice == this.hourlyPrice);
}

class DBParkinglotsCompanion extends UpdateCompanion<DBParkinglot> {
  final Value<String> id;
  final Value<String> addressId;
  final Value<double> hourlyPrice;
  final Value<int> rowid;
  const DBParkinglotsCompanion({
    this.id = const Value.absent(),
    this.addressId = const Value.absent(),
    this.hourlyPrice = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DBParkinglotsCompanion.insert({
    this.id = const Value.absent(),
    required String addressId,
    required double hourlyPrice,
    this.rowid = const Value.absent(),
  })  : addressId = Value(addressId),
        hourlyPrice = Value(hourlyPrice);
  static Insertable<DBParkinglot> custom({
    Expression<String>? id,
    Expression<String>? addressId,
    Expression<double>? hourlyPrice,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (addressId != null) 'address_id': addressId,
      if (hourlyPrice != null) 'hourly_price': hourlyPrice,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DBParkinglotsCompanion copyWith(
      {Value<String>? id,
      Value<String>? addressId,
      Value<double>? hourlyPrice,
      Value<int>? rowid}) {
    return DBParkinglotsCompanion(
      id: id ?? this.id,
      addressId: addressId ?? this.addressId,
      hourlyPrice: hourlyPrice ?? this.hourlyPrice,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (addressId.present) {
      map['address_id'] = Variable<String>(addressId.value);
    }
    if (hourlyPrice.present) {
      map['hourly_price'] = Variable<double>(hourlyPrice.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DBParkinglotsCompanion(')
          ..write('id: $id, ')
          ..write('addressId: $addressId, ')
          ..write('hourlyPrice: $hourlyPrice, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DBVehiclesTable extends DBVehicles
    with TableInfo<$DBVehiclesTable, DBVehicle> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DBVehiclesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => uuid.v4());
  static const VerificationMeta _registrationNoMeta =
      const VerificationMeta('registrationNo');
  @override
  late final GeneratedColumn<String> registrationNo = GeneratedColumn<String>(
      'registration_no', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 6),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<int> type = GeneratedColumn<int>(
      'type', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _ownerIdMeta =
      const VerificationMeta('ownerId');
  @override
  late final GeneratedColumn<String> ownerId = GeneratedColumn<String>(
      'owner_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL REFERENCES d_b_owners(id)');
  @override
  List<GeneratedColumn> get $columns => [id, registrationNo, type, ownerId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'd_b_vehicles';
  @override
  VerificationContext validateIntegrity(Insertable<DBVehicle> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('registration_no')) {
      context.handle(
          _registrationNoMeta,
          registrationNo.isAcceptableOrUnknown(
              data['registration_no']!, _registrationNoMeta));
    } else if (isInserting) {
      context.missing(_registrationNoMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('owner_id')) {
      context.handle(_ownerIdMeta,
          ownerId.isAcceptableOrUnknown(data['owner_id']!, _ownerIdMeta));
    } else if (isInserting) {
      context.missing(_ownerIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DBVehicle map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DBVehicle(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id']),
      registrationNo: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}registration_no'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}type'])!,
      ownerId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}owner_id'])!,
    );
  }

  @override
  $DBVehiclesTable createAlias(String alias) {
    return $DBVehiclesTable(attachedDatabase, alias);
  }
}

class DBVehicle extends DataClass implements Insertable<DBVehicle> {
  final String? id;
  final String registrationNo;
  final int type;
  final String ownerId;
  const DBVehicle(
      {this.id,
      required this.registrationNo,
      required this.type,
      required this.ownerId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<String>(id);
    }
    map['registration_no'] = Variable<String>(registrationNo);
    map['type'] = Variable<int>(type);
    map['owner_id'] = Variable<String>(ownerId);
    return map;
  }

  DBVehiclesCompanion toCompanion(bool nullToAbsent) {
    return DBVehiclesCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      registrationNo: Value(registrationNo),
      type: Value(type),
      ownerId: Value(ownerId),
    );
  }

  factory DBVehicle.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DBVehicle(
      id: serializer.fromJson<String?>(json['id']),
      registrationNo: serializer.fromJson<String>(json['registrationNo']),
      type: serializer.fromJson<int>(json['type']),
      ownerId: serializer.fromJson<String>(json['ownerId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String?>(id),
      'registrationNo': serializer.toJson<String>(registrationNo),
      'type': serializer.toJson<int>(type),
      'ownerId': serializer.toJson<String>(ownerId),
    };
  }

  DBVehicle copyWith(
          {Value<String?> id = const Value.absent(),
          String? registrationNo,
          int? type,
          String? ownerId}) =>
      DBVehicle(
        id: id.present ? id.value : this.id,
        registrationNo: registrationNo ?? this.registrationNo,
        type: type ?? this.type,
        ownerId: ownerId ?? this.ownerId,
      );
  DBVehicle copyWithCompanion(DBVehiclesCompanion data) {
    return DBVehicle(
      id: data.id.present ? data.id.value : this.id,
      registrationNo: data.registrationNo.present
          ? data.registrationNo.value
          : this.registrationNo,
      type: data.type.present ? data.type.value : this.type,
      ownerId: data.ownerId.present ? data.ownerId.value : this.ownerId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DBVehicle(')
          ..write('id: $id, ')
          ..write('registrationNo: $registrationNo, ')
          ..write('type: $type, ')
          ..write('ownerId: $ownerId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, registrationNo, type, ownerId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DBVehicle &&
          other.id == this.id &&
          other.registrationNo == this.registrationNo &&
          other.type == this.type &&
          other.ownerId == this.ownerId);
}

class DBVehiclesCompanion extends UpdateCompanion<DBVehicle> {
  final Value<String?> id;
  final Value<String> registrationNo;
  final Value<int> type;
  final Value<String> ownerId;
  final Value<int> rowid;
  const DBVehiclesCompanion({
    this.id = const Value.absent(),
    this.registrationNo = const Value.absent(),
    this.type = const Value.absent(),
    this.ownerId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DBVehiclesCompanion.insert({
    this.id = const Value.absent(),
    required String registrationNo,
    required int type,
    required String ownerId,
    this.rowid = const Value.absent(),
  })  : registrationNo = Value(registrationNo),
        type = Value(type),
        ownerId = Value(ownerId);
  static Insertable<DBVehicle> custom({
    Expression<String>? id,
    Expression<String>? registrationNo,
    Expression<int>? type,
    Expression<String>? ownerId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (registrationNo != null) 'registration_no': registrationNo,
      if (type != null) 'type': type,
      if (ownerId != null) 'owner_id': ownerId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DBVehiclesCompanion copyWith(
      {Value<String?>? id,
      Value<String>? registrationNo,
      Value<int>? type,
      Value<String>? ownerId,
      Value<int>? rowid}) {
    return DBVehiclesCompanion(
      id: id ?? this.id,
      registrationNo: registrationNo ?? this.registrationNo,
      type: type ?? this.type,
      ownerId: ownerId ?? this.ownerId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (registrationNo.present) {
      map['registration_no'] = Variable<String>(registrationNo.value);
    }
    if (type.present) {
      map['type'] = Variable<int>(type.value);
    }
    if (ownerId.present) {
      map['owner_id'] = Variable<String>(ownerId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DBVehiclesCompanion(')
          ..write('id: $id, ')
          ..write('registrationNo: $registrationNo, ')
          ..write('type: $type, ')
          ..write('ownerId: $ownerId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DBParkingsTable extends DBParkings
    with TableInfo<$DBParkingsTable, DBParking> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DBParkingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => uuid.v4());
  static const VerificationMeta _startTimeMeta =
      const VerificationMeta('startTime');
  @override
  late final GeneratedColumn<DateTime> startTime = GeneratedColumn<DateTime>(
      'start_time', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _endTimeMeta =
      const VerificationMeta('endTime');
  @override
  late final GeneratedColumn<DateTime> endTime = GeneratedColumn<DateTime>(
      'end_time', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _vehicleIdMeta =
      const VerificationMeta('vehicleId');
  @override
  late final GeneratedColumn<String> vehicleId = GeneratedColumn<String>(
      'vehicle_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL REFERENCES d_b_vehicles(id)');
  static const VerificationMeta _parkingLotIdMeta =
      const VerificationMeta('parkingLotId');
  @override
  late final GeneratedColumn<String> parkingLotId = GeneratedColumn<String>(
      'parking_lot_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL REFERENCES d_b_parkinglots(id)');
  @override
  List<GeneratedColumn> get $columns =>
      [id, startTime, endTime, vehicleId, parkingLotId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'd_b_parkings';
  @override
  VerificationContext validateIntegrity(Insertable<DBParking> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('start_time')) {
      context.handle(_startTimeMeta,
          startTime.isAcceptableOrUnknown(data['start_time']!, _startTimeMeta));
    } else if (isInserting) {
      context.missing(_startTimeMeta);
    }
    if (data.containsKey('end_time')) {
      context.handle(_endTimeMeta,
          endTime.isAcceptableOrUnknown(data['end_time']!, _endTimeMeta));
    }
    if (data.containsKey('vehicle_id')) {
      context.handle(_vehicleIdMeta,
          vehicleId.isAcceptableOrUnknown(data['vehicle_id']!, _vehicleIdMeta));
    } else if (isInserting) {
      context.missing(_vehicleIdMeta);
    }
    if (data.containsKey('parking_lot_id')) {
      context.handle(
          _parkingLotIdMeta,
          parkingLotId.isAcceptableOrUnknown(
              data['parking_lot_id']!, _parkingLotIdMeta));
    } else if (isInserting) {
      context.missing(_parkingLotIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DBParking map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DBParking(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      startTime: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}start_time'])!,
      endTime: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}end_time']),
      vehicleId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}vehicle_id'])!,
      parkingLotId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}parking_lot_id'])!,
    );
  }

  @override
  $DBParkingsTable createAlias(String alias) {
    return $DBParkingsTable(attachedDatabase, alias);
  }
}

class DBParking extends DataClass implements Insertable<DBParking> {
  final String id;
  final DateTime startTime;
  final DateTime? endTime;
  final String vehicleId;
  final String parkingLotId;
  const DBParking(
      {required this.id,
      required this.startTime,
      this.endTime,
      required this.vehicleId,
      required this.parkingLotId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['start_time'] = Variable<DateTime>(startTime);
    if (!nullToAbsent || endTime != null) {
      map['end_time'] = Variable<DateTime>(endTime);
    }
    map['vehicle_id'] = Variable<String>(vehicleId);
    map['parking_lot_id'] = Variable<String>(parkingLotId);
    return map;
  }

  DBParkingsCompanion toCompanion(bool nullToAbsent) {
    return DBParkingsCompanion(
      id: Value(id),
      startTime: Value(startTime),
      endTime: endTime == null && nullToAbsent
          ? const Value.absent()
          : Value(endTime),
      vehicleId: Value(vehicleId),
      parkingLotId: Value(parkingLotId),
    );
  }

  factory DBParking.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DBParking(
      id: serializer.fromJson<String>(json['id']),
      startTime: serializer.fromJson<DateTime>(json['startTime']),
      endTime: serializer.fromJson<DateTime?>(json['endTime']),
      vehicleId: serializer.fromJson<String>(json['vehicleId']),
      parkingLotId: serializer.fromJson<String>(json['parkingLotId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'startTime': serializer.toJson<DateTime>(startTime),
      'endTime': serializer.toJson<DateTime?>(endTime),
      'vehicleId': serializer.toJson<String>(vehicleId),
      'parkingLotId': serializer.toJson<String>(parkingLotId),
    };
  }

  DBParking copyWith(
          {String? id,
          DateTime? startTime,
          Value<DateTime?> endTime = const Value.absent(),
          String? vehicleId,
          String? parkingLotId}) =>
      DBParking(
        id: id ?? this.id,
        startTime: startTime ?? this.startTime,
        endTime: endTime.present ? endTime.value : this.endTime,
        vehicleId: vehicleId ?? this.vehicleId,
        parkingLotId: parkingLotId ?? this.parkingLotId,
      );
  DBParking copyWithCompanion(DBParkingsCompanion data) {
    return DBParking(
      id: data.id.present ? data.id.value : this.id,
      startTime: data.startTime.present ? data.startTime.value : this.startTime,
      endTime: data.endTime.present ? data.endTime.value : this.endTime,
      vehicleId: data.vehicleId.present ? data.vehicleId.value : this.vehicleId,
      parkingLotId: data.parkingLotId.present
          ? data.parkingLotId.value
          : this.parkingLotId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DBParking(')
          ..write('id: $id, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('vehicleId: $vehicleId, ')
          ..write('parkingLotId: $parkingLotId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, startTime, endTime, vehicleId, parkingLotId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DBParking &&
          other.id == this.id &&
          other.startTime == this.startTime &&
          other.endTime == this.endTime &&
          other.vehicleId == this.vehicleId &&
          other.parkingLotId == this.parkingLotId);
}

class DBParkingsCompanion extends UpdateCompanion<DBParking> {
  final Value<String> id;
  final Value<DateTime> startTime;
  final Value<DateTime?> endTime;
  final Value<String> vehicleId;
  final Value<String> parkingLotId;
  final Value<int> rowid;
  const DBParkingsCompanion({
    this.id = const Value.absent(),
    this.startTime = const Value.absent(),
    this.endTime = const Value.absent(),
    this.vehicleId = const Value.absent(),
    this.parkingLotId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DBParkingsCompanion.insert({
    this.id = const Value.absent(),
    required DateTime startTime,
    this.endTime = const Value.absent(),
    required String vehicleId,
    required String parkingLotId,
    this.rowid = const Value.absent(),
  })  : startTime = Value(startTime),
        vehicleId = Value(vehicleId),
        parkingLotId = Value(parkingLotId);
  static Insertable<DBParking> custom({
    Expression<String>? id,
    Expression<DateTime>? startTime,
    Expression<DateTime>? endTime,
    Expression<String>? vehicleId,
    Expression<String>? parkingLotId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (startTime != null) 'start_time': startTime,
      if (endTime != null) 'end_time': endTime,
      if (vehicleId != null) 'vehicle_id': vehicleId,
      if (parkingLotId != null) 'parking_lot_id': parkingLotId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DBParkingsCompanion copyWith(
      {Value<String>? id,
      Value<DateTime>? startTime,
      Value<DateTime?>? endTime,
      Value<String>? vehicleId,
      Value<String>? parkingLotId,
      Value<int>? rowid}) {
    return DBParkingsCompanion(
      id: id ?? this.id,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      vehicleId: vehicleId ?? this.vehicleId,
      parkingLotId: parkingLotId ?? this.parkingLotId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (startTime.present) {
      map['start_time'] = Variable<DateTime>(startTime.value);
    }
    if (endTime.present) {
      map['end_time'] = Variable<DateTime>(endTime.value);
    }
    if (vehicleId.present) {
      map['vehicle_id'] = Variable<String>(vehicleId.value);
    }
    if (parkingLotId.present) {
      map['parking_lot_id'] = Variable<String>(parkingLotId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DBParkingsCompanion(')
          ..write('id: $id, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('vehicleId: $vehicleId, ')
          ..write('parkingLotId: $parkingLotId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$ParkingDatabase extends GeneratedDatabase {
  _$ParkingDatabase(QueryExecutor e) : super(e);
  $ParkingDatabaseManager get managers => $ParkingDatabaseManager(this);
  late final $DBOwnersTable dBOwners = $DBOwnersTable(this);
  late final $DBAddressesTable dBAddresses = $DBAddressesTable(this);
  late final $DBParkinglotsTable dBParkinglots = $DBParkinglotsTable(this);
  late final $DBVehiclesTable dBVehicles = $DBVehiclesTable(this);
  late final $DBParkingsTable dBParkings = $DBParkingsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [dBOwners, dBAddresses, dBParkinglots, dBVehicles, dBParkings];
}

typedef $$DBOwnersTableCreateCompanionBuilder = DBOwnersCompanion Function({
  Value<String?> id,
  required String name,
  required String ssn,
  Value<int> rowid,
});
typedef $$DBOwnersTableUpdateCompanionBuilder = DBOwnersCompanion Function({
  Value<String?> id,
  Value<String> name,
  Value<String> ssn,
  Value<int> rowid,
});

final class $$DBOwnersTableReferences
    extends BaseReferences<_$ParkingDatabase, $DBOwnersTable, DBOwner> {
  $$DBOwnersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$DBVehiclesTable, List<DBVehicle>>
      _dBVehiclesRefsTable(_$ParkingDatabase db) =>
          MultiTypedResultKey.fromTable(db.dBVehicles,
              aliasName:
                  $_aliasNameGenerator(db.dBOwners.id, db.dBVehicles.ownerId));

  $$DBVehiclesTableProcessedTableManager get dBVehiclesRefs {
    final manager = $$DBVehiclesTableTableManager($_db, $_db.dBVehicles)
        .filter((f) => f.ownerId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_dBVehiclesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$DBOwnersTableFilterComposer
    extends Composer<_$ParkingDatabase, $DBOwnersTable> {
  $$DBOwnersTableFilterComposer({
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

  ColumnFilters<String> get ssn => $composableBuilder(
      column: $table.ssn, builder: (column) => ColumnFilters(column));

  Expression<bool> dBVehiclesRefs(
      Expression<bool> Function($$DBVehiclesTableFilterComposer f) f) {
    final $$DBVehiclesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.dBVehicles,
        getReferencedColumn: (t) => t.ownerId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DBVehiclesTableFilterComposer(
              $db: $db,
              $table: $db.dBVehicles,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$DBOwnersTableOrderingComposer
    extends Composer<_$ParkingDatabase, $DBOwnersTable> {
  $$DBOwnersTableOrderingComposer({
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

  ColumnOrderings<String> get ssn => $composableBuilder(
      column: $table.ssn, builder: (column) => ColumnOrderings(column));
}

class $$DBOwnersTableAnnotationComposer
    extends Composer<_$ParkingDatabase, $DBOwnersTable> {
  $$DBOwnersTableAnnotationComposer({
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

  GeneratedColumn<String> get ssn =>
      $composableBuilder(column: $table.ssn, builder: (column) => column);

  Expression<T> dBVehiclesRefs<T extends Object>(
      Expression<T> Function($$DBVehiclesTableAnnotationComposer a) f) {
    final $$DBVehiclesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.dBVehicles,
        getReferencedColumn: (t) => t.ownerId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DBVehiclesTableAnnotationComposer(
              $db: $db,
              $table: $db.dBVehicles,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$DBOwnersTableTableManager extends RootTableManager<
    _$ParkingDatabase,
    $DBOwnersTable,
    DBOwner,
    $$DBOwnersTableFilterComposer,
    $$DBOwnersTableOrderingComposer,
    $$DBOwnersTableAnnotationComposer,
    $$DBOwnersTableCreateCompanionBuilder,
    $$DBOwnersTableUpdateCompanionBuilder,
    (DBOwner, $$DBOwnersTableReferences),
    DBOwner,
    PrefetchHooks Function({bool dBVehiclesRefs})> {
  $$DBOwnersTableTableManager(_$ParkingDatabase db, $DBOwnersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DBOwnersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DBOwnersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DBOwnersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String?> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> ssn = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              DBOwnersCompanion(
            id: id,
            name: name,
            ssn: ssn,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            Value<String?> id = const Value.absent(),
            required String name,
            required String ssn,
            Value<int> rowid = const Value.absent(),
          }) =>
              DBOwnersCompanion.insert(
            id: id,
            name: name,
            ssn: ssn,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$DBOwnersTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({dBVehiclesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (dBVehiclesRefs) db.dBVehicles],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (dBVehiclesRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$DBOwnersTableReferences._dBVehiclesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$DBOwnersTableReferences(db, table, p0)
                                .dBVehiclesRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.ownerId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$DBOwnersTableProcessedTableManager = ProcessedTableManager<
    _$ParkingDatabase,
    $DBOwnersTable,
    DBOwner,
    $$DBOwnersTableFilterComposer,
    $$DBOwnersTableOrderingComposer,
    $$DBOwnersTableAnnotationComposer,
    $$DBOwnersTableCreateCompanionBuilder,
    $$DBOwnersTableUpdateCompanionBuilder,
    (DBOwner, $$DBOwnersTableReferences),
    DBOwner,
    PrefetchHooks Function({bool dBVehiclesRefs})>;
typedef $$DBAddressesTableCreateCompanionBuilder = DBAddressesCompanion
    Function({
  Value<String> id,
  required String street,
  required String zipCode,
  required String city,
  Value<int> rowid,
});
typedef $$DBAddressesTableUpdateCompanionBuilder = DBAddressesCompanion
    Function({
  Value<String> id,
  Value<String> street,
  Value<String> zipCode,
  Value<String> city,
  Value<int> rowid,
});

final class $$DBAddressesTableReferences
    extends BaseReferences<_$ParkingDatabase, $DBAddressesTable, DBAddress> {
  $$DBAddressesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$DBParkinglotsTable, List<DBParkinglot>>
      _dBParkinglotsRefsTable(_$ParkingDatabase db) =>
          MultiTypedResultKey.fromTable(db.dBParkinglots,
              aliasName: $_aliasNameGenerator(
                  db.dBAddresses.id, db.dBParkinglots.addressId));

  $$DBParkinglotsTableProcessedTableManager get dBParkinglotsRefs {
    final manager = $$DBParkinglotsTableTableManager($_db, $_db.dBParkinglots)
        .filter((f) => f.addressId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_dBParkinglotsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$DBAddressesTableFilterComposer
    extends Composer<_$ParkingDatabase, $DBAddressesTable> {
  $$DBAddressesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get street => $composableBuilder(
      column: $table.street, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get zipCode => $composableBuilder(
      column: $table.zipCode, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get city => $composableBuilder(
      column: $table.city, builder: (column) => ColumnFilters(column));

  Expression<bool> dBParkinglotsRefs(
      Expression<bool> Function($$DBParkinglotsTableFilterComposer f) f) {
    final $$DBParkinglotsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.dBParkinglots,
        getReferencedColumn: (t) => t.addressId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DBParkinglotsTableFilterComposer(
              $db: $db,
              $table: $db.dBParkinglots,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$DBAddressesTableOrderingComposer
    extends Composer<_$ParkingDatabase, $DBAddressesTable> {
  $$DBAddressesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get street => $composableBuilder(
      column: $table.street, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get zipCode => $composableBuilder(
      column: $table.zipCode, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get city => $composableBuilder(
      column: $table.city, builder: (column) => ColumnOrderings(column));
}

class $$DBAddressesTableAnnotationComposer
    extends Composer<_$ParkingDatabase, $DBAddressesTable> {
  $$DBAddressesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get street =>
      $composableBuilder(column: $table.street, builder: (column) => column);

  GeneratedColumn<String> get zipCode =>
      $composableBuilder(column: $table.zipCode, builder: (column) => column);

  GeneratedColumn<String> get city =>
      $composableBuilder(column: $table.city, builder: (column) => column);

  Expression<T> dBParkinglotsRefs<T extends Object>(
      Expression<T> Function($$DBParkinglotsTableAnnotationComposer a) f) {
    final $$DBParkinglotsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.dBParkinglots,
        getReferencedColumn: (t) => t.addressId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DBParkinglotsTableAnnotationComposer(
              $db: $db,
              $table: $db.dBParkinglots,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$DBAddressesTableTableManager extends RootTableManager<
    _$ParkingDatabase,
    $DBAddressesTable,
    DBAddress,
    $$DBAddressesTableFilterComposer,
    $$DBAddressesTableOrderingComposer,
    $$DBAddressesTableAnnotationComposer,
    $$DBAddressesTableCreateCompanionBuilder,
    $$DBAddressesTableUpdateCompanionBuilder,
    (DBAddress, $$DBAddressesTableReferences),
    DBAddress,
    PrefetchHooks Function({bool dBParkinglotsRefs})> {
  $$DBAddressesTableTableManager(_$ParkingDatabase db, $DBAddressesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DBAddressesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DBAddressesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DBAddressesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> street = const Value.absent(),
            Value<String> zipCode = const Value.absent(),
            Value<String> city = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              DBAddressesCompanion(
            id: id,
            street: street,
            zipCode: zipCode,
            city: city,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            Value<String> id = const Value.absent(),
            required String street,
            required String zipCode,
            required String city,
            Value<int> rowid = const Value.absent(),
          }) =>
              DBAddressesCompanion.insert(
            id: id,
            street: street,
            zipCode: zipCode,
            city: city,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$DBAddressesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({dBParkinglotsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (dBParkinglotsRefs) db.dBParkinglots
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (dBParkinglotsRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$DBAddressesTableReferences
                            ._dBParkinglotsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$DBAddressesTableReferences(db, table, p0)
                                .dBParkinglotsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.addressId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$DBAddressesTableProcessedTableManager = ProcessedTableManager<
    _$ParkingDatabase,
    $DBAddressesTable,
    DBAddress,
    $$DBAddressesTableFilterComposer,
    $$DBAddressesTableOrderingComposer,
    $$DBAddressesTableAnnotationComposer,
    $$DBAddressesTableCreateCompanionBuilder,
    $$DBAddressesTableUpdateCompanionBuilder,
    (DBAddress, $$DBAddressesTableReferences),
    DBAddress,
    PrefetchHooks Function({bool dBParkinglotsRefs})>;
typedef $$DBParkinglotsTableCreateCompanionBuilder = DBParkinglotsCompanion
    Function({
  Value<String> id,
  required String addressId,
  required double hourlyPrice,
  Value<int> rowid,
});
typedef $$DBParkinglotsTableUpdateCompanionBuilder = DBParkinglotsCompanion
    Function({
  Value<String> id,
  Value<String> addressId,
  Value<double> hourlyPrice,
  Value<int> rowid,
});

final class $$DBParkinglotsTableReferences extends BaseReferences<
    _$ParkingDatabase, $DBParkinglotsTable, DBParkinglot> {
  $$DBParkinglotsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $DBAddressesTable _addressIdTable(_$ParkingDatabase db) =>
      db.dBAddresses.createAlias(
          $_aliasNameGenerator(db.dBParkinglots.addressId, db.dBAddresses.id));

  $$DBAddressesTableProcessedTableManager? get addressId {
    if ($_item.addressId == null) return null;
    final manager = $$DBAddressesTableTableManager($_db, $_db.dBAddresses)
        .filter((f) => f.id($_item.addressId!));
    final item = $_typedResult.readTableOrNull(_addressIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$DBParkinglotsTableFilterComposer
    extends Composer<_$ParkingDatabase, $DBParkinglotsTable> {
  $$DBParkinglotsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get hourlyPrice => $composableBuilder(
      column: $table.hourlyPrice, builder: (column) => ColumnFilters(column));

  $$DBAddressesTableFilterComposer get addressId {
    final $$DBAddressesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.addressId,
        referencedTable: $db.dBAddresses,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DBAddressesTableFilterComposer(
              $db: $db,
              $table: $db.dBAddresses,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$DBParkinglotsTableOrderingComposer
    extends Composer<_$ParkingDatabase, $DBParkinglotsTable> {
  $$DBParkinglotsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get hourlyPrice => $composableBuilder(
      column: $table.hourlyPrice, builder: (column) => ColumnOrderings(column));

  $$DBAddressesTableOrderingComposer get addressId {
    final $$DBAddressesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.addressId,
        referencedTable: $db.dBAddresses,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DBAddressesTableOrderingComposer(
              $db: $db,
              $table: $db.dBAddresses,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$DBParkinglotsTableAnnotationComposer
    extends Composer<_$ParkingDatabase, $DBParkinglotsTable> {
  $$DBParkinglotsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get hourlyPrice => $composableBuilder(
      column: $table.hourlyPrice, builder: (column) => column);

  $$DBAddressesTableAnnotationComposer get addressId {
    final $$DBAddressesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.addressId,
        referencedTable: $db.dBAddresses,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DBAddressesTableAnnotationComposer(
              $db: $db,
              $table: $db.dBAddresses,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$DBParkinglotsTableTableManager extends RootTableManager<
    _$ParkingDatabase,
    $DBParkinglotsTable,
    DBParkinglot,
    $$DBParkinglotsTableFilterComposer,
    $$DBParkinglotsTableOrderingComposer,
    $$DBParkinglotsTableAnnotationComposer,
    $$DBParkinglotsTableCreateCompanionBuilder,
    $$DBParkinglotsTableUpdateCompanionBuilder,
    (DBParkinglot, $$DBParkinglotsTableReferences),
    DBParkinglot,
    PrefetchHooks Function({bool addressId})> {
  $$DBParkinglotsTableTableManager(
      _$ParkingDatabase db, $DBParkinglotsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DBParkinglotsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DBParkinglotsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DBParkinglotsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> addressId = const Value.absent(),
            Value<double> hourlyPrice = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              DBParkinglotsCompanion(
            id: id,
            addressId: addressId,
            hourlyPrice: hourlyPrice,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            Value<String> id = const Value.absent(),
            required String addressId,
            required double hourlyPrice,
            Value<int> rowid = const Value.absent(),
          }) =>
              DBParkinglotsCompanion.insert(
            id: id,
            addressId: addressId,
            hourlyPrice: hourlyPrice,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$DBParkinglotsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({addressId = false}) {
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
                if (addressId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.addressId,
                    referencedTable:
                        $$DBParkinglotsTableReferences._addressIdTable(db),
                    referencedColumn:
                        $$DBParkinglotsTableReferences._addressIdTable(db).id,
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

typedef $$DBParkinglotsTableProcessedTableManager = ProcessedTableManager<
    _$ParkingDatabase,
    $DBParkinglotsTable,
    DBParkinglot,
    $$DBParkinglotsTableFilterComposer,
    $$DBParkinglotsTableOrderingComposer,
    $$DBParkinglotsTableAnnotationComposer,
    $$DBParkinglotsTableCreateCompanionBuilder,
    $$DBParkinglotsTableUpdateCompanionBuilder,
    (DBParkinglot, $$DBParkinglotsTableReferences),
    DBParkinglot,
    PrefetchHooks Function({bool addressId})>;
typedef $$DBVehiclesTableCreateCompanionBuilder = DBVehiclesCompanion Function({
  Value<String?> id,
  required String registrationNo,
  required int type,
  required String ownerId,
  Value<int> rowid,
});
typedef $$DBVehiclesTableUpdateCompanionBuilder = DBVehiclesCompanion Function({
  Value<String?> id,
  Value<String> registrationNo,
  Value<int> type,
  Value<String> ownerId,
  Value<int> rowid,
});

final class $$DBVehiclesTableReferences
    extends BaseReferences<_$ParkingDatabase, $DBVehiclesTable, DBVehicle> {
  $$DBVehiclesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $DBOwnersTable _ownerIdTable(_$ParkingDatabase db) => db.dBOwners
      .createAlias($_aliasNameGenerator(db.dBVehicles.ownerId, db.dBOwners.id));

  $$DBOwnersTableProcessedTableManager? get ownerId {
    if ($_item.ownerId == null) return null;
    final manager = $$DBOwnersTableTableManager($_db, $_db.dBOwners)
        .filter((f) => f.id($_item.ownerId!));
    final item = $_typedResult.readTableOrNull(_ownerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$DBVehiclesTableFilterComposer
    extends Composer<_$ParkingDatabase, $DBVehiclesTable> {
  $$DBVehiclesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get registrationNo => $composableBuilder(
      column: $table.registrationNo,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  $$DBOwnersTableFilterComposer get ownerId {
    final $$DBOwnersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.ownerId,
        referencedTable: $db.dBOwners,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DBOwnersTableFilterComposer(
              $db: $db,
              $table: $db.dBOwners,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$DBVehiclesTableOrderingComposer
    extends Composer<_$ParkingDatabase, $DBVehiclesTable> {
  $$DBVehiclesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get registrationNo => $composableBuilder(
      column: $table.registrationNo,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  $$DBOwnersTableOrderingComposer get ownerId {
    final $$DBOwnersTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.ownerId,
        referencedTable: $db.dBOwners,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DBOwnersTableOrderingComposer(
              $db: $db,
              $table: $db.dBOwners,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$DBVehiclesTableAnnotationComposer
    extends Composer<_$ParkingDatabase, $DBVehiclesTable> {
  $$DBVehiclesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get registrationNo => $composableBuilder(
      column: $table.registrationNo, builder: (column) => column);

  GeneratedColumn<int> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  $$DBOwnersTableAnnotationComposer get ownerId {
    final $$DBOwnersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.ownerId,
        referencedTable: $db.dBOwners,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DBOwnersTableAnnotationComposer(
              $db: $db,
              $table: $db.dBOwners,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$DBVehiclesTableTableManager extends RootTableManager<
    _$ParkingDatabase,
    $DBVehiclesTable,
    DBVehicle,
    $$DBVehiclesTableFilterComposer,
    $$DBVehiclesTableOrderingComposer,
    $$DBVehiclesTableAnnotationComposer,
    $$DBVehiclesTableCreateCompanionBuilder,
    $$DBVehiclesTableUpdateCompanionBuilder,
    (DBVehicle, $$DBVehiclesTableReferences),
    DBVehicle,
    PrefetchHooks Function({bool ownerId})> {
  $$DBVehiclesTableTableManager(_$ParkingDatabase db, $DBVehiclesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DBVehiclesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DBVehiclesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DBVehiclesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String?> id = const Value.absent(),
            Value<String> registrationNo = const Value.absent(),
            Value<int> type = const Value.absent(),
            Value<String> ownerId = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              DBVehiclesCompanion(
            id: id,
            registrationNo: registrationNo,
            type: type,
            ownerId: ownerId,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            Value<String?> id = const Value.absent(),
            required String registrationNo,
            required int type,
            required String ownerId,
            Value<int> rowid = const Value.absent(),
          }) =>
              DBVehiclesCompanion.insert(
            id: id,
            registrationNo: registrationNo,
            type: type,
            ownerId: ownerId,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$DBVehiclesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({ownerId = false}) {
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
                if (ownerId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.ownerId,
                    referencedTable:
                        $$DBVehiclesTableReferences._ownerIdTable(db),
                    referencedColumn:
                        $$DBVehiclesTableReferences._ownerIdTable(db).id,
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

typedef $$DBVehiclesTableProcessedTableManager = ProcessedTableManager<
    _$ParkingDatabase,
    $DBVehiclesTable,
    DBVehicle,
    $$DBVehiclesTableFilterComposer,
    $$DBVehiclesTableOrderingComposer,
    $$DBVehiclesTableAnnotationComposer,
    $$DBVehiclesTableCreateCompanionBuilder,
    $$DBVehiclesTableUpdateCompanionBuilder,
    (DBVehicle, $$DBVehiclesTableReferences),
    DBVehicle,
    PrefetchHooks Function({bool ownerId})>;
typedef $$DBParkingsTableCreateCompanionBuilder = DBParkingsCompanion Function({
  Value<String> id,
  required DateTime startTime,
  Value<DateTime?> endTime,
  required String vehicleId,
  required String parkingLotId,
  Value<int> rowid,
});
typedef $$DBParkingsTableUpdateCompanionBuilder = DBParkingsCompanion Function({
  Value<String> id,
  Value<DateTime> startTime,
  Value<DateTime?> endTime,
  Value<String> vehicleId,
  Value<String> parkingLotId,
  Value<int> rowid,
});

class $$DBParkingsTableFilterComposer
    extends Composer<_$ParkingDatabase, $DBParkingsTable> {
  $$DBParkingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get startTime => $composableBuilder(
      column: $table.startTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get endTime => $composableBuilder(
      column: $table.endTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get vehicleId => $composableBuilder(
      column: $table.vehicleId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get parkingLotId => $composableBuilder(
      column: $table.parkingLotId, builder: (column) => ColumnFilters(column));
}

class $$DBParkingsTableOrderingComposer
    extends Composer<_$ParkingDatabase, $DBParkingsTable> {
  $$DBParkingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get startTime => $composableBuilder(
      column: $table.startTime, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get endTime => $composableBuilder(
      column: $table.endTime, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get vehicleId => $composableBuilder(
      column: $table.vehicleId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get parkingLotId => $composableBuilder(
      column: $table.parkingLotId,
      builder: (column) => ColumnOrderings(column));
}

class $$DBParkingsTableAnnotationComposer
    extends Composer<_$ParkingDatabase, $DBParkingsTable> {
  $$DBParkingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get startTime =>
      $composableBuilder(column: $table.startTime, builder: (column) => column);

  GeneratedColumn<DateTime> get endTime =>
      $composableBuilder(column: $table.endTime, builder: (column) => column);

  GeneratedColumn<String> get vehicleId =>
      $composableBuilder(column: $table.vehicleId, builder: (column) => column);

  GeneratedColumn<String> get parkingLotId => $composableBuilder(
      column: $table.parkingLotId, builder: (column) => column);
}

class $$DBParkingsTableTableManager extends RootTableManager<
    _$ParkingDatabase,
    $DBParkingsTable,
    DBParking,
    $$DBParkingsTableFilterComposer,
    $$DBParkingsTableOrderingComposer,
    $$DBParkingsTableAnnotationComposer,
    $$DBParkingsTableCreateCompanionBuilder,
    $$DBParkingsTableUpdateCompanionBuilder,
    (DBParking, BaseReferences<_$ParkingDatabase, $DBParkingsTable, DBParking>),
    DBParking,
    PrefetchHooks Function()> {
  $$DBParkingsTableTableManager(_$ParkingDatabase db, $DBParkingsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DBParkingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DBParkingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DBParkingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<DateTime> startTime = const Value.absent(),
            Value<DateTime?> endTime = const Value.absent(),
            Value<String> vehicleId = const Value.absent(),
            Value<String> parkingLotId = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              DBParkingsCompanion(
            id: id,
            startTime: startTime,
            endTime: endTime,
            vehicleId: vehicleId,
            parkingLotId: parkingLotId,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            Value<String> id = const Value.absent(),
            required DateTime startTime,
            Value<DateTime?> endTime = const Value.absent(),
            required String vehicleId,
            required String parkingLotId,
            Value<int> rowid = const Value.absent(),
          }) =>
              DBParkingsCompanion.insert(
            id: id,
            startTime: startTime,
            endTime: endTime,
            vehicleId: vehicleId,
            parkingLotId: parkingLotId,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$DBParkingsTableProcessedTableManager = ProcessedTableManager<
    _$ParkingDatabase,
    $DBParkingsTable,
    DBParking,
    $$DBParkingsTableFilterComposer,
    $$DBParkingsTableOrderingComposer,
    $$DBParkingsTableAnnotationComposer,
    $$DBParkingsTableCreateCompanionBuilder,
    $$DBParkingsTableUpdateCompanionBuilder,
    (DBParking, BaseReferences<_$ParkingDatabase, $DBParkingsTable, DBParking>),
    DBParking,
    PrefetchHooks Function()>;

class $ParkingDatabaseManager {
  final _$ParkingDatabase _db;
  $ParkingDatabaseManager(this._db);
  $$DBOwnersTableTableManager get dBOwners =>
      $$DBOwnersTableTableManager(_db, _db.dBOwners);
  $$DBAddressesTableTableManager get dBAddresses =>
      $$DBAddressesTableTableManager(_db, _db.dBAddresses);
  $$DBParkinglotsTableTableManager get dBParkinglots =>
      $$DBParkinglotsTableTableManager(_db, _db.dBParkinglots);
  $$DBVehiclesTableTableManager get dBVehicles =>
      $$DBVehiclesTableTableManager(_db, _db.dBVehicles);
  $$DBParkingsTableTableManager get dBParkings =>
      $$DBParkingsTableTableManager(_db, _db.dBParkings);
}
