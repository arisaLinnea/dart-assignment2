import 'dart:convert';
import 'dart:io';

import 'package:dart_shared/dart_shared.dart';
import 'package:dart_client/repositories/repository.dart';

class ParkingLotRepository extends Repository<ParkingLot> {
  static final ParkingLotRepository _instance =
      ParkingLotRepository._internal(path: 'parkinglot');

  ParkingLotRepository._internal({required super.path});

  factory ParkingLotRepository() => _instance;

  @override
  Future<ParkingLot> getElementById({required String id}) {
    // TODO: implement getElementById
    throw UnimplementedError();
  }

  @override
  Future<void> readJsonFile(String filePath) async {
    const JsonDecoder decoder = JsonDecoder();
    final storage = File(filePath);
    var jsonString = storage.readAsStringSync();
    final Map<String, dynamic> jsonmap = decoder.convert(jsonString);

    List<dynamic> parkinglots = jsonmap['parkinglots'];

    for (var item in parkinglots) {
      addToList(item: ParkingLot.fromJson(item));
    }
  }

  @override
  ParkingLot deserialize(Map<String, dynamic> json) =>
      ParkingLot.fromJson(json);

  @override
  Map<String, dynamic> serialize(ParkingLot item) => item.toJson();
}
