import 'dart:io';

import 'package:dart_server/models/db_parking.dart';
import 'package:dart_server/models/db_parkinglot.dart';
import 'package:dart_server/models/db_vehicle.dart';
import 'package:dart_shared/dart_shared.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart';
import 'package:dart_server/models/db_owner.dart';

part 'database.g.dart';

@DriftDatabase(
    tables: [DBOwners, DBAddresses, DBParkinglots, DBVehicles, DBParkings])
class ParkingDatabase extends _$ParkingDatabase {
  ParkingDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Vehicle _mapToVehicle(TypedResult result) {
    DBOwner owner = result.readTable(dBOwners);
    DBVehicle vehicle = result.readTable(dBVehicles);
    return Vehicle(
        id: vehicle.id,
        registrationNo: vehicle.registrationNo,
        type: VehicleType.values[vehicle.type],
        owner: Owner(id: owner.id, name: owner.name, ssn: owner.ssn));
  }

  ParkingLot _mapToParkingLot(TypedResult result) {
    DBAddress address = result.readTable(dBAddresses);
    DBParkinglot parkinglot = result.readTable(dBParkinglots);
    return ParkingLot(
        id: parkinglot.id,
        hourlyPrice: parkinglot.hourlyPrice,
        address: Address(
            id: address.id,
            street: address.street,
            zipCode: address.zipCode,
            city: address.city));
  }

  Parking _mapToVParking(TypedResult result) {
    DBVehicle vehicle = result.readTable(dBVehicles);
    DBOwner owner = result.readTable(dBOwners);
    DBParkinglot parkinglot = result.readTable(dBParkinglots);
    DBAddress address = result.readTable(dBAddresses);
    DBParking parking = result.readTable(dBParkings);
    return Parking(
        id: parking.id,
        startTime: parking.startTime,
        endTime: parking.endTime,
        vehicle: Vehicle(
            id: vehicle.id,
            registrationNo: vehicle.registrationNo,
            type: VehicleType.values[vehicle.type],
            owner: Owner(id: owner.id, name: owner.name, ssn: owner.ssn)),
        parkinglot: ParkingLot(
            id: parkinglot.id,
            address: Address(
                id: address.id,
                street: address.street,
                zipCode: address.zipCode,
                city: address.city),
            hourlyPrice: parkinglot.hourlyPrice));
  }

  // Owner
  Future insertOwner(Insertable<DBOwner> user) => into(dBOwners).insert(user);
  Future<List<DBOwner>> getAllOwners() => select(dBOwners).get();
  Future<void> deleteOwner(String id) {
    return (delete(dBOwners)..where((owner) => owner.id.equals(id))).go();
  }

  Future<int> updateOwner(Insertable<DBOwner> ownerToUpdate, String id) =>
      (update(dBOwners)..where((owner) => owner.id.equals(id)))
          .write(ownerToUpdate);

//Vehicle
  Future insertVehicle(Insertable<DBVehicle> vehicle) =>
      into(dBVehicles).insert(vehicle);
  Future<List<DBVehicle>> getAllVehicles() => select(dBVehicles).get();
  Future<List<Vehicle>> getAllVehiclesWithOwner() {
    final query = select(dBVehicles);
    final vehiclesWithOwner = query
        .join([innerJoin(dBOwners, dBOwners.id.equalsExp(dBVehicles.ownerId))])
        .map(_mapToVehicle)
        .get();
    return vehiclesWithOwner;
  }

  Future<int> updateVehicle(Insertable<DBVehicle> vehicleToUpdate, String id) =>
      (update(dBVehicles)..where((vehicle) => vehicle.id.equals(id)))
          .write(vehicleToUpdate);

  Future<void> deleteVehicle(String id) {
    return (delete(dBVehicles)..where((vehicle) => vehicle.id.equals(id))).go();
  }

//Parkinglot
  Future insertParkingLot(Insertable<DBParkinglot> parkingLot) =>
      into(dBParkinglots).insert(parkingLot);
  Future insertAddress(Insertable<DBAddress> address) =>
      into(dBAddresses).insertReturningOrNull(address);
  Future<List<DBParkinglot>> getAllParkingLots() => select(dBParkinglots).get();
  Future<List<ParkingLot>> getAllParkingLotsWithAdress() {
    final query = select(dBParkinglots);
    final parkingLotsWithAdress = query
        .join([
          innerJoin(
              dBAddresses, dBAddresses.id.equalsExp(dBParkinglots.addressId)),
        ])
        .map(_mapToParkingLot)
        .get();
    return parkingLotsWithAdress;
  }

  Future<int> updateAdress(Insertable<DBAddress> addressToUpdate, String id) =>
      (update(dBAddresses)..where((address) => address.id.equals(id)))
          .write(addressToUpdate);
  Future<int> updateParkinglot(
          Insertable<DBParkinglot> parkinglotToUpdate, String id) =>
      (update(dBParkinglots)..where((parkinglot) => parkinglot.id.equals(id)))
          .write(parkinglotToUpdate);

  Future<int> deleteParkingLot(String id) async {
    //Don't want an adress left in the db not belonging to anything
    DBParkinglot dbparking = await (select(dBParkinglots)
          ..where((tbl) => tbl.id.equals(id)))
        .getSingle();
    (delete(dBAddresses)
          ..where((address) => address.id.equals(dbparking.addressId)))
        .go();
    return (delete(dBParkinglots)
          ..where((parkinglots) => parkinglots.id.equals(id)))
        .go();
  }

  Future<int> deleteAddress(String id) {
    return (delete(dBAddresses)..where((address) => address.id.equals(id)))
        .go();
  }

//Parkings
  Future insertParking(Insertable<DBParking> parking) =>
      into(dBParkings).insert(parking);
  Future<List<DBParking>> getAllParkings() => select(dBParkings).get();
  Future<List<Parking>> getAllParkingsWithObjects() {
    final query = select(dBParkings);
    final parkingsWithObjectData = query
        .join([
          innerJoin(dBVehicles, dBVehicles.id.equalsExp(dBParkings.vehicleId)),
          innerJoin(dBOwners, dBOwners.id.equalsExp(dBVehicles.ownerId)),
          innerJoin(dBParkinglots,
              dBParkinglots.id.equalsExp(dBParkings.parkingLotId)),
          innerJoin(
              dBAddresses, dBAddresses.id.equalsExp(dBParkinglots.addressId))
        ])
        .map(_mapToVParking)
        .get();
    return parkingsWithObjectData;
  }

  Future<int> updateParking(Insertable<DBParking> parkingToUpdate, String id) =>
      (update(dBParkings)..where((parking) => parking.id.equals(id)))
          .write(parkingToUpdate);
  Future<void> deleteParking(String id) {
    return (delete(dBParkings)..where((parking) => parking.id.equals(id))).go();
  }
}

LazyDatabase _openConnection() {
  final file = File(join(Directory.current.path, 'storage.db'));
  return LazyDatabase(() async => NativeDatabase(file));
}
