import 'dart:convert';
import 'dart:io';

import 'package:dart_server/models/response_parking.dart';
import 'package:dart_server/repositories/repository.dart';

class ParkingRepository extends Repository<ResponseParking> {
  static final ParkingRepository _instance = ParkingRepository._internal();

  ParkingRepository._internal();

  factory ParkingRepository() => _instance;

  @override
  ResponseParking getElementById({required String id}) {
    return super.getList().firstWhere((element) => element.id == id);
  }

  @override
  ResponseParking deserialize(Map<String, dynamic> json) =>
      ResponseParking.fromJson(json);

  @override
  Map<String, dynamic> serialize(ResponseParking item) => item.toJson();

  @override
  void readJsonFile(String filePath) {
    const JsonDecoder decoder = JsonDecoder();
    final storage = File(filePath);
    var jsonString = storage.readAsStringSync();
    final Map<String, dynamic> jsonmap = decoder.convert(jsonString);

    List<dynamic> parkings = jsonmap['parkings'];

    for (var item in parkings) {
      addToList(item: ResponseParking.fromJson(item));
    }
  }
}
