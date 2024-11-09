import 'package:dart_shared/dart_shared.dart';
import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

final _uuid = Uuid();

@DataClassName('DBParking')
class DBParkings extends Table {
  TextColumn get id => text().clientDefault(() => uuid.v4())();
  DateTimeColumn get startTime => dateTime()();
  DateTimeColumn get endTime => dateTime().nullable()();
  TextColumn get vehicleId =>
      text().customConstraint('NOT NULL REFERENCES d_b_vehicles(id)')();

  TextColumn get parkingLotId =>
      text().customConstraint('NOT NULL REFERENCES d_b_parkinglots(id)')();

  Uuid get uuid => _uuid;

  @override
  Set<Column> get primaryKey => {id};
}

class ParkingFactory {
  static Map<String, dynamic> toJsonServer(Parking parking) {
    return {
      "id": parking.id,
      'startTime': parking.startTime.toIso8601String(),
      'endTime':
          parking.endTime == null ? null : parking.startTime.toIso8601String(),
      'vehicle': parking.vehicle?.toJson(),
      'parkinglot': parking.parkinglot?.toJson()
    };
  }
}
