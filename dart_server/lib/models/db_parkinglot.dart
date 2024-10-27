import 'package:uuid/uuid.dart';
import 'package:drift/drift.dart';

@DataClassName('DBAddresses')
class DBAddress extends Table {
  TextColumn get id => text().clientDefault(() => Uuid().v4())();
  TextColumn get street => text().withLength(min: 1, max: 50)();
  TextColumn get zipCode => text().withLength(min: 1, max: 50)();
  TextColumn get city => text().withLength(min: 1, max: 50)();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('DBParkinglots')
class DBParkinglot extends Table {
  TextColumn get id => text().clientDefault(() => Uuid().v4())();
  // IntColumn get addressId =>
  //     integer().customConstraint('REFERENCES dbaddresses(id)')();
  Column<double> get hourlyPrice => real()();

  @override
  Set<Column> get primaryKey => {id};
}
