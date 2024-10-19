import 'dart:convert';
import 'dart:io';

import 'package:dart_api/models/vehicle.dart';
import 'package:dart_api/repositories/repository.dart';

class VehicleRepository extends Repository<Vehicle> {
  static final VehicleRepository _instance = VehicleRepository._internal();

  VehicleRepository._internal();

  factory VehicleRepository() => _instance;

  @override
  Vehicle getElementById({required String id}) {
    return super.getList().firstWhere((element) => element.id == id);
  }

  @override
  void readJsonFile(String filePath) {
    const JsonDecoder decoder = JsonDecoder();
    final storage = File(filePath);
    var jsonString = storage.readAsStringSync();
    final Map<String, dynamic> jsonmap = decoder.convert(jsonString);

    List<dynamic> vehicles = jsonmap['vehicles'];

    for (var item in vehicles) {
      addToList(item: Vehicle.fromJson(item));
    }
  }
}
