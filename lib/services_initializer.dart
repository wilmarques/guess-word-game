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
    return WordLoaderService(
      child: child,
    );
  }
}
