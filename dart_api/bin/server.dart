import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';

// Configure routes.
final _router = Router()
  ..get('/', _rootHandler)
  ..get('/echo/<message>', _echoHandler);

Response _rootHandler(Request req) {
  return Response.ok('Hello, World!\n');
}

Response _echoHandler(Request request) {
  final message = request.params['message'];
  return Response.ok('$message\n');
}

void main(List<String> args) async {
  // Use any available host or container IP (usually `0.0.0.0`).
  final ip = InternetAddress.anyIPv4;

  // Configure a pipeline that logs requests.
  final handler = Pipeline().addMiddleware(logRequests()).addHandler(_router);

  // For running in containers, we respect the PORT environment variable.
  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final server = await serve(handler, ip, port);
  print('Server listening on port ${server.port}');
}



/*
lib/routes/parking_routes.dart
lib/routes/user_routes.dart
lib/routes/auth_routes.dart

-------------



// lib/server.dart
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_router/shelf_router.dart';

import 'routes/parking_routes.dart';
import 'routes/user_routes.dart';

void main() async {
  final handler = const Pipeline()
      .addMiddleware(logRequests())
      .addHandler(_router);

  var server = await shelf_io.serve(handler, 'localhost', 8080);
  print('Serving at http://${server.address.host}:${server.port}');
}

final _router = Router()
  ..mount('/api/parking', getParkingRoutes())  // Mount parking routes
  ..mount('/api/users', getUserRoutes());     // Mount user routes


----------

// lib/routes/user_routes.dart
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

Handler getUserRoutes() {
  final router = Router();

  // Define user-related routes
  router.get('/user', (Request request) {
    return Response.ok('List of users');
  });

  router.get('/user/<id>', (Request request, String id) {
    return Response.ok('Details for user $id');
  });

  return router;
}

-------

// lib/routes/parking_routes.dart
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

Handler getParkingRoutes() {
  final router = Router();

  // Define parking-related routes
  router.get('/parking', (Request request) {
    return Response.ok('List of parking spots');
  });

  router.get('/parking/<id>', (Request request, String id) {
    return Response.ok('Details for parking spot $id');
  });

  return router;
}


*/