class Owner {
  String? _id;
  String _name;
  String _ssn;

  Owner({required String name, required String ssn, String? id})
      : _id = id,
        _name = name,
        _ssn = ssn;

  String? get id => _id;

  set name(String value) {
    _name = value;
  }

  set ssn(String value) {
    _ssn = value;
  }

  factory Owner.fromJson(Map<String, dynamic> json) {
    return Owner(
      id: json['id'] != null ? json['startTime'] : null,
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
