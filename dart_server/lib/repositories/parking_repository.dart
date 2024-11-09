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
    Parking item = deserialize(json);
    DBParkingsCompanion parkComp = DBParkingsCompanion(
        startTime: Value(item.startTime),
        endTime: Value(item.endTime),
        vehicleId: Value(item.vehicle?.id ?? '-1'),
        parkingLotId: Value(item.parkinglot?.id ?? '-1'));
    final parking = await database.insertParking(parkComp);
  }

  @override
  Future<List<Map<String, dynamic>>> getList() async {
    List<Parking> dbList = await database.getAllParkingsWithObjects();
    return dbList.map(ParkingFactory.toJsonServer).toList();
  }

  @override
  void update({required String id, required dynamic json}) async {
    Parking item = deserialize(json);
    DBParkingsCompanion parkComp = DBParkingsCompanion(
        id: Value(id),
        startTime: Value(item.startTime),
        endTime: Value(item.endTime),
        vehicleId: Value(item.vehicle?.id ?? '-1'),
        parkingLotId: Value(item.parkinglot?.id ?? '-1'));
    final parking = await database.updateParking(parkComp, id);
  }

  @override
  void remove({required String id}) async {
    await database.deleteParking(id);
  }

  Parking deserialize(Map<String, dynamic> json) => Parking.fromJson(json);

  Map<String, dynamic> serialize(Parking item) => item.toJson();
}
