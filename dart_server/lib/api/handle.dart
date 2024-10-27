import 'dart:convert';
import 'dart:io';

import 'package:dart_server/repositories/repository.dart';
import 'package:shelf/shelf.dart';

Future<Response> addItemHandler(Request request, Repository repo) async {
  final data = await request.readAsString();
  final json = jsonDecode(data);
  repo.addToList(item: repo.deserialize(json));

  return Response.ok(null);
}

Future<Response> getListHandler(Request request, Repository repo) async {
  final List<Map<String, dynamic>> ownerList =
      repo.getList().map(repo.serialize).toList();
  // List<dynamic> list = repo.getList();
  // print('List: $list');
  // List ownerList = [];
  // list.forEach((element) {
  //   Map<String, dynamic> tmp = repo.serialize(element);
  //   print('serializible object: $tmp');
  //   ownerList.add(tmp);
  // });

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
    Request request, String index, Repository repo) async {
  final data = await request.readAsString();
  final json = jsonDecode(data);

  repo.update(item: repo.deserialize(json), index: int.parse(index));

  return Response.ok(null);
}

Future<Response> removeItemHandler(
    Request request, String index, Repository repo) async {
  //we can't be routed here unless there is an index, but must check if it's an integer
  int? position = int.tryParse(index);
  if (position == null || position > repo.getListLength() - 1) {
    return Response.badRequest();
  }

  repo.remove(index: position);
  return Response.ok(null);
}
