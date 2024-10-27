import 'package:dart_server/api/handle.dart';
import 'package:dart_server/repositories/repository.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

Handler getRoutes(Repository repo) {
  final router = Router();

  // Get list
  router.get('/', (Request request) {
    print("handler");
    return getListHandler(request, repo);
  });

  // Add a new value
  router.post('/', (Request request) {
    return addItemHandler(request, repo);
  });

  // Update a value
  router.put('/<index>', (Request request, String index) {
    return updateItemHandler(request, index, repo);
  });

  // Remove an item from the list
  router.delete('/<index>', (Request request, String index) {
    return removeItemHandler(request, index, repo);
  });

  // Get a specific item
  router.get('/<id>', (Request request, String id) {
    return getItemByIdHandler(request, id, repo);
  });

  return router;
}
