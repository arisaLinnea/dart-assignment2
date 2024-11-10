import 'package:dart_shared/src/models/owner.dart';

enum VehicleType { None, Car, MC, Bicycle, Moped, Tractor }

class Vehicle {
  String? _id;
  String registrationNo;
  VehicleType type;
  Owner? owner;

  Vehicle(
      {required this.registrationNo,
      required this.type,
      required this.owner,
      String? id})
      : _id = id;

  String get id => _id ?? '-1';

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    var typeIndex = json['type'];

    Vehicle vehicle = Vehicle(
      id: json['id'],
      registrationNo: json['registrationNo'],
      type: VehicleType.values[typeIndex],
      owner: json['owner'] != null ? Owner.fromJson(json['owner']) : null,
    );
    return vehicle;
  }

  Map<String, dynamic> toJson() => {
        'id': _id,
        'registrationNo': registrationNo,
        'type': type.index,
        'owner': owner?.toJson()
      };

  @override
  String toString() {
    return 'RegistrationNo: $registrationNo, type: $type, owner: (${owner.toString()})';
  }
}
