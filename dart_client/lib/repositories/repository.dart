import 'dart:convert';

import 'package:http/http.dart' as http;

abstract class Repository<T> {
  List<T> list = [];
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
      throw Exception('Failed to add to list');
    }
    // list.add(item);
  }

  Future<List<T>> getList() async {
    Uri updatedUri = uri.replace(path: '/api/$_path');
    final response = await http.get(
      updatedUri,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      print('getList: $json');
      return (json as List).map((item) => deserialize(item)).toList();
    } else {
      throw Exception('Failed to get list');
    }

    //return list;
  }

  Future<bool> update({required int index, required T item}) async {
    Uri updatedUri = uri.replace(path: '/api/$_path/$index');
    final response = await http.put(updatedUri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(serialize(item)));
    print('GetList response ${response.statusCode}   ${response.body}');
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to update');
    }

    // list[index] = item;
  }

  Future<bool> remove({required int index}) async {
    Uri updatedUri = uri.replace(path: '/api/$_path/$index');

    final response = await http
        .delete(updatedUri, headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to add to list');
    }

    // T item = list.elementAt(index);
    // list.remove(item);
  }

  Future<void> readJsonFile(String filePath);
}
