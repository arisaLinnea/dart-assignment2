import 'dart:convert';

import 'package:dart_server/models/response_owner.dart';
import 'package:dart_server/repositories/owner_repository.dart';
import 'package:shelf/shelf.dart';

final OwnerRepository repo = OwnerRepository();

Future<Response> postItemHandler(Request request) async {
  final data = await request.readAsString();
  final json = jsonDecode(data);
  final ResponseOwner owner = ResponseOwner.fromJson(json);

  repo.addToList(item: owner);

  return Response.ok(null);
}

Future<Response> getItemsHandler(Request request) async {
  final List<Map<String, dynamic>> ownerList =
      repo.getList().map((e) => e.toJson()).toList();

  return Response.ok(
    jsonEncode(ownerList),
    headers: {'Content-Type': 'application/json'},
  );
}
