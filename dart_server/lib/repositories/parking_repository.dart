import 'package:dart_server/db/database.dart';
import 'package:dart_server/models/db_parking.dart';
import 'package:dart_server/repositories/repository.dart';
import 'package:dart_shared/dart_shared.dart';
import 'package:drift/drift.dart';

class ParkingRepository extends Repository<Parking> {
  static final ParkingRepository _instance = ParkingRepository._internal();
  final database = ParkingDatabase();

  ParkingRepository._internal();

  factory ParkingRepository() => _instance;

  @override
  void addToList({required dynamic json}) async {
    try {
      Parking item = deserialize(json);
      if (item.parkinglot == null || item.vehicle == null) {
        throw ArgumentError('Parkinglot and Vehicle cannot be empty');
      }

      DBParkingsCompanion parkComp = DBParkingsCompanion(
          startTime: Value(item.startTime),
          endTime: Value(item.endTime),
          vehicleId: Value(item.vehicle?.id ?? '-1'),
          parkingLotId: Value(item.parkinglot?.id ?? '-1'));

      // Insert into the database
      final parking = await database.insertParking(parkComp);

      if (parking == null) {
        throw DatabaseException(
            message:
                'Failed to insert the parking with id:${parkComp.id} into the database');
      }
    } catch (e) {
      //probably InvalidDataException
      rethrow;
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getList() async {
    try {
      List<Parking> dbList = await database.getAllParkingsWithObjects();
      return dbList.map(ParkingFactory.toJsonServer).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  void update({required String id, required dynamic json}) async {
    try {
      Parking item = deserialize(json);
      if (item.parkinglot == null || item.vehicle == null) {
        throw ArgumentError('Parkinglot and Vehicle cannot be empty');
      }
      DBParkingsCompanion parkComp = DBParkingsCompanion(
          id: Value(id),
          startTime: Value(item.startTime),
          endTime: Value(item.endTime),
          vehicleId: Value(item.vehicle?.id ?? '-1'),
          parkingLotId: Value(item.parkinglot?.id ?? '-1'));

      final rowsUpdated = await database.updateParking(parkComp, id);
      if (rowsUpdated == 0) {
        throw DatabaseException(
            message:
                'Failed to update the parking with id:$id in the database');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  void remove({required String id}) async {
    try {
      final result = await database.deleteParking(id);
      if (result == 0) {
        throw DatabaseException(
            message:
                'Failed to delete the parking with id:$id in the database');
      }
    } catch (e) {
      rethrow;
    }
  }

  Parking deserialize(Map<String, dynamic> json) => Parking.fromJson(json);

  Map<String, dynamic> serialize(Parking item) => item.toJson();

  @override
  String itemAsString() {
    return 'Parking';
  }
}
