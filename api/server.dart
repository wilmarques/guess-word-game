import 'dart:convert';
import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_router/shelf_router.dart' as shelf_router;

Future<void> main() async {
  final port = int.parse(Platform.environment['PORT'] ?? '8090');

  final cascade = Cascade().add(_router.call);

  // See https://pub.dev/documentation/shelf/latest/shelf_io/serve.html
  final server = await shelf_io.serve(
    // See https://pub.dev/documentation/shelf/latest/shelf/logRequests.html
    logRequests()
        // See https://pub.dev/documentation/shelf/latest/shelf/MiddlewareExtensions/addHandler.html
        .addHandler(cascade.handler),
    InternetAddress.anyIPv4, // Allows external connections
    port,
  );

  print('Serving at http://${server.address.host}:${server.port}');
}

final _router = shelf_router.Router()
  ..get('/generate_word', _generateWordHandler);

String _jsonEncode(Object? data) =>
    const JsonEncoder.withIndent(' ').convert(data);

const _jsonHeaders = {
  'content-type': 'application/json',
};

Response _generateWordHandler(Request request) {
  const response = {
    'word': 'Table',
    'definitions': [
      'Where you put your plate to have a dinner',
    ],
  };

  return Response.ok(
    _jsonEncode(response),
    headers: {
      ..._jsonHeaders,
    },
  );
}
