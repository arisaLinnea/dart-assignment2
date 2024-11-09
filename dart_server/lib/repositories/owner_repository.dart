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
    Owner owner = deserialize(json);
    DBOwnersCompanion ownerComp = DBOwnersCompanion(
      name: Value(owner.name),
      ssn: Value(owner.ssn),
    );

    final result = await database.insertOwner(ownerComp);
  }

  @override
  Future<List<Map<String, dynamic>>> getList() async {
    List<DBOwner> dbList = await database.getAllOwners();

    var list = dbList.map(serialize).toList();
    return list;
  }

  @override
  void update({required String id, required dynamic json}) async {
    Owner owner = deserialize(json);
    DBOwnersCompanion ownerComp = DBOwnersCompanion(
      id: Value(id),
      name: Value(owner.name),
      ssn: Value(owner.ssn),
    );

    final result = await database.updateOwner(ownerComp, id);
  }

  @override
  void remove({required String id}) async {
    await database.deleteOwner(id);
  }

  Owner deserialize(Map<String, dynamic> json) => Owner.fromJson(json);

  Map<String, dynamic> serialize(DBOwner item) => item.toJson();
}
