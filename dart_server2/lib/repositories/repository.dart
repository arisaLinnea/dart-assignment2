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
    if (fileContentAsJson != "") {
      jsonmap = jsonDecode(fileContentAsJson);
    }
    List<dynamic> jsonList = [];

    if (jsonmap[name] != null) {
      jsonList = (jsonmap[name] as List);
    }

    return {
      'list': jsonList,
      'map': jsonmap,
    };
  }

  void addToList({required dynamic json});

  Future<T?> getElementById({required String id});

  Future<List<Map<String, dynamic>>> getList();

  void update({required String id, required dynamic json});

  void remove({required String id});

  T deserialize(Map<String, dynamic> json);

  Map<String, dynamic> serialize(T item);
}
