import 'package:dart_server2/repositories/owner_repository.dart';
import 'package:dart_shared/dart_shared.dart';
import 'package:uuid/uuid.dart';

class VehicleFactory {
  static Future<Vehicle> fromServerJson(Map<String, dynamic> json) async {
    return Vehicle(
        id: json['id'],
        registrationNo: json['registrationNo'],
        type: VehicleType.values[json['type']],
        owner: await OwnerRepository().getElementById(id: json['ownerId']));
  }

  static Map<String, dynamic> toServerJson(Vehicle vehicle) {
    return {
      'id': vehicle.id != '-1' ? vehicle.id : Uuid().v4(),
      'registrationNo': vehicle.registrationNo,
      'type': vehicle.type.index,
      'ownerId': vehicle.owner?.id
    };
  }
}
