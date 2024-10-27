import 'package:dart_client/models/owner.dart';
import 'package:uuid/uuid.dart';

enum VehicleType { Car, MC, Bicycle, Moped, Tractor }

class Vehicle {
  String _id;
  String _registrationNo;
  VehicleType _type;
  Owner _owner;

  // Vehicle(this.registrationNo, this.type, this.owner);
  Vehicle(
      {required String registrationNo,
      required VehicleType type,
      required Owner owner,
      String? id})
      : _id = id ?? Uuid().v4(),
        _registrationNo = registrationNo,
        _type = type,
        _owner = owner;

  String get id => _id;

  set registrationNo(String value) {
    _registrationNo = value;
  }

  set type(VehicleType value) {
    _type = value;
  }

  set owner(Owner value) {
    _owner = value;
  }

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      id: json['id'],
      registrationNo: json['registrationNo'],
      type: VehicleType.values.firstWhere((e) => e.name == json['type']),
      owner: Owner.fromJson(json['owner']),
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
