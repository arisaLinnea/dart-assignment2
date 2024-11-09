import 'package:dart_shared/dart_shared.dart';
import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

final _uuid = Uuid();

@DataClassName('DBVehicle')
class DBVehicles extends Table {
  TextColumn get id => text().clientDefault(() => uuid.v4()).nullable()();
  TextColumn get registrationNo => text().withLength(min: 1, max: 6)();
  IntColumn get type => integer()();
  TextColumn get ownerId =>
      text().customConstraint('NOT NULL REFERENCES d_b_owners(id)')();

  Uuid get uuid => _uuid;

  static int typeToInt(VehicleType type) => type.index;
  static VehicleType intToType(int index) => VehicleType.values[index];

  @override
  Set<Column> get primaryKey => {id};
}

class VehicleFactory {
  static Map<String, dynamic> toJsonServer(Vehicle vehicle) {
    return {
      "id": vehicle.id,
      'registrationNo': vehicle.registrationNo,
      'type': vehicle.type.index,
      'owner': vehicle.owner?.toJson()
    };
  }
}
