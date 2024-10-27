import 'dart:convert';
import 'dart:io';

import 'package:dart_server/models/response_parkinglot.dart';
import 'package:dart_server/repositories/repository.dart';

class ParkingLotRepository extends Repository<ResponseParkingLot> {
  static final ParkingLotRepository _instance =
      ParkingLotRepository._internal();

  ParkingLotRepository._internal();

  factory ParkingLotRepository() => _instance;

  @override
  ResponseParkingLot getElementById({required String id}) {
    return super.getList().firstWhere((element) => element.id == id);
  }

  @override
  ResponseParkingLot deserialize(Map<String, dynamic> json) =>
      ResponseParkingLot.fromJson(json);

  @override
  Map<String, dynamic> serialize(ResponseParkingLot item) => item.toJson();

  @override
  void readJsonFile(String filePath) {
    const JsonDecoder decoder = JsonDecoder();
    final storage = File(filePath);
    var jsonString = storage.readAsStringSync();
    final Map<String, dynamic> jsonmap = decoder.convert(jsonString);

    List<dynamic> parkinglots = jsonmap['parkinglots'];

    for (var item in parkinglots) {
      addToList(item: ResponseParkingLot.fromJson(item));
    }
  }
}
