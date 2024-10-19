import 'dart:convert';
import 'dart:io';

import 'package:dart_app_cli/models/parking.dart';
import 'package:dart_app_cli/repositories/repository.dart';

class ParkingRepository extends Repository<Parking> {
  static final ParkingRepository _instance =
      ParkingRepository._internal(path: '');

  ParkingRepository._internal({required super.path});

  factory ParkingRepository() => _instance;

  @override
  Future<Parking> getElementById({required String id}) async {
    try {
      return list.firstWhere((element) => element.id == id,
          orElse: () => throw Exception('Parking not found'));
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  @override
  Future<void> readJsonFile(String filePath) async {
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
