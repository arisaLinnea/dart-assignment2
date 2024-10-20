abstract class Repository<T> {
  final List<T> _list = [];
  void addToList({required T item}) {
    _list.add(item);
  }

  List<T> getList() {
    return _list;
  }

  T getElementById({required String id});

  void update({required int index, required T item}) {
    _list[index] = item;
  }

  void remove({required int index}) {
    T item = _list.elementAt(index);
    _list.remove(item);
  }

  void readJsonFile(String filePath);
}
