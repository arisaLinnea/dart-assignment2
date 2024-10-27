import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

@DataClassName('DBOwners')
class DBOwner extends Table {
  //IntColumn get id => integer().autoIncrement()();
  TextColumn get id => text().clientDefault(() => Uuid().v4())();
  TextColumn get name => text().withLength(min: 1, max: 50)();
  IntColumn get ssn => integer()();

  @override
  Set<Column> get primaryKey => {id};
}
