import 'dart:io';

import 'package:dart_server/repositories/owner_repository.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:test/test.dart';

import 'owner_mock.dart';
import 'server_test.mocks.dart';

@GenerateMocks([OwnerRepository])
void main() {
  final port = '8080';
  final host = 'http://0.0.0.0:$port';
  // late Process p;

  // setUp(() async {
  //   p = await Process.start(
  //     'dart',
  //     ['run', 'bin/server.dart'],
  //     environment: {'PORT': port},
  //   );
  //   // Wait for server to start and print to stdout.
  //   await p.stdout.first;
  // });

  // tearDown(() => p.kill());

  group('Owner - ', () {
    late Process p;
    late MockOwnerRepository mockOwnerRepo;

    setUp(() async {
      mockOwnerRepo = MockOwnerRepository();
      p = await Process.start(
        'dart',
        [
          'run',
          'bin/server.dart',
          '--mockRepo=$mockOwnerRepo'
        ], // Pass the mock repository
        mode: ProcessStartMode.detached,
      );
      await Future.delayed(Duration(seconds: 1));
      // Wait for server to start and print to stdout.
      // await p.stdout.first;
    });
    tearDown(() => p.kill());
    test('get the list', () async {
      print('owner test: $ownerList');
      when(mockOwnerRepo.getList()).thenAnswer((_) => ownerList);
      print('owner test: ${ownerList[0].toJson()}');
      when(mockOwnerRepo.serialize(ownerList[0]))
          .thenAnswer((_) => ownerList[0].toJson());
      final response = await get(Uri.parse('$host/api/owner'));
      print('response: ${response.body}');
      expect(response.statusCode, 200);
      // expect(response.body, [ownerList[0].toJson()]);
    });
  });

  // test('Echo', () async {
  //   final response = await get(Uri.parse('$host/echo/hello'));
  //   expect(response.statusCode, 200);
  //   expect(response.body, 'hello\n');
  // });

  // test('404', () async {
  //   final response = await get(Uri.parse('$host/foobar'));
  //   expect(response.statusCode, 404);
  // });
}
