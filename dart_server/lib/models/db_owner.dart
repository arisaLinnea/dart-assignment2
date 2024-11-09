import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

final _uuid = Uuid();

@DataClassName('DBOwner')
class DBOwners extends Table {
  TextColumn get id => text().clientDefault(() => uuid.v4()).nullable()();
  TextColumn get name => text().withLength(min: 1, max: 50)();
  TextColumn get ssn => text().withLength(min: 10, max: 12)();

  Uuid get uuid => _uuid;

  @override
  Set<Column> get primaryKey => {id};
}
