import 'dart:io';

import 'package:dart_server/repositories/owner_repository.dart';
import 'package:dart_server/repositories/parking_lot_repository.dart';
import 'package:dart_server/repositories/parking_repository.dart';
import 'package:dart_server/repositories/repository.dart';
import 'package:dart_server/repositories/vehicle_repository.dart';
import 'package:dart_server/api/routes.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';

final OwnerRepository ownerRepo = OwnerRepository();
final VehicleRepository vehicleRepo = VehicleRepository();
final ParkingLotRepository parkingLotRepo = ParkingLotRepository();
final ParkingRepository parkingRepo = ParkingRepository();

void main(List<String> args, {Repository? mockRepo}) async {
  // Use any available host or container IP (usually `0.0.0.0`).
  final ip = InternetAddress.anyIPv4;

  print('server log');

  // Configure routes.
  final router = Router()
    ..mount('/api/owner', getRoutes(mockRepo ?? ownerRepo))
    ..mount('/api/vehicle', getRoutes(vehicleRepo))
    ..mount('/api/parkinglot', getRoutes(parkingLotRepo))
    ..mount('/api/parking', getRoutes(parkingRepo));

  // Configure a pipeline that logs requests.
  final handler = Pipeline().addMiddleware(logRequests()).addHandler(router);

  // For running in containers, we respect the PORT environment variable.
  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final server = await serve(handler, ip, port);
  print('Server listening on port ${server.port}');
}
