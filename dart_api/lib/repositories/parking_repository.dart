import 'dart:convert';
import 'dart:io';

import 'package:dart_api/models/parking.dart';
import 'package:dart_api/repositories/repository.dart';

class ParkingRepository extends Repository<Parking> {
  static final ParkingRepository _instance = ParkingRepository._internal();

  ParkingRepository._internal();

  factory ParkingRepository() => _instance;

  @override
  Parking getElementById({required String id}) {
    return super.getList().firstWhere((element) => element.id == id);
  }

  @override
  void readJsonFile(String filePath) {
    const JsonDecoder decoder = JsonDecoder();
    final storage = File(filePath);
    var jsonString = storage.readAsStringSync();
    final Map<String, dynamic> jsonmap = decoder.convert(jsonString);

    List<dynamic> parkings = jsonmap['parkings'];

    for (var item in parkings) {
      addToList(item: Parking.fromJson(item));
    }
  }
}
