import 'dart:convert';
import 'dart:io';
import 'package:logger/logger.dart';

import 'package:dart_server/repositories/repository.dart';
import 'package:dart_shared/dart_shared.dart';
import 'package:shelf/shelf.dart';

var logger = Logger();

Response handleError(Object e, {String? customMessage}) {
  String message = customMessage ?? 'An unexpected error occurred';
  if (e is FormatException) {
    return Response.badRequest(
        body: jsonEncode({'message': 'Invalid JSON format'}));
  } else if (e is IOException) {
    return Response.internalServerError(
        body: jsonEncode({'message': 'Error reading request data'}));
  } else if (e is ArgumentError) {
    return Response.badRequest(body: jsonEncode({'message': '${e.message}'}));
  } else if (e is DatabaseException) {
    return Response.internalServerError(
        body: jsonEncode({'message': e.toString()}));
  } else {
    return Response.internalServerError(
        body: jsonEncode({'message': message, 'error': e.toString()}));
  }
}

Future<Response> addItemHandler(Request request, Repository repo) async {
  try {
    final data = await request.readAsString();
    final json = jsonDecode(data);
    repo.addToList(json: json);

    return Response.ok(null);
  } catch (e) {
    logger.e("Error adding item to list of ${repo.itemAsString()}s: $e");
    return handleError(e,
        customMessage: 'Failed to add ${repo.itemAsString()}');
  }
}

Future<Response> getListHandler(Request request, Repository repo) async {
  try {
    List<Map<String, dynamic>> list = await repo.getList();
    return Response.ok(
      jsonEncode(list),
      headers: {'Content-Type': 'application/json'},
    );
  } catch (e) {
    logger.e("Error fetching item: $e");
    return Response.internalServerError(
        body: jsonEncode({
      'message':
          'Unexpected error when fetching list with ${repo.itemAsString()}s',
      'error': e.toString()
    }));
  }
}

Future<Response> updateItemHandler(
    Request request, String id, Repository repo) async {
  try {
    final data = await request.readAsString();
    final json = jsonDecode(data);

    repo.update(json: json, id: id);

    return Response.ok(null);
  } catch (e) {
    logger.e(
        "Error updating item with ID $id in list of ${repo.itemAsString()}s: $e");
    return handleError(e,
        customMessage: 'updating ${repo.itemAsString()} with ID $id');
  }
}

Future<Response> removeItemHandler(
    Request request, String id, Repository repo) async {
  try {
    repo.remove(id: id);
    return Response.ok(null);
  } catch (e) {
    logger.e(
        "Error deleting item with ID $id in list of ${repo.itemAsString()}s: $e");
    return handleError(e,
        customMessage: 'deleting ${repo.itemAsString()} with ID $id');
  }
}
