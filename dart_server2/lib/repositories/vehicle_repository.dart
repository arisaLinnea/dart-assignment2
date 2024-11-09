import 'dart:convert';
import 'dart:io';

import 'package:dart_server2/models/vehicle.dart';
import 'package:dart_server2/repositories/repository.dart';
import 'package:dart_shared/dart_shared.dart';

class VehicleRepository extends Repository<Vehicle> {
  static final VehicleRepository _instance = VehicleRepository._internal();

  VehicleRepository._internal();
  final String _storageName = 'vehicles';

  factory VehicleRepository() => _instance;

  @override
  void addToList({required dynamic json}) async {
    Vehicle vehicle = deserialize(json);
    File file = File(super.filePath);

    var {'list': serverList, 'map': jsonmap} =
        await super.getServerList(file: file, name: _storageName);

    serverList.add(VehicleFactory.toServerJson(vehicle));

    jsonmap[_storageName] = serverList;
    await file.writeAsString(jsonEncode(jsonmap));
  }

  @override
  Future<Vehicle?> getElementById({required String id}) async {
    try {
      File file = File(super.filePath);
      var serverData =
          await super.getServerList(file: file, name: _storageName);
      List<dynamic> serverList = serverData['list'];
      List<Vehicle> vehicleList = await Future.wait(
          serverList.map((json) => VehicleFactory.fromServerJson(json)));
      Vehicle foundVehicle =
          vehicleList.firstWhere((vehicle) => vehicle.id == id);
      return foundVehicle;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getList() async {
    File file = File(super.filePath);
    var serverData = await super.getServerList(file: file, name: _storageName);
    List<dynamic> serverList = serverData['list'];
    List<Vehicle> vehicleList = await Future.wait(
        serverList.map((json) => VehicleFactory.fromServerJson(json)));
    List<Map<String, dynamic>> jsonList = vehicleList.map(serialize).toList();

    return jsonList;
  }

  void update({required String id, required dynamic json}) async {
    Vehicle vehicle = deserialize(json);
    File file = File(super.filePath);

    var {'list': serverList, 'map': jsonmap} =
        await super.getServerList(file: file, name: _storageName);

    List<dynamic> updatedList = serverList
        .map((json) =>
            json['id'] == id ? VehicleFactory.toServerJson(vehicle) : json)
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
  Vehicle deserialize(Map<String, dynamic> json) => Vehicle.fromJson(json);

  @override
  Map<String, dynamic> serialize(Vehicle item) => item.toJson();
}
