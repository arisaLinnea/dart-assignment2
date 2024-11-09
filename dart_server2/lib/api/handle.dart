import 'dart:convert';

import 'package:dart_server2/repositories/repository.dart';
import 'package:shelf/shelf.dart';

Future<Response> addItemHandler(Request request, Repository repo) async {
  final data = await request.readAsString();
  final json = jsonDecode(data);
  repo.addToList(json: json);

  return Response.ok(null);
}

Future<Response> getListHandler(Request request, Repository repo) async {
  final List<Map<String, dynamic>> ownerList = await repo.getList();

  return Response.ok(
    jsonEncode(ownerList),
    headers: {'Content-Type': 'application/json'},
  );
}

Future<Response> getItemByIdHandler(
    Request request, String id, Repository repo) async {
  return Response.ok(
    jsonEncode(repo.serialize(repo.getElementById(id: id))),
    headers: {'Content-Type': 'application/json'},
  );
}

Future<Response> updateItemHandler(
    Request request, String id, Repository repo) async {
  final data = await request.readAsString();
  final json = jsonDecode(data);

  repo.update(json: json, id: id);

  return Response.ok(null);
}

Future<Response> removeItemHandler(
    Request request, String id, Repository repo) async {
  repo.remove(id: id);
  return Response.ok(null);
}
