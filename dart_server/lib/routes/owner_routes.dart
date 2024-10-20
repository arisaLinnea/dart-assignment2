import 'package:dart_server/handlers/owner_handle.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

Handler getOwnerRoutes() {
  final router = Router();

  router.get('/', getItemsHandler); // Add a new owner

  router.post('/', postItemHandler); // Get Owner list

  router.get('/user/<id>', (Request request, String id) {
    return Response.ok('Details for owner $id');
  });

  return router;
}
