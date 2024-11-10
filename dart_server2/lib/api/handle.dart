import 'dart:convert';
import 'dart:io';

import 'package:dart_server2/repositories/repository.dart';
import 'package:shelf/shelf.dart';

Future<Response> addItemHandler(Request request, Repository repo) async {
  try {
    final data = await request.readAsString();
    final json = jsonDecode(data);

    bool success = await repo.addToList(json: json);
    if (success) {
      return Response.ok(null);
    } else {
      return Response.internalServerError(
          body:
              jsonEncode({'message': 'Failed to add ${repo.itemAsString()}'}));
    }
  } catch (e) {
    if (e is FormatException) {
      //jsonDecode
      return Response.badRequest(
          body: jsonEncode({'message': 'Failed to decode JSON'}));
    } else if (e is IOException) {
      //readAsString
      return Response.internalServerError(
          body: jsonEncode({'message': 'Error reading request data'}));
    } else if (e is FileSystemException) {
      // Handle file-related errors (e.g., file not found, permission issues)
      return Response.internalServerError(
          body: jsonEncode({'message': 'Error with file'}));
    } else if (e is StateError) {
      // Handle null or unexpected data structures
      return Response.internalServerError(
          body: jsonEncode({
        'message': 'Unexpected error with data structure: ${e.message}'
      }));
    } else {
      return Response.internalServerError(
          body: jsonEncode({
        'message': 'Unexpected error when saving new ${repo.itemAsString()}',
        'error': 'An unexpected error occurred: ${e.toString()}'
      }));
    }
  }
}

Future<Response> getItemByIdHandler(
    Request request, String id, Repository repo) async {
  try {
    return Response.ok(
      jsonEncode(repo.serialize(repo.getElementById(id: id))),
      headers: {'Content-Type': 'application/json'},
    );
  } catch (e) {
    if (e is FileSystemException) {
      // Handle file-related errors (e.g., file not found, permission issues)
      return Response.internalServerError(
          body: jsonEncode({'message': 'Error with file'}));
    } else {
      return Response.internalServerError(
          body: jsonEncode({
        'message':
            'Unexpected error when fetching a ${repo.itemAsString()} with id:$id',
        'error': 'An unexpected error occurred: ${e.toString()}'
      }));
    }
  }
}

Future<Response> getListHandler(Request request, Repository repo) async {
  try {
    final List<Map<String, dynamic>> ownerList = await repo.getList();

    return Response.ok(
      jsonEncode(ownerList),
      headers: {'Content-Type': 'application/json'},
    );
  } catch (e) {
    if (e is FileSystemException) {
      // Handle file-related errors (e.g., file not found, permission issues)
      return Response.internalServerError(
          body: jsonEncode({'message': 'Error with file'}));
    } else {
      return Response.internalServerError(
          body: jsonEncode({
        'message':
            'Unexpected error when fetching list with ${repo.itemAsString()}s',
        'error': e.toString()
      }));
    }
  }
}

Future<Response> updateItemHandler(
    Request request, String id, Repository repo) async {
  try {
    final data = await request.readAsString();
    final json = jsonDecode(data);

    bool success = await repo.update(json: json, id: id);
    if (success) {
      return Response.ok(null);
    } else {
      return Response.internalServerError(
          body: jsonEncode(
              {'message': 'Failed to update ${repo.itemAsString()}'}));
    }
  } catch (e) {
    if (e is FormatException) {
      //jsonDecode
      return Response.badRequest(
          body: jsonEncode({'message': 'Failed to decode JSON'}));
    } else if (e is IOException) {
      //readAsString
      return Response.internalServerError(
          body: jsonEncode({'message': 'Error reading request data'}));
    } else if (e is FileSystemException) {
      // Handle file-related errors (e.g., file not found, permission issues)
      return Response.internalServerError(
          body: jsonEncode({'message': 'Error with file'}));
    } else if (e is StateError) {
      // Handle null or unexpected data structures
      return Response.internalServerError(
          body: jsonEncode({
        'message': 'Unexpected error with data structure: ${e.message}'
      }));
    } else {
      return Response.internalServerError(
          body: jsonEncode({
        'message':
            'Unexpected error when updating ${repo.itemAsString()} with id:$id',
        'error': e.toString()
      }));
    }
  }
}

Future<Response> removeItemHandler(
    Request request, String id, Repository repo) async {
  try {
    bool success = await repo.remove(id: id);
    if (success) {
      return Response.ok(null);
    } else {
      return Response.internalServerError(
          body: jsonEncode(
              {'message': 'Failed to remove ${repo.itemAsString()}'}));
    }
  } catch (e) {
    if (e is FileSystemException) {
      // Handle file-related errors (e.g., file not found, permission issues)
      return Response.internalServerError(
          body: jsonEncode({'message': 'Error with file'}));
    } else {
      return Response.internalServerError(
          body: jsonEncode({
        'message':
            'Unexpected error when removing ${repo.itemAsString()} with id:$id',
        'error': e.toString()
      }));
    }
  }
}
