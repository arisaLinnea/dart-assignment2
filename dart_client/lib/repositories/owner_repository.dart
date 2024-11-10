import 'dart:convert';
import 'dart:io';

import 'package:dart_shared/dart_shared.dart';
import 'package:dart_client/repositories/repository.dart';

class OwnerRepository extends Repository<Owner> {
  static final OwnerRepository _instance =
      OwnerRepository._internal(path: 'owner');

  OwnerRepository._internal({required super.path});

  factory OwnerRepository() => _instance;

  @override
  Future<Owner> getElementById({required String id}) {
    // TODO: implement getElementById
    throw UnimplementedError();
  }

  @override
  Owner deserialize(Map<String, dynamic> json) => Owner.fromJson(json);

  @override
  Map<String, dynamic> serialize(Owner item) => item.toJson();
}
