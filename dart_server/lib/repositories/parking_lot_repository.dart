import 'package:dart_server/db/database.dart';
import 'package:dart_server/models/db_parkinglot.dart';
import 'package:dart_server/repositories/repository.dart';
import 'package:dart_shared/dart_shared.dart';
import 'package:drift/drift.dart';

class ParkingLotRepository extends Repository<ParkingLot> {
  static final ParkingLotRepository _instance =
      ParkingLotRepository._internal();
  final database = ParkingDatabase();

  ParkingLotRepository._internal();

  factory ParkingLotRepository() => _instance;

  @override
  void addToList({required dynamic json}) async {
    ParkingLot parkingLot = deserialize(json);
    Address address = parkingLot.address;
    DBAddressesCompanion addressComp = DBAddressesCompanion(
        street: Value(address.street),
        zipCode: Value(address.zipCode),
        city: Value(address.city));

    final addressInDB = await database.insertAddress(addressComp);
    final result = await database.insertParkingLot(DBParkinglotsCompanion(
        addressId: Value(addressInDB.id),
        hourlyPrice: Value(parkingLot.hourlyPrice)));
  }

  @override
  Future<List<Map<String, dynamic>>> getList() async {
    List<ParkingLot> dbList = await database.getAllParkingLotsWithAdress();
    return dbList.map(ParkingLotFactory.toJsonServer).toList();
  }

  @override
  void update({required String id, required dynamic json}) async {
    ParkingLot parkingLot = deserialize(json);
    Address address = parkingLot.address;
    DBAddressesCompanion addressComp = DBAddressesCompanion(
        id: Value(address.id),
        street: Value(address.street),
        zipCode: Value(address.zipCode),
        city: Value(address.city));

    DBParkinglotsCompanion parkComp = DBParkinglotsCompanion(
        addressId: Value(address.id),
        hourlyPrice: Value(parkingLot.hourlyPrice));

    final result = await database.updateAdress(addressComp, address.id);
    final result2 = await database.updateParkinglot(parkComp, id);
  }

  @override
  void remove({required String id}) async {
    await database.deleteParkingLot(id);
  }

  ParkingLot deserialize(Map<String, dynamic> json) =>
      ParkingLot.fromJson(json);

  Map<String, dynamic> serialize(DBParkinglot item) => item.toJson();
}
