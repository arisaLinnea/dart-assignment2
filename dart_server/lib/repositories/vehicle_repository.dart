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
    Vehicle item = deserialize(json);
    DBVehiclesCompanion comp = DBVehiclesCompanion(
        registrationNo: Value(item.registrationNo),
        type: Value(DBVehicles.typeToInt(item.type)),
        ownerId: Value(item.owner?.id ?? '-1'));
    final vehicle = await database.insertVehicle(comp);
  }

  @override
  Future<List<Map<String, dynamic>>> getList() async {
    List<Vehicle> dbList = await database.getAllVehiclesWithOwner();
    var list = dbList.map(VehicleFactory.toJsonServer).toList();
    return list;
  }

  void update({required String id, required dynamic json}) async {
    Vehicle item = deserialize(json);
    DBVehiclesCompanion vehicleComp = DBVehiclesCompanion(
        id: Value(id),
        registrationNo: Value(item.registrationNo),
        type: Value(DBVehicles.typeToInt(item.type)),
        ownerId: Value(item.owner?.id ?? '-1'));
    final vehicle = await database.updateVehicle(vehicleComp, id);
  }

  @override
  void remove({required String id}) async {
    await database.deleteVehicle(id);
  }

  Vehicle deserialize(Map<String, dynamic> json) => Vehicle.fromJson(json);

  Map<String, dynamic> serialize(Vehicle item) => item.toJson();
}
