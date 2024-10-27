import 'dart:convert';
import 'dart:io';

import 'package:dart_client/models/parkinglot.dart';
import 'package:dart_client/repositories/repository.dart';

class ParkingLotRepository extends Repository<ParkingLot> {
  static final ParkingLotRepository _instance =
      ParkingLotRepository._internal(path: 'parkinglot');

  ParkingLotRepository._internal({required super.path});

  factory ParkingLotRepository() => _instance;

  @override
  Future<ParkingLot> getElementById({required String id}) async {
    try {
      return list.firstWhere((element) => element.id == id,
          orElse: () => throw Exception('ParkingLot not found'));
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  // @override
  // Future<ParkingLot> getElementById({required String id}) {
  //   return _list.firstWhere((element) => element.id == id);
  // }

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
