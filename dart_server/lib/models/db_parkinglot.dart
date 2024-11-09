import 'package:dart_shared/dart_shared.dart';
import 'package:uuid/uuid.dart';
import 'package:drift/drift.dart';

@DataClassName('DBAddress')
class DBAddresses extends Table {
  final _uuid = Uuid();
  TextColumn get id => text().clientDefault(() => uuid.v4())();
  TextColumn get street => text().withLength(min: 1, max: 50)();
  TextColumn get zipCode => text().withLength(min: 1, max: 50)();
  TextColumn get city => text().withLength(min: 1, max: 50)();

  Uuid get uuid => _uuid;

  @override
  Set<Column> get primaryKey => {id};

  @override
  bool get withoutRowId => false;
}

@DataClassName('DBParkinglot')
class DBParkinglots extends Table {
  final _uuid = Uuid();
  TextColumn get id => text().clientDefault(() => uuid.v4())();
  TextColumn get addressId =>
      text().customConstraint('NOT NULL REFERENCES d_b_addresses(id)')();
  Column<double> get hourlyPrice => real()();

  Uuid get uuid => _uuid;

  @override
  Set<Column> get primaryKey => {id};
}

class ParkingLotFactory {
  static Map<String, dynamic> toJsonServer(ParkingLot parkingLot) {
    return {
      'id': parkingLot.id,
      'address': parkingLot.address.toJson(),
      'hourlyPrice': parkingLot.hourlyPrice
    };
  }
}
