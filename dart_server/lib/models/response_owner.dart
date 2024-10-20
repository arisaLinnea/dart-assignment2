import 'package:uuid/uuid.dart';

class ResponseOwner {
  String _id;
  String _name;
  String _ssn;

  ResponseOwner({required String name, required String ssn, String? id})
      : _id = id ??
            Uuid().v4(), //not a constant and can't be used as a default value
        _name = name,
        _ssn = ssn;

  String get id => _id;

  set name(String value) {
    _name = value;
  }

  set ssn(String value) {
    _ssn = value;
  }

  factory ResponseOwner.fromJson(Map<String, dynamic> json) {
    return ResponseOwner(
      id: json['id'],
      name: json['name'],
      ssn: json['ssn'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': _id,
        'name': _name,
        'ssn': _ssn,
      };

  @override
  String toString() {
    return 'Name: $_name, ssn: $_ssn';
  }

  bool isValid() {
    return true;
  }
}
