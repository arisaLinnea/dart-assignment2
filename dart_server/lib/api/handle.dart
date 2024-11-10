import 'dart:convert';
import 'dart:io';

import 'package:dart_server/repositories/repository.dart';
import 'package:dart_shared/dart_shared.dart';
import 'package:shelf/shelf.dart';

Future<Response> addItemHandler(Request request, Repository repo) async {
  try {
    final data = await request.readAsString();
    final json = jsonDecode(data);
    repo.addToList(json: json);

    return Response.ok(null);
  } catch (e) {
    if (e is FormatException) {
      //jsonDecode
      return Response.badRequest(
          body: jsonEncode({'message': 'Invalid JSON format'}));
    } else if (e is IOException) {
      //readAsString
      return Response.internalServerError(
          body: jsonEncode({'message': 'Error reading request data'}));
    } else if (e is ArgumentError) {
      //some value in the input json is missing
      return Response.badRequest(body: jsonEncode({'message': '${e.message}'}));
    } else if (e is DatabaseException) {
      //database error
      return Response.internalServerError(
          body: jsonEncode({'message': e.toString()}));
    } else {
      return Response.internalServerError(
          body: jsonEncode({
        'message': 'Unexpected error when saving new ${repo.itemAsString()}',
        'error': 'An unexpected error occurred: ${e.toString()}'
      }));
    }
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
    if (e is FormatException) {
      //jsonDecode
      return Response.badRequest(
          body: jsonEncode({'message': 'Invalid JSON format'}));
    } else if (e is IOException) {
      //readAsString
      return Response.internalServerError(
          body: jsonEncode({'message': 'Error reading request data'}));
    } else if (e is ArgumentError) {
      //some value in the input json is missing
      return Response.badRequest(body: jsonEncode({'message': '${e.message}'}));
    } else if (e is DatabaseException) {
      //database error
      return Response.internalServerError(
          body: jsonEncode({'message': e.toString()}));
    } else {
      return Response.internalServerError(
          body: jsonEncode({
        'message': 'Unexpected error when updating ${repo.itemAsString()}',
        'error': 'An unexpected error occurred: ${e.toString()}'
      }));
    }
  }
}

Future<Response> removeItemHandler(
    Request request, String id, Repository repo) async {
  try {
    repo.remove(id: id);
    return Response.ok(null);
  } catch (e) {
    if (e is DatabaseException) {
      //database error
      return Response.internalServerError(
          body: jsonEncode({'message': e.toString()}));
    } else {
      return Response.internalServerError(
          body: jsonEncode({
        'message': 'Unexpected error when deleteing ${repo.itemAsString()}',
        'error': 'An unexpected error occurred: ${e.toString()}'
      }));
    }
  }
}
