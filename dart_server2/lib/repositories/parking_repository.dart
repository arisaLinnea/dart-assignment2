import 'dart:convert';
import 'dart:io';

import 'package:dart_server2/models/parking.dart';
import 'package:dart_server2/repositories/repository.dart';
import 'package:dart_shared/dart_shared.dart';

class ParkingRepository extends Repository<Parking> {
  static final ParkingRepository _instance = ParkingRepository._internal();

  ParkingRepository._internal();
  final String _storageName = 'parkings';

  factory ParkingRepository() => _instance;

  @override
  void addToList({required dynamic json}) async {
    Parking parking = deserialize(json);
    File file = File(super.filePath);

    var {'list': serverList, 'map': jsonmap} =
        await super.getServerList(file: file, name: _storageName);

    serverList.add(ParkingFactory.toServerJson(parking));
    jsonmap[_storageName] = serverList;
    await file.writeAsString(jsonEncode(jsonmap));
  }

  @override
  Future<Parking?> getElementById({required String id}) async {
    File file = File(super.filePath);
    var serverData = await super.getServerList(file: file, name: _storageName);
    List<dynamic> serverList = serverData['list'];
    List<Parking> parkingList = await Future.wait(
        serverList.map((json) => ParkingFactory.fromServerJson(json)));

    try {
      Parking foundParking =
          parkingList.firstWhere((parking) => parking.id == id);
      return foundParking;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getList() async {
    File file = File(super.filePath);
    var serverData = await super.getServerList(file: file, name: _storageName);
    List<dynamic> serverList = serverData['list'];
    List<Parking> parkingList = await Future.wait(
        serverList.map((json) => ParkingFactory.fromServerJson(json)));
    List<Map<String, dynamic>> resultList = parkingList.map(serialize).toList();

    return resultList;
  }

  @override
  void update({required String id, required dynamic json}) async {
    Parking parking = deserialize(json);
    File file = File(super.filePath);

    var {'list': serverList, 'map': jsonmap} =
        await super.getServerList(file: file, name: _storageName);

    List<dynamic> updatedList = serverList
        .map((json) =>
            json['id'] == id ? ParkingFactory.toServerJson(parking) : json)
        .toList();

    jsonmap[_storageName] = updatedList;
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
  Parking deserialize(Map<String, dynamic> json) => Parking.fromJson(json);

  @override
  Map<String, dynamic> serialize(Parking item) => item.toJson();
}
