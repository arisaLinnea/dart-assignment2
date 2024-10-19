import 'dart:convert';
import 'dart:io';

import 'package:dart_api/models/owner.dart';
import 'package:dart_api/repositories/repository.dart';

class OwnerRepository extends Repository<Owner> {
  static final OwnerRepository _instance = OwnerRepository._internal();

  OwnerRepository._internal();

  factory OwnerRepository() => _instance;

  @override
  Owner getElementById({required String id}) {
    return getList().firstWhere((element) => element.id == id);
  }

  @override
  void readJsonFile(String filePath) async {
    const JsonDecoder decoder = JsonDecoder();
    final storage = File(filePath);
    var jsonString = storage.readAsStringSync();
    final Map<String, dynamic> jsonmap = decoder.convert(jsonString);

    List<dynamic> owners = jsonmap['owners'];

    for (var item in owners) {
      addToList(item: Owner.fromJson(item));
    }
  }
}
