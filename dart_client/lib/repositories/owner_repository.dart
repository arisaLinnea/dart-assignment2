import 'dart:convert';
import 'dart:io';

import 'package:dart_client/models/owner.dart';
import 'package:dart_client/repositories/repository.dart';

class OwnerRepository extends Repository<Owner> {
  static final OwnerRepository _instance =
      OwnerRepository._internal(path: 'owners');

  OwnerRepository._internal({required super.path});

  factory OwnerRepository() => _instance;

  @override
  Future<Owner> getElementById({required String id}) async {
    try {
      return list.firstWhere((element) => element.id == id,
          orElse: () => throw Exception('Owner not found'));
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

    List<dynamic> owners = jsonmap['owners'];

    for (var item in owners) {
      addToList(item: Owner.fromJson(item));
    }
  }

  @override
  Owner deserialize(Map<String, dynamic> json) => Owner.fromJson(json);

  @override
  Map<String, dynamic> serialize(Owner item) => item.toJson();
}
