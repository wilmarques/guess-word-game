import 'package:flutter/widgets.dart';

import 'services/word_loader_service.dart';

class ServicesInitializer extends StatelessWidget {
  const ServicesInitializer({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    // TODO (next): See how Theme.of(context) works
    // They really put each service on a new line?
    return WordLoaderService(
      child: child,
    );
  }
}
