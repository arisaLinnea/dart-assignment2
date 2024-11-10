import 'dart:convert';
import 'dart:io';

import 'package:dart_shared/dart_shared.dart';

import 'package:dart_client/repositories/repository.dart';

class VehicleRepository extends Repository<Vehicle> {
  static final VehicleRepository _instance =
      VehicleRepository._internal(path: 'vehicle');

  VehicleRepository._internal({required super.path});

  factory VehicleRepository() => _instance;

  @override
  Future<Vehicle> getElementById({required String id}) {
    // TODO: implement getElementById
    throw UnimplementedError();
  }

  @override
  Vehicle deserialize(Map<String, dynamic> json) => Vehicle.fromJson(json);

  @override
  Map<String, dynamic> serialize(Vehicle item) {
    print('serialize client: ${item.toString()}');
    Map<String, dynamic> s = item.toJson();
    print('toJson client: $s');

    return s;
  }
}
