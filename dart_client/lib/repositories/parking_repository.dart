import 'dart:convert';
import 'dart:io';

import 'package:dart_shared/dart_shared.dart';
import 'package:dart_client/repositories/repository.dart';

class ParkingRepository extends Repository<Parking> {
  static final ParkingRepository _instance =
      ParkingRepository._internal(path: 'parking');

  ParkingRepository._internal({required super.path});

  factory ParkingRepository() => _instance;

  @override
  Parking deserialize(Map<String, dynamic> json) => Parking.fromJson(json);

  @override
  Map<String, dynamic> serialize(Parking item) => item.toJson();

  @override
  Future<Parking> getElementById({required String id}) {
    // TODO: implement getElementById
    throw UnimplementedError();
  }
}
