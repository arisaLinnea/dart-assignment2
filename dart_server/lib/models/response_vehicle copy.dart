import 'package:uuid/uuid.dart';

import 'package:dart_server/models/response_owner.dart';

enum ResponseVehicleType { Car, MC, Bicycle, Moped, Tractor }

class ResponseVehicle {
  String _id;
  String _registrationNo;
  ResponseVehicleType _type;
  ResponseOwner _owner;

  ResponseVehicle(
      {required String registrationNo,
      required ResponseVehicleType type,
      required ResponseOwner owner,
      String? id})
      : _id = id ?? Uuid().v4(),
        _registrationNo = registrationNo,
        _type = type,
        _owner = owner;

  String get id => _id;

  set registrationNo(String value) {
    _registrationNo = value;
  }

  set type(ResponseVehicleType value) {
    _type = value;
  }

  set owner(ResponseOwner value) {
    _owner = value;
  }

  factory ResponseVehicle.fromJson(Map<String, dynamic> json) {
    return ResponseVehicle(
      id: json['id'],
      registrationNo: json['registrationNo'],
      type:
          ResponseVehicleType.values.firstWhere((e) => e.name == json['type']),
      owner: ResponseOwner.fromJson(json['owner']),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': _id,
        'registrationNo': _registrationNo,
        'type': _type.name,
        'owner': _owner.toJson()
      };

  @override
  String toString() {
    return 'RegistrationNo: $_registrationNo, type: $_type, owner: (${_owner.toString()})';
  }
}
