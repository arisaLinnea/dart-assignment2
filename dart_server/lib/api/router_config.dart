import 'package:dart_server/api/routes.dart';
import 'package:dart_server/db/database.dart';
import 'package:dart_server/repositories/owner_repository.dart';
import 'package:dart_server/repositories/parking_lot_repository.dart';
import 'package:dart_server/repositories/parking_repository.dart';
import 'package:dart_server/repositories/vehicle_repository.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class ServerConfig {
  ServerConfig._privateConstructor() {
    initialize();
  }

  static final ServerConfig _instance = ServerConfig._privateConstructor();

  static ServerConfig get instance => _instance;

  late Router router;

  late final database = ParkingDatabase();

  final OwnerRepository ownerRepo = OwnerRepository();
  final VehicleRepository vehicleRepo = VehicleRepository();
  final ParkingLotRepository parkingLotRepo = ParkingLotRepository();
  final ParkingRepository parkingRepo = ParkingRepository();

  Future initialize() async {
    // Configure routes.
    router = Router()
      ..mount('/api/owner', getRoutes(ownerRepo))
      ..mount('/api/vehicle', getRoutes(vehicleRepo))
      ..mount('/api/parkinglot', getRoutes(parkingLotRepo))
      ..mount('/api/parking', getRoutes(parkingRepo))
      ..mount('/*', wrongPathHandler());
  }

  Handler wrongPathHandler() {
    Response rootHandler(Request req) {
      return Response.badRequest(body: 'Wrong path');
    }

    final router = Router()
      ..get('/', rootHandler)
      ..post('/', rootHandler)
      ..put('/', rootHandler)
      ..delete('/', rootHandler);

    return router;
  }
}
