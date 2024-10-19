import 'package:http/http.dart' as http;

abstract class Repository<T> {
  List<T> list = [];
  String _path;
  // Uri uri = Uri.parse("http://localhost:8080/");
  Uri uri = Uri(scheme: 'http', host: 'localhost', port: 8080);

  Repository({required String path}) : _path = path;

  void addToList({required T item}) {
    list.add(item);
  }

/*
/persons	GET	Hämta alla personer	getAll()
/persons	POST	Skapa ny person	create()
/persons/<id>	GET	Hämta specifik person	getById()
/persons/<id>	PUT	Uppdatera specifik person	update()
/persons/<id>	DELETE	Ta bort specifik person	delete()

httpsUri = Uri(
    scheme: 'https',
    host: 'example.com',
    path: '/page/',
    queryParameters: {'search': 'blue', 'limit': '10'});
print(httpsUri); // https://example.com/page/?search=blue&limit=10
*/
  Future<List<T>> getList() async {
    Uri updatedUri = uri.replace(path: '/$_path');
    print('URI: $uri');
    print('URI: $updatedUri');
    // final response = await http.get(
    //   updatedUri,
    //   headers: {'Content-Type': 'application/json'},
    // );

    // final json = jsonDecode(response.body);

    // return (json as List).map((item) => deserialize(item)).toList();

    return list;
  }

  Future<T> getElementById({required String id});

  Future<void> update({required int index, required T item}) async {
    list[index] = item;
  }

  Future<void> remove({required int index}) async {
    T item = list.elementAt(index);
    list.remove(item);
  }

  Future<void> readJsonFile(String filePath);
}
