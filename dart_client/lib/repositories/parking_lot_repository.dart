import 'package:dart_shared/dart_shared.dart';
import 'package:dart_client/repositories/repository.dart';

class ParkingLotRepository extends Repository<ParkingLot> {
  static final ParkingLotRepository _instance =
      ParkingLotRepository._internal(path: 'parkinglot');

  ParkingLotRepository._internal({required super.path});

  factory ParkingLotRepository() => _instance;

  @override
  Future<ParkingLot> getElementById({required String id}) {
    // TODO: implement getElementById
    throw UnimplementedError();
  }

  @override
  ParkingLot deserialize(Map<String, dynamic> json) =>
      ParkingLot.fromJson(json);

  @override
  Map<String, dynamic> serialize(ParkingLot item) => item.toJson();
}
