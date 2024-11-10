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
    try {
      ParkingLot parkingLot = deserialize(json);
      if (parkingLot.hourlyPrice.isNaN ||
          parkingLot.address == null ||
          parkingLot.address?.street == null ||
          parkingLot.address?.city == null ||
          parkingLot.address?.zipCode == null) {
        throw ArgumentError(
            'Street, zipcode, city or hourlyPrice cannot be empty');
      }
      Address? address = parkingLot.address;
      DBAddressesCompanion addressComp = DBAddressesCompanion(
          street: Value(address?.street ?? ''),
          zipCode: Value(address?.zipCode ?? ''),
          city: Value(address?.city ?? ''));

      final addressInDB = await database.insertAddress(addressComp);
      if (addressInDB == null) {
        throw DatabaseException(
            message: 'Failed to insert the address into the database');
      }
      DBParkinglotsCompanion parkinglotComp = DBParkinglotsCompanion(
          addressId: Value(addressInDB.id),
          hourlyPrice: Value(parkingLot.hourlyPrice));
      final result = await database.insertParkingLot(parkinglotComp);
      if (result == null) {
        throw DatabaseException(
            message:
                'Failed to insert the parkinglot with id:${parkinglotComp.id} into the database');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getList() async {
    try {
      List<ParkingLot> dbList = await database.getAllParkingLotsWithAdress();
      return dbList.map(ParkingLotFactory.toJsonServer).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  void update({required String id, required dynamic json}) async {
    try {
      ParkingLot parkingLot = deserialize(json);
      if (parkingLot.hourlyPrice.isNaN ||
          parkingLot.address == null ||
          parkingLot.address?.street == null ||
          parkingLot.address?.city == null ||
          parkingLot.address?.zipCode == null) {
        throw ArgumentError(
            'Street, zipcode, city or hourlyPrice cannot be empty');
      }
      Address? address = parkingLot.address;
      DBAddressesCompanion addressComp = DBAddressesCompanion(
          id: Value(address?.id ?? '-1'),
          street: Value(address?.street ?? ''),
          zipCode: Value(address?.zipCode ?? ''),
          city: Value(address?.city ?? ''));

      DBParkinglotsCompanion parkComp = DBParkinglotsCompanion(
          addressId: Value(address?.id ?? '-1'),
          hourlyPrice: Value(parkingLot.hourlyPrice));

      final addressRowsUpdated =
          await database.updateAdress(addressComp, address?.id ?? '-1');
      if (addressRowsUpdated == 0) {
        throw DatabaseException(
            message: 'Failed to update the address in the database');
      }
      final parkinglotRowsUpdated =
          await database.updateParkinglot(parkComp, id);

      if (parkinglotRowsUpdated == 0) {
        throw DatabaseException(
            message:
                'Failed to update the parkinglot with id:$id in the database');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  void remove({required String id}) async {
    try {
      final result = await database.deleteParkingLot(id);
      if (result == 0) {
        throw DatabaseException(
            message:
                'Failed to delete the parkinglot with id:$id in the database');
      }
    } catch (e) {
      rethrow;
    }
  }

  ParkingLot deserialize(Map<String, dynamic> json) =>
      ParkingLot.fromJson(json);

  Map<String, dynamic> serialize(DBParkinglot item) => item.toJson();

  @override
  String itemAsString() {
    return 'Parkinglot';
  }
}
