import 'dart:convert';
import 'dart:io';

import 'package:dart_server2/models/owner.dart';
import 'package:dart_server2/repositories/repository.dart';
import 'package:dart_shared/dart_shared.dart';

class OwnerRepository extends Repository<Owner> {
  static final OwnerRepository _instance = OwnerRepository._internal();

  OwnerRepository._internal();
  final String _storageName = 'owners';

  factory OwnerRepository() => _instance;

  @override
  void addToList({required dynamic json}) async {
    Owner owner = deserialize(json);
    File file = File(super.filePath);

    var {'list': serverList, 'map': jsonmap} =
        await super.getServerList(file: file, name: _storageName);

    serverList.add(OwnerFactory.toServerJson(owner));

    jsonmap[_storageName] = serverList;
    await file.writeAsString(jsonEncode(jsonmap));
  }

  @override
  Future<Owner?> getElementById({required String id}) async {
    File file = File(super.filePath);
    var serverData = await super.getServerList(file: file, name: _storageName);
    List<dynamic> serverList = serverData['list'];
    List<Owner> ownersList = await Future.wait(
        serverList.map((json) => OwnerFactory.fromServerJson(json)));

    try {
      Owner foundOwner = ownersList.firstWhere((owner) => owner.id == id);
      return foundOwner;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getList() async {
    File file = File(super.filePath);
    var serverData = await super.getServerList(file: file, name: _storageName);
    List<dynamic> serverList = serverData['list'];
    List<Owner> ownersList = await Future.wait(
        serverList.map((json) => OwnerFactory.fromServerJson(json)));
    List<Map<String, dynamic>> resultList = ownersList.map(serialize).toList();

    return resultList;
  }

  @override
  void update({required String id, required dynamic json}) async {
    Owner owner = deserialize(json);
    File file = File(super.filePath);

    var {'list': serverList, 'map': jsonmap} =
        await super.getServerList(file: file, name: _storageName);

    List<dynamic> updatedList = serverList
        .map((json) =>
            json['id'] == id ? OwnerFactory.toServerJson(owner) : json)
        .toList();
    jsonmap['owners'] = updatedList;
    await file.writeAsString(jsonEncode(jsonmap));
  }

  @override
  void remove({required String id}) async {
    File file = File(super.filePath);

    var {'list': serverList, 'map': jsonmap} =
        await super.getServerList(file: file, name: _storageName);

    serverList.removeWhere((json) => json['id'] == id);
    jsonmap[_storageName] = serverList;
    await file.writeAsString(jsonEncode(jsonmap));
  }

  @override
  Owner deserialize(Map<String, dynamic> json) => Owner.fromJson(json);

  @override
  Map<String, dynamic> serialize(Owner item) => item.toJson();
}
