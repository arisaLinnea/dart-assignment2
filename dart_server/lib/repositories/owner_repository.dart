import 'dart:convert';
import 'dart:io';

import 'package:dart_server/models/response_owner.dart';
import 'package:dart_server/repositories/repository.dart';

class OwnerRepository extends Repository<ResponseOwner> {
  static final OwnerRepository _instance = OwnerRepository._internal();

  OwnerRepository._internal();

  factory OwnerRepository() => _instance;

  @override
  ResponseOwner getElementById({required String id}) {
    return getList().firstWhere((element) => element.id == id);
  }

// TODO rewrite to use jsonDecode instead?
  @override
  void readJsonFile(String filePath) async {
    const JsonDecoder decoder = JsonDecoder();
    final storage = File(filePath);
    var jsonString = storage.readAsStringSync();
    final Map<String, dynamic> jsonmap = decoder.convert(jsonString);

    List<dynamic> owners = jsonmap['owners'];

    for (var item in owners) {
      addToList(item: ResponseOwner.fromJson(item));
    }
  }
}
