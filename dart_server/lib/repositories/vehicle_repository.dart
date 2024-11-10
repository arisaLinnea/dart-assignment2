import 'package:dart_server/db/database.dart';
import 'package:dart_server/models/db_vehicle.dart';
import 'package:dart_server/repositories/repository.dart';
import 'package:dart_shared/dart_shared.dart';
import 'package:drift/drift.dart';

class VehicleRepository extends Repository<Vehicle> {
  static final VehicleRepository _instance = VehicleRepository._internal();
  final database = ParkingDatabase();

  VehicleRepository._internal();

  factory VehicleRepository() => _instance;

  @override
  void addToList({required dynamic json}) async {
    try {
      Vehicle item = deserialize(json);
      if (item.registrationNo.isEmpty || item.owner == null) {
        throw ArgumentError('RegistrationNo and Owner cannot be empty');
      }

      DBVehiclesCompanion comp = DBVehiclesCompanion(
          registrationNo: Value(item.registrationNo),
          type: Value(DBVehicles.typeToInt(item.type)),
          ownerId: Value(item.owner?.id ?? '-1'));

      final vehicle = await database.insertVehicle(comp);

      if (vehicle == null) {
        throw DatabaseException(
            message:
                'Failed to insert the vehicle with id:${comp.id} into the database');
      }
    } catch (e) {
      //probably InvalidDataException
      rethrow;
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getList() async {
    try {
      List<Vehicle> dbList = await database.getAllVehiclesWithOwner();
      var list = dbList.map(VehicleFactory.toJsonServer).toList();
      return list;
    } catch (e) {
      rethrow;
    }
  }

  void update({required String id, required dynamic json}) async {
    try {
      Vehicle item = deserialize(json);
      if (item.registrationNo.isEmpty || item.owner == null) {
        throw ArgumentError('RegistrationNo and Owner cannot be empty');
      }
      DBVehiclesCompanion vehicleComp = DBVehiclesCompanion(
          id: Value(id),
          registrationNo: Value(item.registrationNo),
          type: Value(DBVehicles.typeToInt(item.type)),
          ownerId: Value(item.owner?.id ?? '-1'));
      final rowsUpdated = await database.updateVehicle(vehicleComp, id);

      if (rowsUpdated == 0) {
        throw DatabaseException(
            message:
                'Failed to update the vehicle with id:$id in the database');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  void remove({required String id}) async {
    try {
      final result = await database.deleteVehicle(id);
      if (result == 0) {
        throw DatabaseException(
            message:
                'Failed to delete the vehicle with id:$id in the database');
      }
    } catch (e) {
      rethrow;
    }
  }

  Vehicle deserialize(Map<String, dynamic> json) => Vehicle.fromJson(json);

  Map<String, dynamic> serialize(Vehicle item) => item.toJson();

  @override
  String itemAsString() {
    return 'Vehicle';
  }
}
