import 'package:dart_server2/api/routes.dart';

import 'package:dart_server2/repositories/owner_repository.dart';
import 'package:dart_server2/repositories/parking_lot_repository.dart';
import 'package:dart_server2/repositories/parking_repository.dart';
import 'package:dart_server2/repositories/vehicle_repository.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class ServerConfig {
  ServerConfig._privateConstructor() {
    initialize();
  }

  static final ServerConfig _instance = ServerConfig._privateConstructor();

  static ServerConfig get instance => _instance;

  late Router router;

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
    Response _rootHandler(Request req) {
      return Response.notFound('Wrong path');
    }

    final router = Router()
      ..get('/', _rootHandler)
      ..post('/', _rootHandler)
      ..put('/', _rootHandler)
      ..delete('/', _rootHandler);

    return router;
  }
}
