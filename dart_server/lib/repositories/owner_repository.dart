import 'package:dart_server/repositories/repository.dart';
import 'package:dart_shared/dart_shared.dart';
import 'package:drift/drift.dart';
import 'package:dart_server/db/database.dart';

class OwnerRepository extends Repository<Owner> {
  static final OwnerRepository _instance = OwnerRepository._internal();
  final database = ParkingDatabase();

  OwnerRepository._internal();

  factory OwnerRepository() => _instance;

  @override
  void addToList({required dynamic json}) async {
    try {
      Owner owner = deserialize(json);
      if (owner.name.isEmpty || owner.ssn.isEmpty) {
        throw ArgumentError('Name and SSN cannot be empty');
      }

      DBOwnersCompanion ownerComp = DBOwnersCompanion(
        name: Value(owner.name),
        ssn: Value(owner.ssn),
      );

      // Insert into the database
      final result = await database.insertOwner(ownerComp);

      if (result == null) {
        throw DatabaseException(
            message:
                'Failed to insert the owner with id:${ownerComp.id} into the database');
      }
    } catch (e) {
      //probably InvalidDataException
      rethrow;
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getList() async {
    try {
      List<DBOwner> dbList = await database.getAllOwners();
      var list = dbList.map(serialize).toList();
      return list;
    } catch (e) {
      rethrow;
    }
  }

  @override
  void update({required String id, required dynamic json}) async {
    try {
      Owner owner = deserialize(json);
      if (owner.name.isEmpty || owner.ssn.isEmpty) {
        throw ArgumentError('Name and SSN cannot be empty');
      }
      DBOwnersCompanion ownerComp = DBOwnersCompanion(
        id: Value(id),
        name: Value(owner.name),
        ssn: Value(owner.ssn),
      );

      final rowsUpdated = await database.updateOwner(ownerComp, id);
      if (rowsUpdated == 0) {
        throw DatabaseException(
            message: 'Failed to update the owner with id:$id in the database');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  void remove({required String id}) async {
    try {
      final result = await database.deleteOwner(id);
      if (result == 0) {
        throw DatabaseException(
            message: 'Failed to delete the owner with id:$id in the database');
      }
    } catch (e) {
      rethrow;
    }
  }

  Owner deserialize(Map<String, dynamic> json) => Owner.fromJson(json);

  Map<String, dynamic> serialize(DBOwner item) => item.toJson();

  @override
  String itemAsString() {
    return 'Owner';
  }
}
