import 'dart:convert';
import 'dart:io';

import 'package:dart_server2/models/parking_lot.dart';
import 'package:dart_server2/repositories/repository.dart';
import 'package:dart_shared/dart_shared.dart';

class ParkingLotRepository extends Repository<ParkingLot> {
  static final ParkingLotRepository _instance =
      ParkingLotRepository._internal();

  ParkingLotRepository._internal();
  final String _storageName = 'parkinglots';

  factory ParkingLotRepository() => _instance;

  @override
  void addToList({required dynamic json}) async {
    ParkingLot parkinglot = deserialize(json);
    File file = File(super.filePath);

    var {'list': serverList, 'map': jsonmap} =
        await super.getServerList(file: file, name: _storageName);

    serverList.add(ParkingLotFactory.toServerJson(parkinglot));

    jsonmap[_storageName] = serverList;
    await file.writeAsString(jsonEncode(jsonmap));
  }

  @override
  Future<ParkingLot?> getElementById({required String id}) async {
    File file = File(super.filePath);
    var serverData = await super.getServerList(file: file, name: _storageName);
    List<dynamic> serverList = serverData['list'];
    List<ParkingLot> lotList = await Future.wait(
        serverList.map((json) => ParkingLotFactory.fromServerJson(json)));

    try {
      ParkingLot foundLot = lotList.firstWhere((lot) => lot.id == id);
      return foundLot;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getList() async {
    File file = File(super.filePath);
    var serverData = await super.getServerList(file: file, name: _storageName);
    List<dynamic> serverList = serverData['list'];
    List<ParkingLot> lotList = await Future.wait(
        serverList.map((json) => ParkingLotFactory.fromServerJson(json)));
    List<Map<String, dynamic>> resultList = lotList.map(serialize).toList();

    return resultList;
  }

  @override
  void update({required String id, required dynamic json}) async {
    ParkingLot parkinglot = deserialize(json);
    File file = File(super.filePath);

    var {'list': serverList, 'map': jsonmap} =
        await super.getServerList(file: file, name: _storageName);

    List<dynamic> updatedList = serverList
        .map((json) => json['id'] == id
            ? ParkingLotFactory.toServerJson(parkinglot)
            : json)
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
  ParkingLot deserialize(Map<String, dynamic> json) =>
      ParkingLot.fromJson(json);

  @override
  Map<String, dynamic> serialize(ParkingLot item) => item.toJson();
}
