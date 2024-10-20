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

/*
/persons	GET	Hämta alla personer	getAll()
/persons	POST	Skapa ny person	create()
/persons/<id>	GET	Hämta specifik person	getById()
/persons/<id>	PUT	Uppdatera specifik person	update()
/persons/<id>	DELETE	Ta bort specifik person	delete()

*/
  Future<List<T>> getList() async {
    Uri updatedUri = uri.replace(path: '/api/$_path');
    print('GetList uri $uri');
    final response = await http.get(
      updatedUri,
      headers: {'Content-Type': 'application/json'},
    );
    print('GetList response ${response.statusCode}   ${response.body}');
    if (response.statusCode == 200) {
      print('Response: $response.body');
      final json = jsonDecode(response.body);

      print('Response json: $json');
      return (json as List).map((item) => deserialize(item)).toList();
    } else {
      throw Exception('Failed to get list');
    }

    //return list;
  }

  Future<void> update({required int index, required T item}) async {
    list[index] = item;
  }

  Future<void> remove({required int index}) async {
    T item = list.elementAt(index);
    list.remove(item);
  }

  Future<void> readJsonFile(String filePath);
}
