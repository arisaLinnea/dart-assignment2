import 'dart:convert';
import 'dart:io';

import 'package:dart_server/models/response_vehicle.dart';
import 'package:dart_server/repositories/repository.dart';

class VehicleRepository extends Repository<ResponseVehicle> {
  static final VehicleRepository _instance = VehicleRepository._internal();

  VehicleRepository._internal();

  factory VehicleRepository() => _instance;

  @override
  ResponseVehicle getElementById({required String id}) {
    return super.getList().firstWhere((element) => element.id == id);
  }

  @override
  ResponseVehicle deserialize(Map<String, dynamic> json) =>
      ResponseVehicle.fromJson(json);

  @override
  Map<String, dynamic> serialize(ResponseVehicle item) => item.toJson();

  @override
  void readJsonFile(String filePath) {
    const JsonDecoder decoder = JsonDecoder();
    final storage = File(filePath);
    var jsonString = storage.readAsStringSync();
    final Map<String, dynamic> jsonmap = decoder.convert(jsonString);

    List<dynamic> vehicles = jsonmap['vehicles'];

    for (var item in vehicles) {
      addToList(item: ResponseVehicle.fromJson(item));
    }
  }
}
