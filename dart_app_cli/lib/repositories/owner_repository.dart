import 'dart:convert';
import 'dart:io';

import 'package:dart_app_cli/models/owner.dart';
import 'package:dart_app_cli/repositories/repository.dart';

class OwnerRepository extends Repository<Owner> {
  static final OwnerRepository _instance =
      OwnerRepository._internal(path: 'owner');

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
}
