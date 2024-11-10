import 'dart:convert';

import 'package:dart_client/utils/effects.dart';
import 'package:http/http.dart' as http;

abstract class Repository<T> {
  final String _path;

  Uri uri = Uri(scheme: 'http', host: 'localhost', port: 8080);

  Repository({required String path}) : _path = path;

  Map<String, dynamic> serialize(T item);
  T deserialize(Map<String, dynamic> json);
  Future<T> getElementById({required String id});

  Future<bool> addToList({required T item}) async {
    print('addList client item: ${item.toString()}');
    Uri updatedUri = uri.replace(path: '/api/$_path');
    final response = await http.post(updatedUri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(serialize(item)));
    if (response.statusCode == 200) {
      return true;
    } else {
      var body = jsonDecode(response.body);
      printError('${body['message']}');
      return false;
    }
  }

  Future<List<T>?> getList() async {
    Uri updatedUri = uri.replace(path: '/api/$_path');
    final response = await http.get(
      updatedUri,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return (json as List).map((item) => deserialize(item)).toList();
    } else {
      var body = jsonDecode(response.body);
      printError('${body['message']}');
      return null;
    }
  }

  Future<bool> update({required String id, required T item}) async {
    Uri updatedUri = uri.replace(path: '/api/$_path/$id');
    final response = await http.put(updatedUri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(serialize(item)));
    if (response.statusCode == 200) {
      return true;
    } else {
      var body = jsonDecode(response.body);
      printError('${body['message']}');
      return false;
    }
  }

  Future<bool> remove({required String id}) async {
    Uri updatedUri = uri.replace(path: '/api/$_path/$id');
    final response = await http
        .delete(updatedUri, headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      return true;
    } else {
      var body = jsonDecode(response.body);
      printError('${body['message']}');
      return false;
    }
  }
}
