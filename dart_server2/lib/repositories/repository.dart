import 'dart:convert';
import 'dart:io';

abstract class Repository<T> {
  final String _filePath = 'db/fileStorage.json';

  Repository() {
    File file = File(_filePath);
    if (!file.existsSync()) {
      print('Create storage file');
      file.createSync(
          recursive: true); //recursive: true creates the directory too
    }
  }

  String get filePath => _filePath;

  Future<Map<String, dynamic>> getServerList(
      {required File file, required String name}) async {
    String fileContentAsJson = await file.readAsString();
    Map<String, dynamic> jsonmap = {};
    if (fileContentAsJson.isNotEmpty) {
      try {
        jsonmap = jsonDecode(fileContentAsJson);
      } catch (e) {
        throw FormatException('');
      }
    }

    List<dynamic> jsonList = [];

    if (jsonmap.containsKey(name)) {
      jsonList = (jsonmap[name] as List);
    }

    return {
      'list': jsonList,
      'map': jsonmap,
    };
  }

  Future<bool> addToList({required dynamic json});

  Future<T?> getElementById({required String id});

  Future<List<Map<String, dynamic>>> getList();

  Future<bool> update({required String id, required dynamic json});

  Future<bool> remove({required String id});

  T deserialize(Map<String, dynamic> json);

  Map<String, dynamic> serialize(T item);

  String itemAsString();
}
