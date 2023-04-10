A simple Dart HTTP server using [package:shelf](https://pub.dev/packages/shelf).

- Listens on "any IP" (0.0.0.0) instead of loop-back (localhost, 127.0.0.1) to
  allow remote connections.
- Defaults to listening on port `8090`, but this can be configured by setting
  the `PORT` environment variable.

To run this server locally, run as follows:

```bash
dart run bin/server.dart
```
