import 'dart:convert';
import 'dart:io';

import 'package:dart_client/models/vehicle.dart';
import 'package:dart_client/repositories/repository.dart';

class VehicleRepository extends Repository<Vehicle> {
  static final VehicleRepository _instance =
      VehicleRepository._internal(path: '');

  VehicleRepository._internal({required super.path});

  factory VehicleRepository() => _instance;

  @override
  Future<Vehicle> getElementById({required String id}) async {
    return list.firstWhere((element) => element.id == id);
  }

  @override
  Future<void> readJsonFile(String filePath) async {
    const JsonDecoder decoder = JsonDecoder();
    final storage = File(filePath);
    var jsonString = storage.readAsStringSync();
    final Map<String, dynamic> jsonmap = decoder.convert(jsonString);

    List<dynamic> vehicles = jsonmap['vehicles'];

    for (var item in vehicles) {
      addToList(item: Vehicle.fromJson(item));
    }
  }

  @override
  Vehicle deserialize(Map<String, dynamic> json) => Vehicle.fromJson(json);

  @override
  Map<String, dynamic> serialize(Vehicle item) => item.toJson();
}
